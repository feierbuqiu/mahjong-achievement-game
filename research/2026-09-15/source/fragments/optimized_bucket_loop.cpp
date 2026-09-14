static bool solve_bucket(const retro::Index&idx,const retro::Bucket&b,
                         const std::vector<std::shared_ptr<Table>>&children,
                         const MovePlans&plans,const Options&o,Stats&s) {
    Work w(idx,b,o);
    const u64 initial=w.states_done();s.resumed_states+=initial;s.current_size=b.size;
    s.current_done=initial;s.current_p=w.p_count();
    std::atomic<u64> next_chunk{0};std::atomic<int> running{o.threads};
    std::atomic<bool> stop{false};std::exception_ptr error;std::mutex error_lock;
    std::mutex finished_mutex;std::condition_variable finished;
    const auto began=steady::now();double last_save=0,last_progress=0,last_print=0;
    const bool whole_bucket_p=std::none_of(children.begin(),children.end(),[](const auto&t){return t->p!=0;});
    std::vector<std::thread> workers;
    // children[0] is same-honor numeric successor bucket; the rest are honor steps.
    auto worker=[&] {
        try {
            std::array<std::vector<u64>,3> move_offsets;
            for(auto&row:move_offsets)row.assign(plans.first.size(),retro::BAD_RANK);
            uint32_t planned_tid=retro::BAD_ID;bool use_plan=false;
            for(;;) {
                if(stop.load(std::memory_order_relaxed))break;
                const u64 chunk=next_chunk.fetch_add(1);
                if(chunk>=w.chunks)break;
                if(w.done[chunk].load(std::memory_order_acquire))continue;
                const u64 first=chunk*o.chunk_states,last=std::min(b.size,first+o.chunk_states);
                u64 p=0,candidates=0,lookups=0;
                if(whole_bucket_p) {
                    const u64 bw=first/64,ew=(last+63)/64;
                    for(u64 k=bw;k<ew;++k)w.bits[k]=~0ULL;
                    if((last&63)&&last==b.size)w.bits[ew-1]=(1ULL<<(last&63))-1;
                    w.chunk_p[chunk]=last-first;w.chunk_hash[chunk]=hash_words(w.bits.data()+bw,ew-bw);
                    w.done[chunk].store(1,std::memory_order_release);
                    s.new_states.fetch_add(last-first,std::memory_order_relaxed);
                    continue;
                }
                auto cursor=idx.cursor(b,first);
                bool abandoned=false;
                for(u64 rank=first;rank<last;) {
                    if(stop.load(std::memory_order_relaxed)){abandoned=true;break;}
                    u64 word=0;
                    const u64 end=std::min(last,rank+64);
                    for(;rank<end;++rank) {
                        if(cursor.tid!=planned_tid) {
                            planned_tid=cursor.tid;
                            use_plan=!children.empty()&&children[0]->p&&plans.prepare(idx,*children[0],cursor.ids,move_offsets);
                        }
                        bool losing=true;
                        // Honor moves keep the numeric block and class-internal rank.
                        for(size_t k=1;k<children.size();++k) {
                            const Table&t=*children[k];
                            if(!t.p)continue;
                            ++candidates;
                            const u64 offset=t.bucket.offsets[cursor.tid];
                            if(offset==retro::BAD_RANK)continue;
                            ++lookups;
                            if(t.is_p(offset+cursor.within)){losing=false;break;}
                        }
                        if(losing&&!children.empty()&&children[0]->p) {
                            const Table&t=*children[0];
                            for(int suit=0;suit<3&&losing;++suit) {
                                if(suit&&cursor.ids[suit]==cursor.ids[suit-1])continue;
                                const auto&local=idx.numeric[cursor.ids[suit]];
                                for(unsigned a=0;a<local.next_count;++a) {
                                    ++candidates;
                                    const uint32_t target=local.next[a];
                                    u64 offset=0;
                                    if(use_plan) {
                                        offset=move_offsets[suit][idx.numeric[target].group];
                                        if(offset==retro::BAD_RANK)continue;
                                    }
                                    auto ids=cursor.ids;ids[suit]=target;
                                    if(suit==0&&ids[0]>ids[1])std::swap(ids[0],ids[1]);
                                    if(suit<2&&ids[1]>ids[2])std::swap(ids[1],ids[2]);
                                    const u64 child=use_plan?offset+idx.within_sorted(ids):idx.rank_sorted(t.bucket,ids);
                                    if(child==retro::BAD_RANK)continue;
                                    ++lookups;
                                    if(t.is_p(child)){losing=false;break;}
                                }
                            }
                        }
                        if(losing){word|=1ULL<<(rank&63);++p;}
                        if(rank+1<last)cursor.advance();
                    }
                    w.bits[(rank-1)>>6]=word;
                }
                s.candidate_edges.fetch_add(candidates,std::memory_order_relaxed);
                s.lookup_edges.fetch_add(lookups,std::memory_order_relaxed);
                if(abandoned)continue;
                const u64 bw=first/64,ew=(last+63)/64;
                w.chunk_p[chunk]=p;w.chunk_hash[chunk]=hash_words(w.bits.data()+bw,ew-bw);
                w.done[chunk].store(1,std::memory_order_release);
                s.new_states.fetch_add(last-first,std::memory_order_relaxed);
            }
        }catch(...){std::lock_guard<std::mutex>g(error_lock);if(!error)error=std::current_exception();stop.store(true);}
        if(running.fetch_sub(1)==1)finished.notify_one();
    };
    s.phase="computing";
    for(int t=0;t<o.threads;++t)workers.emplace_back(worker);
    try {
        while(running.load()) {
            if(stop_requested(o,s))stop.store(true);
            const double now=elapsed(began);
            if(now-last_save>=o.checkpoint_seconds) {
                s.phase="checkpointing";auto st=steady::now();w.checkpoint();
                s.checkpoint_seconds+=elapsed(st);last_save=elapsed(began);s.phase="computing";
            }
            if(now-last_progress>=1) {
                s.current_done=w.states_done();s.current_p=w.p_count();
                write_text_atomic(o.progress,progress_json(s,idx,o));
                last_progress=now;
            }
            if(now-last_print>=30) {std::cout<<progress_json(s,idx,o)<<std::flush;last_print=now;}
            std::unique_lock<std::mutex>lock(finished_mutex);
            finished.wait_for(lock,std::chrono::milliseconds(100),[&]{return running.load()==0;});
        }
    }catch(...){stop.store(true);for(auto&t:workers)t.join();throw;}
    for(auto&t:workers)t.join();
    if(error)std::rethrow_exception(error);
    s.compute_seconds+=elapsed(began);s.current_done=w.states_done();s.current_p=w.p_count();
    s.phase="checkpointing";auto st=steady::now();
    const bool complete=s.current_done==b.size;
    if(complete){w.finish();++s.completed_buckets;}else w.checkpoint();
    s.checkpoint_seconds+=elapsed(st);
    s.phase=complete?"bucket_complete":"stopped";
    auto output=progress_json(s,idx,o);write_text_atomic(o.progress,output);std::cout<<output<<std::flush;
    return complete;
}

