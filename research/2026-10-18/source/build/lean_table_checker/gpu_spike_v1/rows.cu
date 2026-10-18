// Experimental arithmetic backend, shared verbatim by CUDA and the CPU timing
// control. Not a Lean-certified implementation or an acceptance checker.
#ifdef GPU_BUILD
#define FN __device__ __forceinline__
#else
#define FN inline
#endif
typedef unsigned int U32;
typedef unsigned long long U64;
typedef unsigned char U8;
static const U64 BAD = ~0ULL;
struct Bucket { U64 directory, bits, size; U32 blocks, honor; };
struct Result { U64 child; U32 move, flags; };
FN U64 c2(U64 x) { return x*(x+1)/2; }
FN U64 c3(U64 x) { return x*(x+1)*(x+2)/6; }
FN U64 off(const U32* d, U32 b) { return U64(d[b*8]) | (U64(d[b*8+1])<<32); }
FN U32 key(const U32* d, U32 b) { return (d[b*8+4]*1104+d[b*8+5])*1104+d[b*8+6]; }
FN U32 bit(const Bucket& b, U64 r) { return (((const U8*)b.bits)[r/8]>>(r%8))&1; }
FN U64 floor_colex(U64 r, U64 hi, bool triple) {
    U64 lo=0;
    while(lo+1<hi) { U64 m=(lo+hi)/2; if((triple?c3(m):c2(m))<=r) lo=m; else hi=m; }
    return lo;
}
FN bool decode(const Bucket& b, const U32* groups, U64 row, U32* ids) {
    if(row>=b.size || !b.blocks) return false;
    const U32* d=(const U32*)b.directory;
    U32 lo=0,hi=b.blocks;
    while(lo+1<hi) { U32 m=(lo+hi)/2; if(off(d,m)<=row) lo=m; else hi=m; }
    U32 ga=d[lo*8+4],gb=d[lo*8+5],gc=d[lo*8+6];
    if(ga>=1104 || gb>=1104 || gc>=1104) return false;
    U64 na=groups[ga*2+1],nb=groups[gb*2+1],nc=groups[gc*2+1];
    if(!na || !nb || !nc) return false;
    U64 r=row-off(d,lo),x=0,y=0,z=0;
    if(ga==gc) { z=floor_colex(r,na,true);r-=c3(z);y=floor_colex(r,na,false);x=r-c2(y); }
    else if(ga==gb) { z=r/c2(na);r%=c2(na);y=floor_colex(r,na,false);x=r-c2(y); }
    else if(gb==gc) { x=r%na;r/=na;z=floor_colex(r,nc,false);y=r-c2(z); }
    else { x=r%na;r/=na;y=r%nb;z=r/nb; }
    if(x>=na || y>=nb || z>=nc) return false;
    ids[0]=groups[ga*2]+U32(x);ids[1]=groups[gb*2]+U32(y);ids[2]=groups[gc*2]+U32(z);
    return ids[2]<131676;
}
FN U64 rank(const Bucket& b, const U32* numeric, const U32* groups, const U32* ids) {
    if(!b.blocks || ids[2]>=131676) return BAD;
    U32 ga=numeric[ids[0]*3+1],gb=numeric[ids[1]*3+1],gc=numeric[ids[2]*3+1];
    U32 target=(ga*1104+gb)*1104+gc;
    const U32* d=(const U32*)b.directory;
    U32 lo=0,hi=b.blocks;
    while(lo<hi) { U32 m=(lo+hi)/2; if(key(d,m)<target) lo=m+1; else hi=m; }
    if(lo==b.blocks || key(d,lo)!=target) return BAD;
    U64 x=numeric[ids[0]*3+2],y=numeric[ids[1]*3+2],z=numeric[ids[2]*3+2];
    U64 na=groups[ga*2+1],nb=groups[gb*2+1],within;
    if(ga==gc) within=x+c2(y)+c3(z);
    else if(ga==gb) within=x+c2(y)+c2(na)*z;
    else if(gb==gc) within=x+na*(y+c2(z));
    else within=x+na*(y+nb*z);
    U64 row=off(d,lo)+within;
    return row<b.size?row:BAD;
}
FN void sort3(U32* p) {
    U32 t;
    if(p[0]>p[1]) {t=p[0];p[0]=p[1];p[1]=t;}
    if(p[1]>p[2]) {t=p[1];p[1]=p[2];p[2]=t;}
    if(p[0]>p[1]) {t=p[0];p[0]=p[1];p[1]=t;}
}
FN U32 visit(const Bucket& b, const U32* numeric, const U32* groups,
            const U32* ids, bool strict, Result& out, U32 witness) {
    U64 r=rank(b,numeric,groups,ids);
    if(r==BAD) return 0; // Membership in the prechecked complete SAFE directory.
    if(strict) {
        U32 decoded[3];
        if(!decode(b,groups,r,decoded) || decoded[0]!=ids[0] || decoded[1]!=ids[1] || decoded[2]!=ids[2]) out.flags|=8;
    }
    if(bit(b,r)) { if(out.move==~0U) {out.child=r;out.move=witness;} return 1; }
    return 0;
}
FN Result evaluate(const U32* numeric,const U32* groups,const U32* edges,const U32* honors,
                   const Bucket& source,const Bucket* targets,U32 ntarget,U64 row,U32 mode) {
    Result out={BAD,~0U,0};U32 ids[3];
    if(!decode(source,groups,row,ids)) {out.flags=4;return out;}
    if(rank(source,numeric,groups,ids)!=row) {out.flags=4;return out;}
    if(mode==0) {out.flags=bit(source,row)?2:0;return out;}
    bool strict=mode==2;U32 found=0;
    const U32* he=honors+source.honor*6;
    for(U32 j=0;j<he[1];++j) {
        U32 h=he[j+2];
        for(U32 t=0;t<ntarget;++t) if(targets[t].honor==h) {
            found|=visit(targets[t],numeric,groups,ids,strict,out,3*131676+h);
            break;
        }
        if(found && !strict) break;
    }
    if(!found || strict) {
        const Bucket* same=0;
        for(U32 t=0;t<ntarget;++t) if(targets[t].honor==source.honor) same=&targets[t];
        if(same) for(U32 s=0;s<3;++s) {
            if(s && ids[s]==ids[s-1]) continue;
            const U32* next=edges+ids[s]*11;
            for(U32 j=0;j<next[1];++j) {
                U32 q[3]={ids[0],ids[1],ids[2]};q[s]=next[j+2];sort3(q);
                found|=visit(*same,numeric,groups,q,strict,out,s*131676+next[j+2]);
                if(found && !strict) break;
            }
            if(found && !strict) break;
        }
    }
    U32 isP=found?0:1;
    if(isP) out.flags|=2;
    if(isP!=bit(source,row)) out.flags|=1;
    return out;
}
#ifdef GPU_BUILD
extern "C" __global__ void scan_rows(const U32* numeric,const U32* groups,const U32* edges,
    const U32* honors,const Bucket* source,const Bucket* targets,U32 ntarget,
    U64 start,U32 count,U32 mode,Result* output) {
    U32 i=blockIdx.x*blockDim.x+threadIdx.x;
    if(i<count) output[i]=evaluate(numeric,groups,edges,honors,*source,targets,ntarget,start+i,mode);
}
#endif
