#include <array>
#include <cstdint>
#include <fstream>
#include <iostream>
#include <stdexcept>
#include <vector>
static unsigned cap(uint8_t value) { unsigned result=0;for(unsigned k=1;k<=4;++k)if(value&(1<<k))result=k;return result; }
int main(int argc,char** argv) {try {
  if(argc!=4)return 2;
  bool honors=std::stoi(argv[1])==3;unsigned width=honors?7:9,size=honors?78125:1953125;
  std::vector<uint8_t> core(size);std::ifstream in(argv[2],std::ios::binary);
  in.read(reinterpret_cast<char*>(core.data()),size);if(!in)throw std::runtime_error("core read failed");
  std::array<unsigned,9> pw{};pw[0]=1;for(unsigned i=1;i<9;++i)pw[i]=5*pw[i-1];
  std::ofstream out(argv[3],std::ios::binary);
  for(unsigned code=0;code<size;++code){
    std::array<unsigned,9>d{};unsigned x=code,p=0,q=0,mask=0;bool all=true,pair=false;
    for(unsigned i=0;i<width;++i){d[i]=x%5;x/=5;
      if(d[i]>=2){++q;p=std::max(p,cap(core[code-2*pw[i]])+1);}
      if(d[i]<4)mask|=1<<i;
      if(honors||i==0||i==8){all=all&&d[i]>0;pair=pair||d[i]>=2;}
    }
    uint32_t v=cap(core[code])+(p<<3)+(q<<6)+(unsigned(all)<<10)+(unsigned(pair)<<11)+(mask<<12);
    char bytes[4];for(unsigned j=0;j<4;++j)bytes[j]=char(v>>(8*j));out.write(bytes,4);
  }
  out.flush();if(!out)throw std::runtime_error("summary write failed");
  std::cout<<"CANDIDATE_ONLY rows="<<size<<"\n";
} catch(const std::exception&e){std::cerr<<e.what()<<"\n";return 1;} }
