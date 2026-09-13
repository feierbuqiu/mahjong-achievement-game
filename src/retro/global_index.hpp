#ifndef MAHJONG_GLOBAL_RETRO_INDEX_HPP
#define MAHJONG_GLOBAL_RETRO_INDEX_HPP

// This header deliberately reuses the immutable, audited complete-game rules.
// The root translation unit must not separately include solver.cpp.
#define main global_retro_immutable_baseline_main
#include "../../mahjong_progress/solver/solver.cpp"
#undef main
#include <cmath>
#include <limits>
#include <map>
#include <stdexcept>
#include <utility>

namespace retro {

constexpr uint64_t BAD_RANK = UINT64_MAX;
constexpr uint32_t BAD_ID = UINT32_MAX;
constexpr uint16_t BAD_HONOR = UINT16_MAX;
inline constexpr const char* INDEX_SCHEMA =
    "mahjong-physical-safe-index-v1;group-label-n-ascending;member-code-ascending;"
    "honor-code-ascending;triple-lex;colex-tid-lut;member-x-fastest;honor3-is-physical";

struct Numeric {
    uint32_t code = 0;
    uint16_t group = 0, member = 0;
    uint8_t tiles = 0, next_count = 0;
    std::array<uint32_t,9> next{};
};
struct Honor {
    uint32_t code = 0;
    uint8_t tiles = 0, next_count = 0;
    std::array<uint16_t,4> next{};
};
struct Block { uint32_t tid; uint64_t offset, size; };
struct Bucket {
    int n = 0, h = 0;
    uint64_t size = 0;
    std::vector<Block> blocks;
    std::vector<uint64_t> offsets;
};

class Index {
    struct Label { int pr=0, ad=0, q=0, si=0, mi=0, kp=0, n=0; };
    struct Group { uint32_t first, size, label; };
    struct Triple { uint16_t g0, g1, g2; uint32_t label; uint64_t size; };
    std::vector<Group> groups_;
    std::vector<Triple> triples_;
    std::vector<uint32_t> triple_lut_, numeric_by_code_;
    std::vector<uint16_t> honor_by_code_;
    std::vector<uint32_t> honor_labels_;
    std::array<std::vector<uint32_t>,64> triples_by_tiles_;
    std::array<std::vector<uint64_t>,35> bucket_sizes_;
    std::vector<uint64_t> group_colex2_, group_colex3_;

