// Exact public-pool Mahjong achievement solver, expressed as safe normal play.
// Tile order: 1m..9m, 1p..9p, 1s..9s, East/South/West/North/White/Green/Red.
// A state is safe iff it contains no win and no legal one-tile completion.
// Only proven WIN/LOSS states enter the exact transposition table; exhaustion
// propagates UNKNOWN. Hash collisions are resolved by the full 4-block key.
// Static local profiles accelerate the oracle ONLY; search keys retain every
// suit count, modulo suit swaps/reversals and permutations of the seven honors.
#include <algorithm>
#include <array>
#include <chrono>
#include <cstdint>
#include <fstream>
#include <iostream>
#include <sstream>
#include <string>
#include <sys/resource.h>
#include <unordered_map>
#include <unordered_set>
#include <vector>
using namespace std;
using Clock=chrono::steady_clock;
constexpr uint32_t SN=1953125,HN=78125;
uint32_t pw[10];
struct Local { uint32_t canonical; uint8_t profile,add,q,singles,miss,kpair; };
vector<Local> su,ho;
uint8_t comb[64][64],uni[64][64];
struct State { array<uint32_t,4> c{}; bool operator==(const State&o)const{return c==o.c;} };
struct Hash { size_t operator()(const State&s)const {uint64_t x=s.c[0]|(uint64_t(s.c[1])<<21)|(uint64_t(s.c[2])<<42);x^=uint64_t(s.c[3])*0x9e3779b97f4a7c15ULL;x=(x^(x>>30))*0xbf58476d1ce4e5b9ULL;x=(x^(x>>27))*0x94d049bb133111ebULL;return x^(x>>31);} };
struct Entry {bool win;State move;};
unordered_map<State,Entry,Hash> tt;
uint64_t nodes=0,hits=0,generated=0,nodeLimit=1000000;
double secondsLimit=120; Clock::time_point started;bool exhausted=false;
// A local profile records maximum meld counts with no pair (a) and exactly
// one pair (b; -1 means impossible), capped at four. Any smaller meld count
// is feasible by ignoring surplus melds. This encodes the full ten-bit mask.
int meld(int p){return p&7;}int pairmeld(int p){return (p>>3)-1;}
uint8_t profile(int a,int b){return uint8_t(a|((b+1)<<3));}
uint8_t combine(int x,int y){int a=min(4,meld(x)+meld(y)),b=-1;if(pairmeld(x)>=0)b=min(4,pairmeld(x)+meld(y));if(pairmeld(y)>=0)b=max(b,min(4,meld(x)+pairmeld(y)));return profile(a,b);}
uint8_t unify(int x,int y){return profile(max(meld(x),meld(y)),max(pairmeld(x),pairmeld(y)));}
void build(vector<Local>&tab,int width,bool honors){
 uint32_t size=pw[width];tab.resize(size);
 for(uint32_t code=0;code<size;code++){
  int d[9]={};uint32_t r=code,rev=0;for(int i=width-1;i>=0;i--){d[i]=r%5;r/=5;}for(int i=width-1;i>=0;i--)rev=rev*5+d[i];
  Local z{};uint8_t pr=0; int q=0,singles=0;
  for(int i=0;i<width;i++){uint32_t step=pw[width-1-i];q+=d[i]>=2;singles+=d[i]==1;if(d[i])pr=uni[pr][tab[code-step].profile];if(d[i]>=3){int p=tab[code-3*step].profile;pr=uni[pr][profile(min(4,meld(p)+1),pairmeld(p)<0?-1:min(4,pairmeld(p)+1))];}if(d[i]>=2){int p=tab[code-2*step].profile;pr=uni[pr][profile(meld(p),meld(p))];}if(!honors&&i+2<width&&d[i]&&d[i+1]&&d[i+2]){int p=tab[code-step-pw[width-2-i]-pw[width-3-i]].profile;pr=uni[pr][profile(min(4,meld(p)+1),pairmeld(p)<0?-1:min(4,pairmeld(p)+1))];}}
  z.profile=pr;z.q=q;z.singles=singles;
  for(int i=0;i<width;i++)if(honors||i==0||i==8){z.miss+=d[i]==0;z.kpair|=d[i]>=2;}
  if(honors){for(int i=1;i<width;i++)for(int j=i;j>0&&d[j]<d[j-1];j--)swap(d[j],d[j-1]);uint32_t cc=0;for(int i=0;i<width;i++)cc=cc*5+d[i];z.canonical=cc;}else z.canonical=min(code,rev);
  tab[code]=z;
 }
 for(uint32_t code=0;code<size;code++){uint32_t r=code;uint8_t pr=0;for(int i=0;i<width;i++){int d=r%5;r/=5;if(d<4)pr=uni[pr][tab[code+pw[i]].profile];}tab[code].add=pr;}
}
void init(){pw[0]=1;for(int i=1;i<=9;i++)pw[i]=pw[i-1]*5;for(int i=0;i<64;i++)for(int j=0;j<64;j++){if(meld(i)<=4&&pairmeld(i)<=4&&meld(j)<=4&&pairmeld(j)<=4){comb[i][j]=combine(i,j);uni[i][j]=unify(i,j);}}
 build(su,9,false);build(ho,7,true);
}
State canon(State s){for(int b=0;b<3;b++)s.c[b]=su[s.c[b]].canonical;sort(s.c.begin(),s.c.begin()+3);s.c[3]=ho[s.c[3]].canonical;return s;}
string repr(const State&s){string r;for(int b=0;b<4;b++){int width=b==3?7:9;for(int i=width-1;i>=0;i--)r+=char('0'+(s.c[b]/pw[i])%5);}return r;}
State parse(const string&str){string s;for(char c:str)if(c>='0'&&c<='4')s+=c;if(s.size()!=34)throw runtime_error("state must contain exactly 34 digits from 0 to 4");State x;int at=0;for(int b=0;b<4;b++)for(int i=0;i<(b==3?7:9);i++)x.c[b]=x.c[b]*5+s[at++]-'0';return x;}
bool terminal(const State&s){int q=0,mi=0,kp=0;uint8_t pr=0;for(int b=0;b<4;b++){const Local&l=(b==3?ho:su)[s.c[b]];q+=l.q;mi+=l.miss;kp|=l.kpair;pr=comb[pr][l.profile];}return q>=7||(mi==0&&kp)||pairmeld(pr)>=4;}
// ad is the union of feasible profiles after one legal addition to a processed
// block. Union is exact for existence queries, even when its two maxima arise
// from different additions. q/singles handle seven pairs; miss/kpair handle
// thirteen orphans, including the one-away boundary.
bool safe(const State&s){int q=0,si=0,mi=0,kp=0;uint8_t pr=0,ad=0;for(int b=0;b<4;b++){const Local&l=(b==3?ho:su)[s.c[b]];q+=l.q;si+=l.singles;mi+=l.miss;kp|=l.kpair;ad=uni[comb[ad][l.profile]][comb[pr][l.add]];pr=comb[pr][l.profile];}return !(q>=7||(q==6&&si>0)||mi==0||(mi==1&&kp)||pairmeld(pr)>=4||pairmeld(ad)>=4);}
vector<State> moves(const State&s){vector<State> out;for(int b=0;b<4;b++){uint32_t r=s.c[b];int width=b==3?7:9;for(int i=0;i<width;i++){int d=r%5;r/=5;if(d<4){State t=s;t.c[b]+=pw[i];if(safe(t)){t=canon(t);if(find(out.begin(),out.end(),t)==out.end())out.push_back(t);}}}}
 generated+=out.size();return out;}
