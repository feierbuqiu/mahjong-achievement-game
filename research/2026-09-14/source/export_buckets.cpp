// Untrusted compact input exporter. Lean checks every decoded row and roundtrip.
#include "../global_retro/global_index.hpp"
#include <filesystem>
#include <fstream>
#include <iomanip>
namespace fs = std::filesystem;
void put(std::ostream& o,uint64_t x,int n){for(int i=0;i<n;++i){o.put(char(x&255));x>>=8;}if(!o)throw std::runtime_error("write failed");}
int main(int argc,char**argv){
 try {
  if(argc!=4)throw std::runtime_error("output-directory min-layer max-layer");
  fs::path root=fs::u8path(argv[1]);fs::create_directories(root);
  const int lo=std::stoi(argv[2]),hi=std::stoi(argv[3]);
  retro::Index idx;
  std::vector<uint32_t> first(idx.group_count(),UINT32_MAX),sz(idx.group_count());
  for(uint32_t id=0;id<idx.numeric.size();++id){auto&v=idx.numeric[id];first[v.group]=std::min(first[v.group],id);++sz[v.group];}
  {std::ofstream f(root/"numeric.bin",std::ios::binary);for(auto&v:idx.numeric){put(f,v.code,4);put(f,v.group,4);put(f,v.member,4);}}
  {std::vector<uint32_t> ids(1953125,UINT32_MAX);for(uint32_t i=0;i<idx.numeric.size();++i)ids[idx.numeric[i].code]=i;
   std::ofstream f(root/"numeric_ids.bin",std::ios::binary);for(auto x:ids)put(f,x,4);}
  {std::ofstream f(root/"groups.bin",std::ios::binary);for(size_t i=0;i<sz.size();++i){put(f,first[i],4);put(f,sz[i],4);}}
  std::ofstream catalog(root/"catalog.tsv");uint64_t total=0;
  for(int n=hi;n>=lo;--n)for(unsigned h=0;h<idx.honors.size();++h){
   auto bucket=idx.make_bucket(n,h);if(!bucket.size)continue;
   std::ostringstream name;name<<'n'<<std::setw(2)<<std::setfill('0')<<n<<"_h"<<std::setw(3)<<h;
   std::ofstream f(root/(name.str()+".dir"),std::ios::binary);
   for(auto&b:bucket.blocks){auto ids=idx.decode(bucket,b.offset);put(f,b.offset,8);put(f,b.size,8);
    for(auto id:ids)put(f,idx.numeric[id].group,4);put(f,b.tid,4);}
   catalog<<n<<'\t'<<h<<'\t'<<idx.honors[h].code<<'\t'<<bucket.size<<'\t'<<bucket.blocks.size()<<'\n';
   total+=bucket.size;
  }
  std::cout<<"EXPORTED slots="<<total<<" fingerprint="<<std::hex<<idx.fingerprint<<"; untrusted input only\n";
 }catch(const std::exception&e){std::cerr<<e.what()<<'\n';return 1;}
}