    static uint32_t pack(Label x) {
        return uint32_t(x.pr | (x.ad<<6) | (x.q<<12) | (x.si<<15) |
                        (x.mi<<16) | (x.kp<<20) | (x.n<<21));
    }
    static Label unpack(uint32_t x) {
        return {int(x&63), int((x>>6)&63), int((x>>12)&7), int((x>>15)&1),
                int((x>>16)&15), int((x>>20)&1), int(x>>21)};
    }
    static Label from_code(uint32_t code, bool honors) {
        const ::Local& l = (honors ? ::ho : ::su)[code];
        int n=0; for (uint32_t x=code; x; x/=5) n+=x%5;
        return {l.profile,l.add,l.q,l.singles?1:0,l.miss,l.kpair,n};
    }
    static Label join(Label a, Label b) {
        return {::comb[a.pr][b.pr],
                ::uni[::comb[a.ad][b.pr]][::comb[a.pr][b.ad]],
                a.q+b.q,a.si|b.si,a.mi+b.mi,a.kp|b.kp,a.n+b.n};
    }
    static bool partial(Label x) {
        return x.q<7 && ::pairmeld(x.pr)<4 && ::pairmeld(x.ad)<4 &&
               !(x.q==6 && x.si);
    }
    static bool full_safe(Label x) {
        return partial(x) && !(x.mi==0 || (x.mi==1 && x.kp));
    }
    static uint64_t c2_start(uint64_t x) { return x*(x+1)/2; }
    static uint64_t c3_start(uint64_t x) { return x*(x+1)*(x+2)/6; }
    static uint64_t pair_y(uint64_t r) {
        uint64_t y=uint64_t((std::sqrt(8.0*double(r)+1.0)-1.0)/2.0);
        while(c2_start(y+1)<=r) ++y;
        while(c2_start(y)>r) --y;
        return y;
    }
    static uint64_t triple_z(uint64_t r, uint64_t limit) {
        uint64_t lo=0,hi=limit;
        while(lo+1<hi) { uint64_t mid=(lo+hi)/2; if(c3_start(mid)<=r)lo=mid;else hi=mid; }
        return lo;
    }
    static void sort_ids(std::array<uint32_t,3>& ids) {
        if(ids[0]>ids[1])std::swap(ids[0],ids[1]);
        if(ids[1]>ids[2])std::swap(ids[1],ids[2]);
        if(ids[0]>ids[1])std::swap(ids[0],ids[1]);
    }
    std::array<uint32_t,3> decode_block(uint32_t tid, uint64_t r) const {
        const Triple& t=triples_[tid];
        const Group& a=groups_[t.g0];const Group& b=groups_[t.g1];const Group& c=groups_[t.g2];
        uint64_t x=0,y=0,z=0;
        if(t.g0==t.g2) {
            z=triple_z(r,a.size);r-=c3_start(z);y=pair_y(r);x=r-c2_start(y);
        } else if(t.g0==t.g1) {
            uint64_t p=c2_start(a.size);z=r/p;r%=p;y=pair_y(r);x=r-c2_start(y);
        } else if(t.g1==t.g2) {
            x=r%a.size;r/=a.size;z=pair_y(r);y=r-c2_start(z);
        } else {
            x=r%a.size;r/=a.size;y=r%b.size;z=r/b.size;
        }
        return {a.first+uint32_t(x),b.first+uint32_t(y),c.first+uint32_t(z)};
    }
    size_t block_at(const Bucket& bucket,uint64_t r) const {
        if(r>=bucket.size)throw std::out_of_range("decode rank outside bucket");
        auto it=std::upper_bound(bucket.blocks.begin(),bucket.blocks.end(),r,
            [](uint64_t value,const Block& block){return value<block.offset;});
        if(it==bucket.blocks.begin())throw std::logic_error("invalid bucket block directory");
        return size_t((it-bucket.blocks.begin())-1);
    }
    void hash_uint(uint64_t x,unsigned bytes) {
        for(unsigned i=0;i<bytes;++i){fingerprint^=uint8_t(x);fingerprint*=1099511628211ULL;x>>=8;}
    }
    void compute_fingerprint() {
        fingerprint=14695981039346656037ULL;
        for(const char* s=INDEX_SCHEMA;*s;++s)hash_uint(uint8_t(*s),1);
        hash_uint(numeric.size(),8);hash_uint(honors.size(),8);hash_uint(groups_.size(),8);hash_uint(triples_.size(),8);
        for(const auto& g:groups_){hash_uint(g.first,4);hash_uint(g.size,4);hash_uint(g.label,4);}
        for(const auto& x:numeric){hash_uint(x.code,4);hash_uint(x.group,2);hash_uint(x.member,2);hash_uint(x.tiles,1);hash_uint(x.next_count,1);for(unsigned i=0;i<x.next_count;++i)hash_uint(x.next[i],4);}
        for(size_t h=0;h<honors.size();++h){const auto& x=honors[h];hash_uint(x.code,4);hash_uint(honor_labels_[h],4);hash_uint(x.tiles,1);hash_uint(x.next_count,1);for(unsigned i=0;i<x.next_count;++i)hash_uint(x.next[i],2);}
        for(const auto& t:triples_){hash_uint(t.g0,2);hash_uint(t.g1,2);hash_uint(t.g2,2);hash_uint(t.label,4);hash_uint(t.size,8);}
    }

public:
    std::vector<Numeric> numeric;
    std::vector<Honor> honors;
    uint64_t fingerprint=0;

