static bool valid_complete(const retro::Index&idx,const Options&o,int n,int h,u64 size) {
    auto base=o.data/fs::u8path(stem(n,h));auto p=base;p+=".complete.json";auto f=base;f+=".bits";
    if(!fs::exists(p)||o.force)return false;
    std::string j=slurp(p);
    if(jstring(j,"schema")!=SCHEMA||!jtrue(j,"completed")
       ||jstring(j,"index_fingerprint")!=hex64(idx.fingerprint)
       ||jnumber(j,"n")!=u64(n)||jnumber(j,"h")!=u64(h)||jnumber(j,"states")!=size
       ||jnumber(j,"honor_code")!=idx.honors[h].code||jnumber(j,"word_count")!=(size+63)/64
       ||!fs::exists(f)||fs::file_size(f)!=((size+63)/64)*8)
        throw std::runtime_error("completed output metadata mismatch "+base.u8string());
    // Validate a skipped final bucket too, including when no parent is requested.
    FILE* file=open_file(f,"rb");
    std::vector<u64> buffer(1U<<17);
    u64 remain=(size+63)/64,hash=1469598103934665603ULL,pcount=0,last=0;
    while(remain) {
        const size_t want=size_t(std::min<u64>(remain,buffer.size()));
        if(fread(buffer.data(),8,want,file)!=want){fclose(file);throw std::runtime_error("short completed output read");}
        for(size_t k=0;k<want;++k){last=buffer[k];hash^=last;hash*=1099511628211ULL;pcount+=__builtin_popcountll(last);}
        remain-=want;
    }
    fclose(file);
    if(hash!=std::stoull(jstring(j,"payload_hash64"),nullptr,16)||pcount!=jnumber(j,"p_states")
       ||((size&63)&&(last>>(size&63))))
        throw std::runtime_error("completed output payload checksum mismatch "+base.u8string());
    return true;
}

