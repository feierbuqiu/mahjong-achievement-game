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
