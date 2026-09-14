// Untrusted cache candidate generator; the compiled Lean checker checks every
// recurrence and every referenced local state. No result from here is a proof.
#include <array>
#include <cstdint>
#include <fstream>
#include <iostream>
#include <stdexcept>
#include <vector>

static void generate(const char* filename, bool honors) {
  const unsigned n = honors ? 7 : 9;
  std::array<unsigned,9> pw{}; pw[0]=1;
  for(unsigned i=1;i<9;++i)pw[i]=5*pw[i-1];
  const unsigned size=pw[n-1]*5;
  std::vector<uint8_t> bits(size);
  for(unsigned code=0;code<size;++code) {
    std::array<unsigned,9> d{};
    unsigned x=code, mask=1;
    for(unsigned i=0;i<n;++i){d[i]=x%5;x/=5;}
    for(unsigned i=0;i<n;++i)if(d[i]>=3)mask|=bits[code-3*pw[i]]<<1;
    if(!honors)for(unsigned i=0;i<7;++i)if(d[i]&&d[i+1]&&d[i+2])
      mask|=bits[code-pw[i]-pw[i+1]-pw[i+2]]<<1;
    bits[code]=uint8_t(mask&31);
  }
  std::ofstream out(filename,std::ios::binary|std::ios::trunc);
  out.write(reinterpret_cast<const char*>(bits.data()),bits.size());out.flush();
  if(!out)throw std::runtime_error("cache write failed");
  std::cout<<"CANDIDATE_ONLY bytes="<<size<<" file="<<filename<<"\n";
}
int main(int argc,char** argv) {
  if(argc!=3)return 2;
  try {generate(argv[1],false);generate(argv[2],true);}
  catch(const std::exception& e){std::cerr<<e.what()<<"\n";return 1;}
}