    Index() {
        static const bool rules_ready=[](){::init();return true;}();(void)rules_ready;
        std::map<uint32_t,std::vector<uint32_t>> grouped;
        for(uint32_t code=0;code<::su.size();++code) {
            if(::su[code].canonical!=code)continue;
            Label l=from_code(code,false);if(partial(l))grouped[pack(l)].push_back(code);
        }
        numeric_by_code_.assign(::SN,BAD_ID);
        numeric.reserve(131676);groups_.reserve(grouped.size());
        for(const auto& kv:grouped) {
            const uint16_t gid=uint16_t(groups_.size());
            if(kv.second.size()>UINT16_MAX)throw std::runtime_error("numeric group member overflow");
            groups_.push_back({uint32_t(numeric.size()),uint32_t(kv.second.size()),kv.first});
            uint16_t member=0;
            for(uint32_t code:kv.second) {
                Numeric x;x.code=code;x.group=gid;x.member=member++;x.tiles=uint8_t(kv.first>>21);x.next.fill(BAD_ID);
                numeric_by_code_[code]=uint32_t(numeric.size());numeric.push_back(x);
            }
        }
        honor_by_code_.assign(::HN,BAD_HONOR);
        for(uint32_t code=0;code<::ho.size();++code) {
            if(::ho[code].canonical!=code)continue;
            Label l=from_code(code,true);if(!partial(l))continue;
            Honor x;x.code=code;x.tiles=uint8_t(l.n);x.next.fill(BAD_HONOR);
            honor_by_code_[code]=uint16_t(honors.size());honors.push_back(x);honor_labels_.push_back(pack(l));
        }
        for(auto& x:numeric) {
            uint32_t v=x.code;
            for(unsigned p=0;p<9;++p){unsigned d=v%5;v/=5;if(d==4)continue;
                uint32_t id=numeric_by_code_[::su[x.code+::pw[p]].canonical];
                if(id!=BAD_ID&&std::find(x.next.begin(),x.next.begin()+x.next_count,id)==x.next.begin()+x.next_count)x.next[x.next_count++]=id;
            }
            std::sort(x.next.begin(),x.next.begin()+x.next_count);
        }
        for(auto& x:honors) {
            uint32_t v=x.code;
            for(unsigned p=0;p<7;++p){unsigned d=v%5;v/=5;if(d==4)continue;
                uint16_t id=honor_by_code_[::ho[x.code+::pw[p]].canonical];
                if(id!=BAD_HONOR&&std::find(x.next.begin(),x.next.begin()+x.next_count,id)==x.next.begin()+x.next_count){
                    if(x.next_count==4)throw std::logic_error("more than four honor successors");
                    x.next[x.next_count++]=id;
                }
            }
            std::sort(x.next.begin(),x.next.begin()+x.next_count);
        }
        if(numeric.size()!=131676||honors.size()!=184||groups_.size()!=1104)throw std::runtime_error("local inventory differs from audited schema");
        const uint64_t ng=groups_.size();
        triple_lut_.assign(size_t(c3_start(ng)),BAD_ID);
        group_colex2_.resize(ng);group_colex3_.resize(ng);
        for(uint64_t g=0;g<ng;++g){group_colex2_[g]=c2_start(g);group_colex3_[g]=c3_start(g);}
        triples_.reserve(3199905);
        std::unordered_map<uint32_t,uint64_t> aggregate;
        std::vector<Label> gl;gl.reserve(ng);for(const auto& g:groups_)gl.push_back(unpack(g.label));
        for(uint32_t i=0;i<ng;++i)for(uint32_t j=i;j<ng;++j){
            Label two=join(gl[i],gl[j]);if(!partial(two))continue;
            for(uint32_t k=j;k<ng;++k){Label l=join(two,gl[k]);if(!partial(l))continue;
                const uint64_t a=groups_[i].size,b=groups_[j].size,c=groups_[k].size;
                const uint64_t ways=i==k?c3_start(a):i==j?c2_start(a)*c:j==k?a*c2_start(b):a*b*c;
                const uint32_t tid=uint32_t(triples_.size()), label=pack(l);
                triples_.push_back({uint16_t(i),uint16_t(j),uint16_t(k),label,ways});
                triple_lut_[i+group_colex2_[j]+group_colex3_[k]]=tid;
                triples_by_tiles_[l.n].push_back(tid);aggregate[label]+=ways;
            }
        }
        if(triples_.size()!=3199905)throw std::runtime_error("triple inventory differs from audited schema");
        for(auto& row:bucket_sizes_)row.assign(honors.size(),0);
        for(size_t h=0;h<honors.size();++h)for(const auto& kv:aggregate){
            Label l=join(unpack(kv.first),unpack(honor_labels_[h]));
            if(full_safe(l)){if(l.n>34)throw std::logic_error("SAFE state above audited bound");bucket_sizes_[l.n][h]+=kv.second;}
        }
        uint64_t total=0;for(const auto& row:bucket_sizes_)for(auto x:row)total+=x;
        if(total!=778532864302ULL)throw std::runtime_error("global SAFE count differs from audited total");
        compute_fingerprint();
    }
    Index(const Index&)=delete;
    Index& operator=(const Index&)=delete;
    Index(Index&&)=delete;
    Index& operator=(Index&&)=delete;

