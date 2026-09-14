class Tables {
    const retro::Index&idx;const Options&o;Stats&s;
    std::map<std::pair<int,int>,std::shared_ptr<Table>> cache;
    u64 tick=0;
public:
    Tables(const retro::Index&i,const Options&op,Stats&st):idx(i),o(op),s(st){}
    void trim(u64 reserve=0) {
        for(;;) {
            u64 bytes=0;auto victim=cache.end();
            for(auto it=cache.begin();it!=cache.end();++it) {
                bytes+=it->second->bytes();
                if(it->second.use_count()==1&&(victim==cache.end()||it->second->tick<victim->second->tick))victim=it;
            }
            if(bytes+reserve<=o.cache_limit||victim==cache.end())break;
            cache.erase(victim);
        }
    }
    std::shared_ptr<Table> load(int n,int h) {
        const auto key=std::make_pair(n,h);
        if(auto it=cache.find(key);it!=cache.end()){it->second->tick=++tick;return it->second;}
        const auto began=steady::now();
        auto t=std::make_shared<Table>();t->bucket=idx.make_bucket(n,h);t->tick=++tick;
        trim((t->bucket.size+7)/8+t->bytes());
        if(t->bucket.size) {
            auto base=o.input/fs::u8path(stem(n,h));
            fs::path meta=base;meta+=".complete.json";
            fs::path file=base;file+=".bits";
            if(!fs::exists(meta)||!fs::exists(file))throw std::runtime_error("missing completed dependency "+base.u8string());
            std::string j=slurp(meta);
            const size_t words=(t->bucket.size+63)/64;
            if(jstring(j,"schema")!=SCHEMA||!jtrue(j,"completed")
               ||jstring(j,"index_fingerprint")!=hex64(idx.fingerprint)
               ||jnumber(j,"n")!=u64(n)||jnumber(j,"h")!=u64(h)
               ||jnumber(j,"honor_code")!=idx.honors[h].code
               ||jnumber(j,"states")!=t->bucket.size||jnumber(j,"word_count")!=words
               ||fs::file_size(file)!=words*8)throw std::runtime_error("dependency metadata mismatch "+base.u8string());
            t->bits.resize(words);
            FILE*f=open_file(file,"rb");
            const size_t read=fread(t->bits.data(),8,words,f);fclose(f);
            if(read!=words)throw std::runtime_error("short dependency read");
            s.loaded_bytes+=words*8;
            u64 count=0;
            for(u64 w:t->bits)count+=__builtin_popcountll(w);
            if(count!=jnumber(j,"p_states")||hash_words(t->bits.data(),words)!=std::stoull(jstring(j,"payload_hash64"),nullptr,16))
                throw std::runtime_error("dependency payload checksum mismatch "+base.u8string());
            if((t->bucket.size&63)&&(t->bits.back()>>(t->bucket.size&63)))
                throw std::runtime_error("nonzero dependency padding");
            t->p=count;t->all_p=(count==t->bucket.size);
            if(t->all_p||t->p==0)std::vector<u64>().swap(t->bits);
            if(t->p==0){std::vector<u64>().swap(t->bucket.offsets);std::vector<retro::Block>().swap(t->bucket.blocks);}
        }
        s.load_seconds+=elapsed(began);cache[key]=t;trim();return t;
    }
};
