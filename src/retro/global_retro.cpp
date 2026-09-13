// Exact physical SAFE P/N retrograde solver. P=1; N=0.
// Only completed chunks/buckets are outcomes. Unknown is never inferred from 0.
#include "global_index.hpp"
#include <atomic>
#include <thread>
#include <filesystem>
#include <fstream>
#include <sstream>
#include <iomanip>
#include <cstdio>
#include <cstring>
#include <csignal>
#include <mutex>
#include <condition_variable>
#include <list>
#include <memory>
#include <limits>
#include <cstdlib>
#ifdef _WIN32
#include <io.h>
#else
#include <unistd.h>
#endif

namespace fs = std::filesystem;
using steady = std::chrono::steady_clock;
using u64 = uint64_t;
static constexpr const char* SCHEMA = "MJGLOBAL_PN_V1";
#ifndef RETRO_BUILD_ID
#define RETRO_BUILD_ID "development"
#endif
static std::atomic<bool> interrupted{false};
static void signal_stop(int) { interrupted.store(true); }
static double elapsed(steady::time_point t) {
    return std::chrono::duration<double>(steady::now()-t).count();
}
static u64 hash_words(const u64* p, size_t count) {
    u64 h=1469598103934665603ULL;
    for(size_t i=0;i<count;++i) { h^=p[i];h*=1099511628211ULL; }
    return h;
}
static std::string hex64(u64 x) {
    std::ostringstream o;o<<std::hex<<std::setw(16)<<std::setfill('0')<<x;return o.str();
}
static std::string slurp(const fs::path& p) {
    std::ifstream f(p,std::ios::binary);
    if(!f)throw std::runtime_error("cannot read "+p.u8string());
    return std::string(std::istreambuf_iterator<char>(f),{});
}
static std::string jstring(const std::string& s,const std::string& k) {
    size_t at=s.find("\""+k+"\"");
    if(at==std::string::npos)throw std::runtime_error("missing JSON field "+k);
    at=s.find(':',at);at=s.find('"',at+1);
    const size_t end=s.find('"',at+1);
    if(at==std::string::npos||end==std::string::npos)throw std::runtime_error("bad JSON string "+k);
    return s.substr(at+1,end-at-1);
}
static u64 jnumber(const std::string& s,const std::string& k) {
    size_t at=s.find("\""+k+"\"");
    if(at==std::string::npos)throw std::runtime_error("missing JSON number "+k);
    at=s.find(':',at)+1;at=s.find_first_not_of(" \r\n\t",at);
    if(at==std::string::npos||s[at]<'0'||s[at]>'9')throw std::runtime_error("bad JSON number "+k);
    return std::stoull(s.substr(at));
}
static bool jtrue(const std::string& s,const std::string& k) {
    size_t at=s.find("\""+k+"\"");
    if(at==std::string::npos)return false;
    at=s.find(':',at)+1;at=s.find_first_not_of(" \r\n\t",at);
    return s.compare(at,4,"true")==0;
}
static void replace_file(const fs::path& from,const fs::path& to) {
#ifdef _WIN32
    for(int i=0;i<30;++i) {
        if(MoveFileExW(from.c_str(),to.c_str(),MOVEFILE_REPLACE_EXISTING|MOVEFILE_WRITE_THROUGH))return;
        std::this_thread::sleep_for(std::chrono::milliseconds(100));
    }
    throw std::runtime_error("atomic replacement failed "+to.u8string());
#else
    fs::rename(from,to);
#endif
}
static FILE* open_file(const fs::path& p,const char* mode) {
#ifdef _WIN32
    std::wstring wmode;for(const char*c=mode;*c;++c)wmode+=wchar_t(*c);
    FILE* f=_wfopen(p.c_str(),wmode.c_str());
#else
    FILE* f=std::fopen(p.c_str(),mode);
#endif
    if(!f)throw std::runtime_error("cannot open "+p.u8string());
    return f;
}
static void seek_file(FILE* f,u64 position) {
#ifdef _WIN32
    if(_fseeki64(f,position,SEEK_SET))throw std::runtime_error("seek failed");
#else
    if(fseeko(f,position,SEEK_SET))throw std::runtime_error("seek failed");
#endif
}
static void flush_file(FILE* f) {
    if(fflush(f))throw std::runtime_error("flush failed");
#ifdef _WIN32
    if(_commit(_fileno(f)))throw std::runtime_error("disk commit failed");
#else
    if(fsync(fileno(f)))throw std::runtime_error("disk sync failed");
#endif
}
static void write_text_atomic(const fs::path& path,const std::string& s) {
    if(path.empty())return;
    if(!path.parent_path().empty())fs::create_directories(path.parent_path());
    fs::path tmp=path;tmp+=".tmp";
    FILE* f=open_file(tmp,"wb");
    if(fwrite(s.data(),1,s.size(),f)!=s.size()){fclose(f);throw std::runtime_error("short text write");}
    flush_file(f);fclose(f);replace_file(tmp,path);
}
template<class T>static void put(FILE*f,const T&v){if(fwrite(&v,sizeof(v),1,f)!=1)throw std::runtime_error("short checkpoint write");}
template<class T>static T get(FILE*f){T v{};if(fread(&v,sizeof(v),1,f)!=1)throw std::runtime_error("short checkpoint read");return v;}
static std::string stem(int n,int h) {
    std::ostringstream o;o<<"n"<<std::setw(2)<<std::setfill('0')<<n<<"_h"<<std::setw(3)<<h;return o.str();
}
static u64 private_bytes() {
#ifdef _WIN32
    PROCESS_MEMORY_COUNTERS_EX m{};m.cb=sizeof(m);
    if(GetProcessMemoryInfo(GetCurrentProcess(),reinterpret_cast<PROCESS_MEMORY_COUNTERS*>(&m),sizeof(m)))return m.PrivateUsage;
#endif
    return 0;
}
static u64 resident_bytes() {
#ifdef _WIN32
    PROCESS_MEMORY_COUNTERS_EX m{};m.cb=sizeof(m);
    if(GetProcessMemoryInfo(GetCurrentProcess(),reinterpret_cast<PROCESS_MEMORY_COUNTERS*>(&m),sizeof(m)))return m.WorkingSetSize;
#endif
    return 0;
}
struct Options {
    fs::path data="runs/global_retro/data",input,stop,progress;
    int threads=8,min_layer=0,max_layer=34,only_h=-1;
    double seconds=600,checkpoint_seconds=30;
    u64 deadline_epoch=0,memory_limit=15500000000ULL,cache_limit=8000000000ULL;
    u64 chunk_states=1ULL<<18;
    bool force=false;
};
static Options options(int argc,char**argv) {
    Options o;
    for(int i=1;i<argc;++i) {
        std::string a=argv[i];
        if(a=="--force"){o.force=true;continue;}
        if(i+1>=argc)throw std::runtime_error("missing value for "+a);
        std::string v=argv[++i];
        if(a=="--data")o.data=fs::u8path(v);
        else if(a=="--input")o.input=fs::u8path(v);
        else if(a=="--stop-file")o.stop=fs::u8path(v);
        else if(a=="--progress")o.progress=fs::u8path(v);
        else if(a=="--threads")o.threads=std::stoi(v);
        else if(a=="--min-layer")o.min_layer=std::stoi(v);
        else if(a=="--max-layer")o.max_layer=std::stoi(v);
        else if(a=="--only-h")o.only_h=std::stoi(v);
        else if(a=="--seconds")o.seconds=std::stod(v);
        else if(a=="--deadline-epoch")o.deadline_epoch=std::stoull(v);
        else if(a=="--checkpoint-seconds")o.checkpoint_seconds=std::stod(v);
        else if(a=="--memory-limit-bytes")o.memory_limit=std::stoull(v);
        else if(a=="--cache-limit-bytes")o.cache_limit=std::stoull(v);
        else if(a=="--chunk-states")o.chunk_states=std::stoull(v);
        else throw std::runtime_error("unknown option "+a);
    }
    if(o.threads<1||o.threads>16||o.min_layer<0||o.max_layer>34||o.min_layer>o.max_layer
       ||o.seconds<=0||o.chunk_states%64||o.chunk_states==0||o.checkpoint_seconds<1)
        throw std::runtime_error("invalid budget, layers, threads, or chunk size");
    if(o.input.empty())o.input=o.data;
    return o;
}
struct Stats {
    steady::time_point began=steady::now();
    std::atomic<u64> new_states{0},candidate_edges{0},lookup_edges{0};
    double compute_seconds=0,checkpoint_seconds=0,load_seconds=0;
    u64 completed_buckets=0,skipped_buckets=0,resumed_states=0,loaded_bytes=0;
    int n=34,h=-1,threads=8;
    u64 current_size=0,current_done=0,current_p=0;
    std::string phase="initializing",reason;
};
static std::string progress_json(const Stats&s,const retro::Index&idx,const Options&o,bool final=false) {
    double sec=elapsed(s.began);u64 count=s.new_states.load();
    std::ostringstream j;j<<std::setprecision(12);
    j<<"{\"schema\":\""<<SCHEMA<<"\",\"index_fingerprint\":\""<<hex64(idx.fingerprint)
     <<"\",\"build_id\":\""<<RETRO_BUILD_ID<<"\",\"phase\":\""<<s.phase
     <<"\",\"reason\":\""<<s.reason<<"\",\"final\":"<<(final?"true":"false")
     <<",\"n\":"<<s.n<<",\"h\":"<<s.h<<",\"threads\":"<<s.threads
     <<",\"states_new\":"<<count<<",\"total_elapsed\":"<<sec
     <<",\"compute_elapsed\":"<<s.compute_seconds
     <<",\"states_per_second\":"<<(sec>0?count/sec:0)
     <<",\"states_per_hour\":"<<(sec>0?count*3600.0/sec:0)
     <<",\"completed_buckets\":"<<s.completed_buckets<<",\"skipped_buckets\":"<<s.skipped_buckets
     <<",\"resumed_states\":"<<s.resumed_states<<",\"loaded_bytes\":"<<s.loaded_bytes
     <<",\"checkpoint_seconds\":"<<s.checkpoint_seconds<<",\"load_seconds\":"<<s.load_seconds
     <<",\"current_size\":"<<s.current_size<<",\"current_done_states\":"<<s.current_done
     <<",\"p_states_current\":"<<s.current_p
     <<",\"candidate_edges\":"<<s.candidate_edges.load()<<",\"lookup_edges\":"<<s.lookup_edges.load()
     <<",\"private_bytes\":"<<private_bytes()<<",\"rss_bytes\":"<<resident_bytes()
     <<",\"memory_limit_bytes\":"<<o.memory_limit<<"}\n";
    return j.str();
}
static bool stop_requested(const Options&o,Stats&s) {
    if(interrupted.load()){s.reason="signal";return true;}
    if(!o.stop.empty()&&fs::exists(o.stop)){s.reason="stop_file";return true;}
    if(elapsed(s.began)>=o.seconds){s.reason="time_budget";return true;}
    if(o.deadline_epoch&&u64(std::time(nullptr))>=o.deadline_epoch){s.reason="deadline";return true;}
    if(private_bytes()>o.memory_limit){s.reason="memory_limit";return true;}
    return false;
}
struct Table {
    retro::Bucket bucket;
    std::vector<u64> bits;
    u64 p=0,tick=0;
    bool all_p=false;
    u64 bytes()const {
        return bits.capacity()*sizeof(u64)+bucket.offsets.capacity()*sizeof(u64)
             +bucket.blocks.capacity()*sizeof(retro::Block);
    }
    bool is_p(u64 rank)const {return all_p||((bits[rank>>6]>>(rank&63))&1);}
};
struct MovePlans {
    std::vector<uint32_t> first,sizes;
    std::vector<std::vector<uint16_t>> next_groups;
    explicit MovePlans(const retro::Index&idx) {
        const size_t groups=idx.group_count();
        first.assign(groups,retro::BAD_ID);sizes.assign(groups,0);next_groups.resize(groups);
        for(uint32_t id=0;id<idx.numeric.size();++id) {
            const auto&x=idx.numeric[id];
            if(first[x.group]==retro::BAD_ID)first[x.group]=id;
            ++sizes[x.group];
            for(unsigned k=0;k<x.next_count;++k) {
                const uint32_t target=x.next[k];
                if(target<=id)throw std::runtime_error("local forward-ID ordering invariant failed");
                next_groups[x.group].push_back(idx.numeric[target].group);
            }
        }
        for(auto&g:next_groups){std::sort(g.begin(),g.end());g.erase(std::unique(g.begin(),g.end()),g.end());}
    }
    u64 block_size(const std::array<uint16_t,3>&g)const {
        u64 a=sizes[g[0]],b=sizes[g[1]],c=sizes[g[2]];
        if(g[0]==g[2])return a*(a+1)*(a+2)/6;
        if(g[0]==g[1])return a*(a+1)/2*c;
        if(g[1]==g[2])return a*b*(b+1)/2;
        return a*b*c;
    }
    bool prepare(const retro::Index&idx,const Table&t,const std::array<uint32_t,3>&ids,
                 std::array<std::vector<u64>,3>&offsets)const {
        const std::array<uint16_t,3> g{idx.numeric[ids[0]].group,idx.numeric[ids[1]].group,idx.numeric[ids[2]].group};
        if(block_size(g)<128)return false;
        for(int suit=0;suit<3;++suit)for(uint16_t target:next_groups[g[suit]]) {
            std::array<uint32_t,3> x{first[g[0]],first[g[1]],first[g[2]]};
            x[suit]=first[target];
            // The changed ID only moves to the right.
            if(suit==0&&x[0]>x[1])std::swap(x[0],x[1]);
            if(suit<2&&x[1]>x[2])std::swap(x[1],x[2]);
            const uint32_t tid=idx.tid_sorted(x);
            offsets[suit][target]=tid==retro::BAD_ID?retro::BAD_RANK:t.bucket.offsets[tid];
        }
        return true;
    }
};
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