    size_t group_count()const{return groups_.size();}
    size_t triple_count()const{return triples_.size();}
    uint64_t fixed_table_bytes()const {
        return triple_lut_.capacity()*sizeof(uint32_t)+triples_.capacity()*sizeof(Triple)+
               numeric.capacity()*sizeof(Numeric)+numeric_by_code_.capacity()*sizeof(uint32_t)+
               ::su.capacity()*sizeof(::Local)+::ho.capacity()*sizeof(::Local);
    }
    uint64_t bucket_size(int n,int h) const {
        if(n<0||n>34||h<0||size_t(h)>=honors.size())return 0;
        return bucket_sizes_[n][h];
    }
    uint64_t layer_size(int n) const {
        if(n<0||n>34)return 0;uint64_t sum=0;for(auto x:bucket_sizes_[n])sum+=x;return sum;
    }
    Bucket make_bucket(int n,int h) const {
        if(h<0||size_t(h)>=honors.size())throw std::out_of_range("invalid honor ID");
        Bucket result;result.n=n;result.h=h;result.size=bucket_size(n,h);
        if(!result.size)return result;
        result.offsets.assign(triples_.size(),BAD_RANK);
        uint64_t offset=0;const int nt=n-honors[h].tiles;
        if(nt<0||nt>=64)throw std::logic_error("nonempty bucket has invalid numeric tile count");
        Label hl=unpack(honor_labels_[h]);
        for(uint32_t tid:triples_by_tiles_[nt]) {
            const Triple& t=triples_[tid];if(!full_safe(join(unpack(t.label),hl)))continue;
            result.offsets[tid]=offset;result.blocks.push_back({tid,offset,t.size});offset+=t.size;
        }
        if(offset!=result.size)throw std::logic_error("bucket directory sum mismatch");
        return result;
    }
    uint32_t tid_sorted(const std::array<uint32_t,3>& ids) const {
        if(ids[2]>=numeric.size())return BAD_ID;
        return triple_lut_[numeric[ids[0]].group+group_colex2_[numeric[ids[1]].group]+group_colex3_[numeric[ids[2]].group]];
    }
    uint64_t within_sorted(const std::array<uint32_t,3>& ids) const {
        const Numeric& a=numeric[ids[0]];const Numeric& b=numeric[ids[1]];const Numeric& c=numeric[ids[2]];
        const uint64_t x=a.member,y=b.member,z=c.member,na=groups_[a.group].size;
        if(a.group==c.group)return x+c2_start(y)+c3_start(z);
        if(a.group==b.group)return x+c2_start(y)+c2_start(na)*z;
        if(b.group==c.group)return x+na*(y+c2_start(z));
        return x+na*(y+uint64_t(groups_[b.group].size)*z);
    }
    uint64_t rank_sorted(const Bucket& bucket,const std::array<uint32_t,3>& ids) const {
        if(bucket.size==0)return BAD_RANK;
        uint32_t tid=tid_sorted(ids);if(tid==BAD_ID)return BAD_RANK;
        uint64_t offset=bucket.offsets[tid];return offset==BAD_RANK?BAD_RANK:offset+within_sorted(ids);
    }
    uint64_t rank(const Bucket& bucket,std::array<uint32_t,3> ids) const {
        sort_ids(ids);return rank_sorted(bucket,ids);
    }
    std::array<uint32_t,3> decode(const Bucket& bucket,uint64_t r) const {
        const Block& b=bucket.blocks[block_at(bucket,r)];return decode_block(b.tid,r-b.offset);
    }
    ::State physical(const std::array<uint32_t,3>& ids,int h) const {
        if(h<0||size_t(h)>=honors.size()||ids[0]>=numeric.size()||ids[1]>=numeric.size()||ids[2]>=numeric.size())throw std::out_of_range("invalid physical state IDs");
        ::State s;s.c={numeric[ids[0]].code,numeric[ids[1]].code,numeric[ids[2]].code,honors[h].code};
        return ::canon(s);
    }
    std::pair<std::array<uint32_t,3>,int> encode(::State s) const {
        std::array<uint32_t,3> ids{BAD_ID,BAD_ID,BAD_ID};
        if(s.c[0]>=::SN||s.c[1]>=::SN||s.c[2]>=::SN||s.c[3]>=::HN)return {ids,-1};
        for(unsigned i=0;i<3;++i)ids[i]=numeric_by_code_[::su[s.c[i]].canonical];
        const uint16_t h=honor_by_code_[::ho[s.c[3]].canonical];
        sort_ids(ids);return {ids,h==BAD_HONOR?-1:int(h)};
    }

