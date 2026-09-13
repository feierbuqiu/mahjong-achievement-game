#include "global_index.hpp"
#include <set>
#include <iomanip>

namespace {
void require(bool value,const char* reason){if(!value)throw std::runtime_error(reason);}
using Key=std::array<uint32_t,4>;
Key key(std::array<uint32_t,3> ids,int h){std::sort(ids.begin(),ids.end());return {ids[0],ids[1],ids[2],uint32_t(h)};}
constexpr uint64_t expected_layers[35]={
    1,6,47,298,1725,8967,42793,187376,760493,2874880,10187475,34006368,
    107440638,321356083,903209000,2346950750ULL,5544554559ULL,11780250236ULL,
    22376865721ULL,37804625883ULL,56566252124ULL,75050088557ULL,89127184893ULL,
    96268928092ULL,96065224588ULL,88982128123ULL,75440492234ULL,56645165793ULL,
    35949118771ULL,18221731480ULL,6893983233ULL,1786188250ULL,280542509ULL,21924455,587901
};
}

int main(int argc,char**argv){try{
    bool all_edges=false;uint64_t edge_stride=1000;double budget_seconds=240;
    std::vector<int> layers{34,33};
    for(int i=1;i<argc;++i){std::string a=argv[i];
        if(a=="--all-edges")all_edges=true;
        else if(a=="--edge-stride"&&i+1<argc)edge_stride=std::stoull(argv[++i]);
        else if(a=="--seconds"&&i+1<argc)budget_seconds=std::stod(argv[++i]);
        else if(a=="--layers"&&i+1<argc){layers.clear();std::stringstream ss(argv[++i]);std::string v;while(std::getline(ss,v,','))layers.push_back(std::stoi(v));}
        else throw std::runtime_error("invalid selftest argument: "+a);
    }
    require(edge_stride>0,"edge stride must be positive");
    const auto start=Clock::now();retro::Index idx;
    std::cout<<"{\"kind\":\"index\",\"fingerprint\":\""<<idx.fingerprint<<"\",\"numeric\":"<<idx.numeric.size()<<",\"honors\":"<<idx.honors.size()<<",\"groups\":"<<idx.group_count()<<",\"triples\":"<<idx.triple_count()<<",\"fixed_table_bytes_lower_bound\":"<<idx.fixed_table_bytes()<<",\"seconds\":"<<std::chrono::duration<double>(Clock::now()-start).count()<<"}"<<std::endl;
    for(int n=0;n<35;++n)require(idx.layer_size(n)==expected_layers[n],"layer count mismatch");
    uint64_t local_edges=0,honor_edges=0;
    for(size_t i=0;i<idx.numeric.size();++i){const auto& x=idx.numeric[i];
        State s;s.c[0]=x.code;auto enc=idx.encode(s);
        require(enc.first[0]==0&&enc.first[1]==0&&enc.first[2]==i,"local encode identity mismatch");
        for(unsigned j=0;j<x.next_count;++j){require(x.next[j]<idx.numeric.size(),"numeric edge ID outside table");require(idx.numeric[x.next[j]].tiles==x.tiles+1,"numeric edge does not increase one tile");if(j)require(x.next[j-1]<x.next[j],"duplicate numeric edge");++local_edges;}
    }
    for(const auto& h:idx.honors)for(unsigned j=0;j<h.next_count;++j){require(h.next[j]<idx.honors.size(),"honor edge ID outside table");require(idx.honors[h.next[j]].tiles==h.tiles+1,"honor edge does not increase one tile");if(j)require(h.next[j-1]<h.next[j],"duplicate honor edge");++honor_edges;}
    uint64_t inverse_states=0,edge_states=0,checked_edges=0,buckets=0;
    for(int n:layers){require(n>=0&&n<=34,"invalid requested layer");uint64_t layer_seen=0,layer_edge_states=0,layer_edges=0;
        for(int h=0;h<int(idx.honors.size());++h){auto b=idx.make_bucket(n,h);if(!b.size)continue;++buckets;
            auto same=idx.make_bucket(n+1,h);std::vector<retro::Bucket> next_h;
            for(unsigned j=0;j<idx.honors[h].next_count;++j)next_h.push_back(idx.make_bucket(n+1,idx.honors[h].next[j]));
            auto child_bucket=[&](int hh)->const retro::Bucket&{if(hh==h)return same;for(const auto& q:next_h)if(q.h==hh)return q;throw std::logic_error("baseline move has impossible honor transition");};
            auto cur=idx.cursor(b,0);
            for(uint64_t r=0;r<b.size;++r){
                if((r&65535)==0&&std::chrono::duration<double>(Clock::now()-start).count()>budget_seconds)throw std::runtime_error("selftest budget exhausted; incomplete");
                const auto decoded=idx.decode(b,r);
                require(cur.valid()&&cur.ids==decoded,"incremental cursor differs from decode");
                require(idx.rank_sorted(b,decoded)==r,"rank/decode inverse mismatch");
                require(idx.tid_sorted(decoded)==cur.tid&&idx.within_sorted(decoded)==cur.within,"cursor block identity mismatch");
                if(all_edges||r%edge_stride==0||r+1==b.size){
                    const auto physical=idx.physical(decoded,h);require(::safe(physical),"indexed position not SAFE");
                    const auto enc=idx.encode(physical);require(enc.first==decoded&&enc.second==h,"physical encoding roundtrip mismatch");
                    auto middle=idx.cursor(b,r);require(middle.ids==decoded,"midblock cursor start differs");middle.advance();
                    if(r+1<b.size)require(middle.ids==idx.decode(b,r+1),"midblock cursor advance differs");else require(!middle.valid(),"last cursor did not terminate");
                    std::set<Key> oracle,actual;
                    for(const State& child: ::moves(physical)){
                        auto e=idx.encode(child);require(e.second>=0&&e.first[2]!=retro::BAD_ID,"baseline child absent from local index");
                        require(idx.rank_sorted(child_bucket(e.second),e.first)!=retro::BAD_RANK,"baseline SAFE child absent from bucket");oracle.insert(key(e.first,e.second));
                    }
                    for(unsigned suit=0;suit<3;++suit){const auto& loc=idx.numeric[decoded[suit]];
                        for(unsigned j=0;j<loc.next_count;++j){auto ids=decoded;ids[suit]=loc.next[j];
                            if(idx.rank(same,ids)!=retro::BAD_RANK)actual.insert(key(ids,h));
                        }
                    }
                    for(const auto& q:next_h)if(idx.rank_sorted(q,decoded)!=retro::BAD_RANK)actual.insert(key(decoded,q.h));
                    require(actual==oracle,"indexed SAFE edges differ from complete baseline moves");
                    ++edge_states;++layer_edge_states;checked_edges+=actual.size();layer_edges+=actual.size();
                }
                cur.advance();++inverse_states;++layer_seen;
            }
            require(!cur.valid(),"bucket cursor did not terminate");
        }
        require(layer_seen==expected_layers[n],"enumerated layer size mismatch");
        std::cout<<"{\"kind\":\"layer_test\",\"n\":"<<n<<",\"inverse_states\":"<<layer_seen<<",\"edge_states\":"<<layer_edge_states<<",\"edges\":"<<layer_edges<<",\"full_edge_coverage\":"<<(all_edges?"true":"false")<<",\"seconds\":"<<std::chrono::duration<double>(Clock::now()-start).count()<<"}"<<std::endl;
    }
    struct rusage usage{};getrusage(RUSAGE_SELF,&usage);
    std::cout<<"{\"kind\":\"summary\",\"status\":\"PASS\",\"fingerprint\":\""<<idx.fingerprint<<"\",\"matched_layer_counts\":35,\"numeric_transition_entries\":"<<local_edges<<",\"honor_transition_entries\":"<<honor_edges<<",\"inverse_states\":"<<inverse_states<<",\"edge_states\":"<<edge_states<<",\"checked_edges\":"<<checked_edges<<",\"buckets\":"<<buckets<<",\"full_edge_coverage\":"<<(all_edges?"true":"false")<<",\"max_rss_kib\":"<<usage.ru_maxrss<<",\"seconds\":"<<std::chrono::duration<double>(Clock::now()-start).count()<<"}"<<std::endl;
    return 0;
}catch(const std::exception& e){std::cerr<<"{\"status\":\"FAIL_OR_INCOMPLETE\",\"reason\":\""<<e.what()<<"\"}"<<std::endl;return 2;}}
