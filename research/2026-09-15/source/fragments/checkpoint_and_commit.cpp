class Work {
    const retro::Index&idx;const Options&o;
    fs::path base,work_path,resume_path,final_path,complete_path;
    FILE*data_file=nullptr;
public:
    const retro::Bucket&b;
    u64 chunks,words;
    std::vector<u64> bits,chunk_p,chunk_hash;
    std::unique_ptr<std::atomic<uint8_t>[]> done;
    std::vector<uint8_t> saved;
    Work(const retro::Index&i,const retro::Bucket&bucket,const Options&op):idx(i),o(op),b(bucket) {
        base=o.data/fs::u8path(stem(b.n,b.h));work_path=base;work_path+=".work";
        resume_path=base;resume_path+=".resume";final_path=base;final_path+=".bits";
        complete_path=base;complete_path+=".complete.json";
        chunks=(b.size+o.chunk_states-1)/o.chunk_states;words=(b.size+63)/64;
        bits.assign(words,0);chunk_p.assign(chunks,0);chunk_hash.assign(chunks,0);saved.assign(chunks,0);
        done=std::make_unique<std::atomic<uint8_t>[]>(chunks);
        for(u64 c=0;c<chunks;++c)done[c].store(0);
        bool resume=fs::exists(resume_path)&&!o.force;
        if(resume) {
            FILE*f=open_file(resume_path,"rb");char magic[8]{};
            if(fread(magic,1,8,f)!=8||std::memcmp(magic,"MJGRT001",8)
               ||get<uint32_t>(f)!=1||get<uint32_t>(f)!=u64(b.n)||get<uint32_t>(f)!=u64(b.h)
               ||get<u64>(f)!=o.chunk_states||get<u64>(f)!=b.size||get<u64>(f)!=chunks
               ||get<u64>(f)!=idx.fingerprint) {fclose(f);throw std::runtime_error("checkpoint layout mismatch");}
            for(u64 c=0;c<chunks;++c) {
                saved[c]=get<uint8_t>(f);chunk_hash[c]=get<u64>(f);chunk_p[c]=get<u64>(f);
                if(saved[c]>1)throw std::runtime_error("invalid checkpoint done flag");
            }
            if(fgetc(f)!=EOF)throw std::runtime_error("trailing checkpoint bytes");fclose(f);
            if(!fs::exists(work_path)&&fs::exists(final_path))replace_file(final_path,work_path);
            if(!fs::exists(work_path)||fs::file_size(work_path)!=words*8)throw std::runtime_error("checkpoint payload length mismatch");
            data_file=open_file(work_path,"r+b");
            if(fread(bits.data(),8,words,data_file)!=words)throw std::runtime_error("short checkpoint payload");
            for(u64 c=0;c<chunks;++c)if(saved[c]) {
                const u64 begin=c*o.chunk_states/64,end=std::min(words,(c+1)*o.chunk_states/64);
                if(hash_words(bits.data()+begin,end-begin)!=chunk_hash[c])throw std::runtime_error("checkpoint chunk checksum mismatch");
                u64 count=0;for(u64 w=begin;w<end;++w)count+=__builtin_popcountll(bits[w]);
                if(count!=chunk_p[c])throw std::runtime_error("checkpoint P count mismatch");
                done[c].store(1);
            }
        } else {
            data_file=open_file(work_path,"w+b");
#ifdef _WIN32
            if(_chsize_s(_fileno(data_file),words*8))throw std::runtime_error("cannot size checkpoint payload");
#else
            if(ftruncate(fileno(data_file),words*8))throw std::runtime_error("cannot size checkpoint payload");
#endif
        }
    }
    ~Work(){if(data_file)fclose(data_file);}
    u64 states_done()const {u64 z=0;for(u64 c=0;c<chunks;++c)if(done[c].load(std::memory_order_acquire))z+=std::min(o.chunk_states,b.size-c*o.chunk_states);return z;}
    u64 p_count()const {u64 z=0;for(u64 c=0;c<chunks;++c)if(done[c].load(std::memory_order_acquire))z+=chunk_p[c];return z;}
    void checkpoint() {
        for(u64 c=0;c<chunks;++c)if(!saved[c]&&done[c].load(std::memory_order_acquire)) {
            const u64 begin=c*o.chunk_states/64,end=std::min(words,(c+1)*o.chunk_states/64);
            seek_file(data_file,begin*8);
            if(fwrite(bits.data()+begin,8,end-begin,data_file)!=end-begin)throw std::runtime_error("short checkpoint chunk write");
            saved[c]=1;
        }
        flush_file(data_file);
        fs::path tmp=resume_path;tmp+=".tmp";
        FILE*f=open_file(tmp,"wb");fwrite("MJGRT001",1,8,f);
        put<uint32_t>(f,1);put<uint32_t>(f,b.n);put<uint32_t>(f,b.h);
        put<u64>(f,o.chunk_states);put<u64>(f,b.size);put<u64>(f,chunks);put<u64>(f,idx.fingerprint);
        for(u64 c=0;c<chunks;++c){put<uint8_t>(f,saved[c]);put<u64>(f,saved[c]?chunk_hash[c]:0);put<u64>(f,saved[c]?chunk_p[c]:0);}
        flush_file(f);fclose(f);replace_file(tmp,resume_path);
    }
    void finish() {
        if(states_done()!=b.size)throw std::runtime_error("refusing incomplete bucket finalization");
        checkpoint();fclose(data_file);data_file=nullptr;replace_file(work_path,final_path);
        std::ostringstream j;
        j<<"{\"schema\":\""<<SCHEMA<<"\",\"completed\":true,\"index_fingerprint\":\""<<hex64(idx.fingerprint)
         <<"\",\"build_id\":\""<<RETRO_BUILD_ID<<"\",\"n\":"<<b.n<<",\"h\":"<<b.h
         <<",\"honor_code\":"<<idx.honors[b.h].code<<",\"states\":"<<b.size
         <<",\"p_states\":"<<p_count()<<",\"word_count\":"<<words
         <<",\"chunk_states\":"<<o.chunk_states<<",\"payload_hash64\":\""<<hex64(hash_words(bits.data(),words))<<"\"}\n";
        write_text_atomic(complete_path,j.str());
    }
};