    class Cursor {
        const Index* index_=nullptr;
        const Bucket* bucket_=nullptr;
        size_t block_=0;
        uint32_t first0_=0,first1_=0,first2_=0,end0_=0,end1_=0;
        uint8_t mode_=0;
        void setup() {
            const Triple& t=index_->triples_[tid];
            const Group& a=index_->groups_[t.g0];const Group& b=index_->groups_[t.g1];const Group& c=index_->groups_[t.g2];
            first0_=a.first;first1_=b.first;first2_=c.first;end0_=a.first+a.size;end1_=b.first+b.size;
            mode_=t.g0==t.g2?3:t.g0==t.g1?1:t.g1==t.g2?2:0;
        }
        friend class Index;
        Cursor(const Index* index,const Bucket* bucket,uint64_t r):index_(index),bucket_(bucket) {
            if(r>bucket_->size)throw std::out_of_range("cursor start outside bucket");
            if(r==bucket_->size)return;
            block_=index_->block_at(*bucket_,r);const Block& b=bucket_->blocks[block_];
            tid=b.tid;within=r-b.offset;ids=index_->decode_block(tid,within);setup();
        }
    public:
        std::array<uint32_t,3> ids{BAD_ID,BAD_ID,BAD_ID};
        uint32_t tid=BAD_ID;
        uint64_t within=0;
        bool valid()const{return tid!=BAD_ID;}
        void advance() {
            if(tid==BAD_ID)return;
            if(++within==bucket_->blocks[block_].size) {
                ++block_;within=0;
                if(block_==bucket_->blocks.size()){tid=BAD_ID;ids={BAD_ID,BAD_ID,BAD_ID};return;}
                tid=bucket_->blocks[block_].tid;setup();ids={first0_,first1_,first2_};return;
            }
            if(mode_==0) {
                if(++ids[0]<end0_)return;ids[0]=first0_;
                if(++ids[1]<end1_)return;ids[1]=first1_;++ids[2];
            } else if(mode_==1) {
                if(++ids[0]<=ids[1])return;ids[0]=first0_;
                if(++ids[1]<end0_)return;ids[1]=first1_;++ids[2];
            } else if(mode_==2) {
                if(++ids[0]<end0_)return;ids[0]=first0_;
                if(++ids[1]<=ids[2])return;ids[1]=first1_;++ids[2];
            } else {
                if(++ids[0]<=ids[1])return;ids[0]=first0_;
                if(++ids[1]<=ids[2])return;ids[1]=first1_;++ids[2];
            }
        }
    };
    Cursor cursor(const Bucket& bucket,uint64_t start=0) const {return Cursor(this,&bucket,start);}
};

} // namespace retro
#endif
