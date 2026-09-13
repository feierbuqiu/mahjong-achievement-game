#include "global_index.hpp"
#include <filesystem>
#include <iomanip>

int main(int argc,char**argv){try{
    const std::filesystem::path out=argc>1?std::filesystem::u8path(argv[1]):std::filesystem::u8path("runs/global_retro/index/bucket_catalog.json");
    retro::Index idx;std::filesystem::create_directories(out.parent_path());
    std::ofstream f(out,std::ios::binary);if(!f)throw std::runtime_error("cannot create catalog");
    f<<"{\n  \"schema\": \"MAHJONG_GLOBAL_BUCKET_CATALOG_V1\",\n  \"database_schema\": \"MJGLOBAL_PN_V1\",\n  \"index_fingerprint\": \""<<std::hex<<std::setw(16)<<std::setfill('0')<<idx.fingerprint<<std::dec<<"\",\n  \"zero_buckets_included\": true,\n  \"buckets\": [\n";
    uint64_t total=0;size_t nonempty=0;
    for(int n=0;n<=34;++n)for(int h=0;h<int(idx.honors.size());++h){
        const auto size=idx.bucket_size(n,h);total+=size;nonempty+=size!=0;
        f<<"    {\"n\":"<<n<<",\"h\":"<<h<<",\"honor_code\":"<<idx.honors[h].code<<",\"states\":"<<size<<"}"<<((n==34&&h+1==int(idx.honors.size()))?"\n":",\n");
    }
    f<<"  ],\n  \"total_nonempty_buckets\": "<<nonempty<<",\n  \"total_states\": "<<total<<"\n}\n";
    if(!f)throw std::runtime_error("catalog write failed");f.close();
    std::cout<<"{\"status\":\"CATALOG_EXPORTED\",\"buckets\":"<<35*idx.honors.size()<<",\"nonempty_buckets\":"<<nonempty<<",\"total_states\":"<<total<<"}"<<std::endl;return 0;
}catch(const std::exception&e){std::cerr<<e.what()<<std::endl;return 1;}}
