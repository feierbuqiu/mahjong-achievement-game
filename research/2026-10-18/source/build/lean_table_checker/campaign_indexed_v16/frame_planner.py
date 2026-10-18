"""Exact full-T resource admission. This does not replace actual Lean checks."""
from dataclasses import dataclass
from pathlib import Path
import hashlib,json,mmap,struct

COUNT_CAP=67_108_864
BLOCK_CAP=8192
TEMPLATE_CAP=500000
SCHEMA='METADATA_ONLY_TEMPLATE_ROW_CAP_SCENARIO_V13_V2'
SCHEDULE='OWNED_EXACT_COMPLETE_T_FRAME_SCHEDULE_V14'
RECORD=struct.Struct('<QQIIII')

def need(v,m):
    if not v:raise ValueError(m)
def policy(templates=500000):
    need(type(templates) is int and templates in (250000,500000),'Registered complete T250k/T500k policy required')
    return dict(schema=SCHEMA,max_rows=COUNT_CAP,max_source_blocks=BLOCK_CAP,max_plan_templates=templates,
        raw_plan_rows_and_edges_are_diagnostic=True,full_block_costs=True,SAFE_false_targets_included=True,
        cache_reuse_never_reduces_budget=True,memory_bytes_guaranteed=False)
def validate_policy(p):need(p==policy(p['max_plan_templates']),'Large-frame policy differs from explicit registered bounds')
def canonical(value):return json.dumps(value,sort_keys=True,separators=(',',':'),ensure_ascii=False).encode()
def policy_sha(value):
    validate_policy(value)
    return hashlib.sha256(canonical(value)).hexdigest()

def model_policy(p):
    validate_policy(p)
    need(p['full_block_costs'] is True and p['SAFE_false_targets_included'] is True and
        p['cache_reuse_never_reduces_budget'] is True and p['raw_plan_rows_and_edges_are_diagnostic'] is True,'Cannot convert a weakened partition policy')
    return dict(max_rows=p['max_rows'],max_source_blocks=p['max_source_blocks'],max_full_templates=p['max_plan_templates'],
        raw_plan_rows_diagnostic_only=True,raw_plan_edges_diagnostic_only=True,full_first_and_last_block_costs=True,all_SAFE_and_unsafe_target_keys=True)

@dataclass(frozen=True)
class Work:
    group_sizes:tuple
    group_edges:tuple
    honor_degrees:tuple
    group_templates:tuple
    honor_templates:tuple
    honor_codes:tuple=()

    @classmethod
    def from_bytes(cls,groups,numeric,honors):
        need(len(groups)==1104*8 and len(numeric)==131676*44 and len(honors)==184*24,'Exact fixed next/group shapes required')
        members=[-1]*131676;sizes=[];ranges=[];cursor=0
        for g,(first,size) in enumerate(struct.iter_unpack('<II',groups)):
            need(first==cursor and size>0 and first+size<=len(members),'Groups are not an exact member partition')
            members[first:first+size]=[g]*size;ranges.append((first,size));sizes.append(size);cursor+=size
        need(cursor==len(members),'Group partition omits local IDs')
        degrees=[];templates=[]
        for first,size in ranges:
            degree=0;targets=set()
            for member in range(first,first+size):
                values=struct.unpack_from('<11I',numeric,member*44);n=values[1];need(n<=9,'Actual numeric arity exceeds cache shape');degree+=n
                for target in values[2:2+n]:
                    need(target<len(members),'Actual next target outside member inventory');targets.add(members[target])
            degrees.append(degree);templates.append(len(targets))
        hdegrees=[];htemplates=[];codes=[]
        for values in struct.iter_unpack('<6I',honors):
            codes.append(values[0])
            n=values[1];need(n<=4,'Actual honor arity exceeds cache shape');targets=set(values[2:2+n]);need(all(h<184 for h in targets),'Honor target outside inventory')
            hdegrees.append(n);htemplates.append(len(targets))
        return cls(tuple(sizes),tuple(degrees),tuple(hdegrees),tuple(templates),tuple(htemplates),tuple(codes))

    def block(self,record,honor):
        need(type(honor) is int and 0<=honor<len(self.honor_degrees),'Honor outside fixed inventory');keys=record[2:5]
        need(all(0<=g<len(self.group_sizes) for g in keys),'Directory key outside source group inventory')
        return (1+sum(self.group_sizes[g] for g in keys),sum(self.group_edges[g] for g in keys)+self.honor_degrees[honor],
            sum(self.group_templates[g] for g in keys)+self.honor_templates[honor])