int dfs(const State&s){auto it=tt.find(s);if(it!=tt.end()){hits++;return it->second.win;}
 if(nodes>=nodeLimit||((nodes&4095)==0&&chrono::duration<double>(Clock::now()-started).count()>secondsLimit)){exhausted=true;return -1;}nodes++;
 vector<State> children=moves(s);
 // Explore extensions with most complete melds first. Exactness does not depend on this ordering.
 stable_sort(children.begin(),children.end(),[](const State&a,const State&b){auto score=[](const State&s){int n=0;for(int i=0;i<4;i++){auto &l=(i==3?ho:su)[s.c[i]];n+=8*meld(l.profile)+2*max(0,pairmeld(l.profile))+l.q;}return n;};return score(a)>score(b);});
 for(const auto&t:children){int z=dfs(t);if(z<0)return -1;if(z==0){tt.emplace(s,Entry{true,t});return 1;}}
 tt.emplace(s,Entry{false,{}});return 0;
}
size_t certificate(const State&root,const string&path){vector<State> order{root};unordered_set<State,Hash> seen;seen.insert(root);for(size_t i=0;i<order.size();i++){const State s=order[i];const auto&e=tt.at(s);vector<State> cs=e.win?vector<State>{e.move}:moves(s);for(auto&t:cs)if(seen.insert(t).second)order.push_back(t);}
 ofstream f(path);if(!f)throw runtime_error("cannot write certificate");f<<"{\n\"version\":1,\"rule\":\"safe-mahjong-v1\",\"root\":\""<<repr(root)<<"\",\n\"nodes\":[\n";
 for(size_t i=0;i<order.size();i++){const auto&s=order[i];const auto&e=tt.at(s);vector<State> cs=e.win?vector<State>{e.move}:moves(s);f<<"{\"state\":\""<<repr(s)<<"\",\"outcome\":\""<<(e.win?"WIN":"LOSS")<<"\",\"children\":[";for(size_t j=0;j<cs.size();j++)f<<(j?",":"")<<"\""<<repr(cs[j])<<"\"";f<<"]}"<<(i+1<order.size()?",":"")<<"\n";}f<<"]}\n";return order.size();
}
int main(int argc,char**argv){try{string input(34,'0'),cert;bool list=false,check=false,batch=false;for(int i=1;i<argc;i++){string a=argv[i];if(a=="--state"&&i+1<argc)input=argv[++i];else if(a=="--nodes"&&i+1<argc)nodeLimit=stoull(argv[++i]);else if(a=="--seconds"&&i+1<argc)secondsLimit=stod(argv[++i]);else if(a=="--cert"&&i+1<argc)cert=argv[++i];else if(a=="--moves")list=true;else if(a=="--check")check=true;else if(a=="--batch-check")batch=true;else throw runtime_error("unknown argument: "+a);}
 auto before=Clock::now();init();double initSec=chrono::duration<double>(Clock::now()-before).count();if(batch){string line;while(getline(cin,line)){State x=parse(line);cout<<"{\"state\":\""<<repr(x)<<"\",\"terminal\":"<<(terminal(x)?"true":"false")<<",\"safe\":"<<(safe(x)?"true":"false")<<"}\n";}return 0;}State raw=parse(input),root=canon(raw);bool t=terminal(root),s=safe(root);started=Clock::now();tt.reserve(min<uint64_t>(nodeLimit,2000000));int result=-1;if(s&&!check)result=dfs(root);double elapsed=chrono::duration<double>(Clock::now()-started).count();uint64_t searchGenerated=generated;size_t certNodes=0;if(result>=0&&!cert.empty())certNodes=certificate(root,cert);struct rusage usage{};getrusage(RUSAGE_SELF,&usage);
 cout<<"{\"root\":\""<<repr(root)<<"\",\"terminal\":"<<(t?"true":"false")<<",\"safe\":"<<(s?"true":"false")<<",\"outcome\":\""<<(t?"TERMINAL":!s?"IMMEDIATE_WIN":check?"UNCHECKED":result<0?"UNKNOWN":result?"WIN":"LOSS")<<"\",\"nodes\":"<<nodes<<",\"tt_entries\":"<<tt.size()<<",\"tt_hits\":"<<hits<<",\"generated\":"<<searchGenerated<<",\"max_rss_kib\":"<<usage.ru_maxrss<<",\"certificate_nodes\":"<<certNodes<<",\"initialization_seconds\":"<<initSec<<",\"search_seconds\":"<<elapsed;
 if(result==1)cout<<",\"winning_child\":\""<<repr(tt.at(root).move)<<"\"";
 if(list){cout<<",\"safe_children\":[";auto cs=moves(root);for(size_t i=0;i<cs.size();i++)cout<<(i?",":"")<<"\""<<repr(cs[i])<<"\"";cout<<"]";}
 if(!s&&!t){for(int b=0;b<4;b++){uint32_t r=root.c[b];int w=b==3?7:9;for(int i=0;i<w;i++){int d=r%5;r/=5;if(d<4){State q=root;q.c[b]+=pw[i];if(terminal(q)){cout<<",\"immediate_winning_tile\":"<<(b==3?27+6-i:b*9+8-i);b=4;break;}}}}}
 cout<<"}\n";
 }catch(const exception&e){cerr<<e.what()<<"\n";return 1;}}
