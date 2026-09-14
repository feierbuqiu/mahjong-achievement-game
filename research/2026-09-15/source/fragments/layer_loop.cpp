int main(int argc,char**argv) {
    try {
        const Options o=options(argc,argv);fs::create_directories(o.data);
        std::signal(SIGINT,signal_stop);std::signal(SIGTERM,signal_stop);
        Stats s;s.threads=o.threads;
        retro::Index idx;
        MovePlans plans(idx);
        std::cout<<"{\"event\":\"initialized\",\"schema\":\""<<SCHEMA
                 <<"\",\"index_fingerprint\":\""<<hex64(idx.fingerprint)
                 <<"\",\"numeric_codes\":"<<idx.numeric.size()<<",\"honor_codes\":"<<idx.honors.size()
                 <<",\"threads\":"<<o.threads<<",\"seconds\":"<<elapsed(s.began)
                 <<",\"private_bytes\":"<<private_bytes()<<"}\n"<<std::flush;
        Tables tables(idx,o,s);
        for(int n=o.max_layer;n>=o.min_layer;--n) {
            for(int h=0;h<int(idx.honors.size());++h) {
                if(o.only_h>=0&&h!=o.only_h)continue;
                if(stop_requested(o,s)){s.phase="stopped";auto j=progress_json(s,idx,o,true);write_text_atomic(o.progress,j);std::cout<<j;return 2;}
                s.n=n;s.h=h;s.phase="loading";
                auto bucket=idx.make_bucket(n,h);if(!bucket.size)continue;
                if(valid_complete(idx,o,n,h,bucket.size)){++s.skipped_buckets;continue;}
                std::vector<std::shared_ptr<Table>> children;
                if(n<34) {
                    children.push_back(tables.load(n+1,h));
                    const auto&honor=idx.honors[h];
                    for(unsigned k=0;k<honor.next_count;++k)children.push_back(tables.load(n+1,honor.next[k]));
                }
                tables.trim();
                if(!solve_bucket(idx,bucket,children,plans,o,s)) {
                    s.phase="stopped";auto j=progress_json(s,idx,o,true);write_text_atomic(o.progress,j);std::cout<<j;return 2;
                }
            }
        }
        s.phase="requested_layers_complete";auto j=progress_json(s,idx,o,true);write_text_atomic(o.progress,j);std::cout<<j;
        return 0;
    }catch(const std::exception&e){std::cerr<<"global_retro failure: "<<e.what()<<"\n";return 1;}
}
