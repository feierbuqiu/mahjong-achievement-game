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