class Directory:
    def __init__(self,data):need(len(data)>0 and len(data)%32==0,'Actual complete32B directory required');self.data=data;self.blocks=len(data)//32
    def __getitem__(self,i):
        need(0<=i<self.blocks,'Directory block outside input');r=RECORD.unpack_from(self.data,i*32);need(r[1]>0,'Source block has zero width');return r
    def at(self,row):
        lo=0;hi=self.blocks
        while lo<hi:
            mid=(lo+hi)//2
            if self[mid][0]<=row:lo=mid+1
            else:hi=mid
        i=lo-1;need(i>=0 and self[i][0]<=row<sum(self[i][:2]),'Source row is outside exact directory');return i

class MappedDirectory:
    def __init__(self,path):self.path=Path(path);self.f=self.m=None
    def __enter__(self):
        self.f=self.path.open('rb')
        try:self.m=mmap.mmap(self.f.fileno(),0,access=mmap.ACCESS_READ);return Directory(self.m)
        except BaseException:self.f.close();raise
    def __exit__(self,*args):
        if self.m is not None:self.m.close()
        if self.f is not None:self.f.close()

def partition(directory,work,honor,start,count,size,budget):
    validate_policy(budget);need(type(start) is int and type(count) is int and 0<=start<start+count<=size,'Exact positive source extent required')
    need(directory[0][0]==0 and sum(directory[directory.blocks-1][:2])==size,'Directory endpoints differ from source size')
    cursor=start;end=start+count;index=0
    while cursor<end:
        first=directory.at(cursor);block=first;stop=cursor;limit=min(end,cursor+budget['max_rows']);rows=edges=templates=blocks=0
        first_r=first_e=first_t=0
        while stop<limit:
            record=directory[block];offset,width=record[:2];need(offset<=stop<offset+width,'Directory gap or overlap')
            r,e,t=work.block(record,honor)
            if blocks+1>budget['max_source_blocks'] or templates+t>budget['max_plan_templates']:
                need(blocks>0,'SINGLE_COMPLETE_SOURCE_BLOCK_EXCEEDS_LARGE_FRAME_BUDGET');break
            if blocks==0:first_r,first_e,first_t=r,e,t
            rows+=r;edges+=e;templates+=t;blocks+=1;stop=min(limit,offset+width)
            if stop==limit:break
            block+=1;need(directory[block][0]==offset+width,'Noncontiguous actual source blocks')
        need(cursor<stop,'T-only planner made no progress')
        yield dict(index=index,start=cursor,count=stop-cursor,first_block=first,last_block=first+blocks-1,source_blocks=blocks,
            plan_rows=rows,plan_edges=edges,templates=templates,first_block_plan_rows=first_r,first_block_plan_edges=first_e,
            first_block_templates=first_t,full_block_costs=True)
        cursor=stop;index+=1

def validate_frames(frames,start,count,budget):
    validate_policy(budget);cursor=start
    for i,f in enumerate(frames):
        need(f['index']==i and f['start']==cursor and 0<f['count']<=COUNT_CAP,'Frame coverage has hole, overlap or count overflow')
        need(f.get('full_block_costs') is True and 0<f['source_blocks']<=BLOCK_CAP and f['source_blocks']==f['last_block']-f['first_block']+1,'Wrong complete block admission')
        need(type(f['templates']) is int and 0<=f['templates']<=budget['max_plan_templates'],'Complete T exceeds selected budget')
        need(0<=f['first_block_templates']<=f['templates'] and 0<f['first_block_plan_rows']<=f['plan_rows'] and 0<=f['first_block_plan_edges']<=f['plan_edges'],'First complete block cost invalid')
        cursor+=f['count']
    need(bool(frames) and cursor==start+count,'Frames do not cover the complete requested source interval')

def check_native_work(worker,frame,budget,expected_reuse=None):
    validate_policy(budget);need(worker.get('plan_blocks')==frame['source_blocks'],'Actual source-block work differs')
    need(worker.get('frame_full_templates_without_reuse')==frame['templates'] and frame['templates']<=budget['max_plan_templates'] and
        worker.get('frame_template_count_includes_SAFE_and_unsafe') is True,'Actual full T/unsafe admission differs')
    reused=worker.get('plans_reused');need(type(reused) is int and reused in (0,1),'Unexpected previous-block reuse count')
    if expected_reuse is not None:need(reused==int(expected_reuse),'Actual previous-block reuse differs from epoch/source identity')
    for field in ('plan_rows','plan_edges'):
        need(worker.get(field)==frame[field]-(frame['first_block_'+field] if reused else 0),'Diagnostic raw R/E omitted actual work')
    need(worker.get('plan_templates')==frame['templates']-(frame['first_block_templates'] if reused else 0),'Actual materialized T differs from complete block work minus exact reuse')
