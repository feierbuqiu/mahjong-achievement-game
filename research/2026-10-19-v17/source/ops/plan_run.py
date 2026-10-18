"""New all35-layer inventory. Existing labels are inputs, never accepted seeds."""
from pathlib import Path
import argparse,json,struct,uuid
import common as c

LTC='runs/lean_table_checker/'
DEFAULT=dict(cache_root=LTC+'summary_full_v1/inputs',raw_root=LTC+'full_safe_local_v1/inputs',
 inventory_root=LTC+'canonical_inventory_resume_v1/inputs',index_root=LTC+'campaign_20261018_v4/index',
 successor_root=LTC+'successor_cache_v1/inputs',data_root='runs/global_retro/pilot_v1/data',
 catalog_file=LTC+'campaign_20261018_v4/index/catalog.tsv',bound_root=LTC+'group_directory_local_v1/inputs',
 prefix_root=LTC+'prefix_directory_local_v1/inputs',triple_labels_file=LTC+'semantic_directory_local_v1/inputs/triple_labels.bin')

def inventory(config):
    paths={k:c.path(v) for k,v in config.items()};files={};roles={}
    def add(p,role,size=None):
        p=c.path(p);got=p.stat().st_size
        if size is not None:c.need(got==size,'Wrong extent: '+str(p))
        name=c.rel(p);files[name]=dict(bytes=got);roles.setdefault(name,[]).append(role);return name
    for folder,leaves in [('cache_root',['numeric.bin','honors.bin','summary_numeric.bin','summary_honors.bin']),
                         ('raw_root',['raw_numeric.bin','raw_honors.bin']),
                         ('inventory_root',['ids_numeric.bin','ids_honors.bin','members_numeric.bin','members_honors.bin']),
                         ('index_root',['numeric.bin','numeric_ids.bin','groups.bin','honor_ids.bin']),
                         ('successor_root',['numeric.bin','honors.bin'])]:
        for leaf in leaves:add(paths[folder]/leaf,'common '+folder)
    add(paths['catalog_file'],'original catalog')
    for stem in ['num','hon','two','three','four']:
        add(paths['bound_root']/(stem+'.entries'),'finite bound entries')
        add(paths['bound_root']/(stem+'.index'),'finite bound lookup',65536*4)
    add(paths['prefix_root']/'triples.bin','finite triple keys',3199905*12)
    add(paths['triple_labels_file'],'finite triple labels',3199905*12)
    for h in range(184):add(paths['prefix_root']/f'h{h}.bin','finite honor directory')
    parsed={}
    for line in paths['catalog_file'].read_text(encoding='utf-8-sig').splitlines():
        if not line.strip():continue
        n,h,code,size,blocks=map(int,line.split())
        c.need(0<=n<35 and 0<=h<184 and 0<=code<78125 and size>=0 and blocks>=0 and (size==0)==(blocks==0),'Invalid catalog row')
        c.need((n,h) not in parsed,'Duplicate catalog cell');parsed[n,h]=(code,size,blocks)
    honors=(paths['successor_root']/'honors.bin').read_bytes();c.need(len(honors)==184*24,'Honor edge shape')
    cells=[]
    for n in range(35):
        for h in range(184):
            code,arity,*targets=struct.unpack_from('<6I',honors,h*24)
            c.need(arity<=4 and all(t<184 for t in targets[:arity]),'Honor edge bound')
            row=parsed.get((n,h),(code,0,0));c.need(row[0]==code,'Catalog honor code differs from actual edge table')
            _,size,blocks=row;cell=dict(layer=n,honor=h,code=code,size=size,blocks=blocks,
                                      needed_honors=sorted(set([h]+targets[:arity])))
            if size:
                name=c.bucket_key(n,h)
                cell['directory']=add(paths['index_root']/(name+'.dir'),'source directory',blocks*32)
                cell['bits']=add(paths['data_root']/(name+'.bits'),'unverified historical source labels',((size+63)//64)*8)
                meta=paths['data_root']/(name+'.complete.json')
                if meta.exists():cell['legacy_transport_metadata']=add(meta,'untrusted proposer extent metadata; not imported acceptance')
            cells.append(cell)
    c.need(len(cells)==6440 and sum(bool(x['size']) for x in cells)==3686 and sum(x['size'] for x in cells)==778532864302,'Full exact inventory differs')
    return cells,files,roles

def main():
    a=argparse.ArgumentParser();a.add_argument('--name');a.add_argument('--config');v=a.parse_args()
    name=v.name or 'activity_'+uuid.uuid4().hex[:12]
    c.need(name.replace('_','').replace('-','').isalnum() and len(name)<=60,'Short independent activity name')
    run=c.RUNS/name;c.need(not run.exists(),'New activity only');run.mkdir(parents=True)
    config=c.load(c.path(v.config)) if v.config else DEFAULT
    c.need(set(config)==set(DEFAULT),'Exactly ten input root fields required')
    config={k:c.rel(c.path(p)) for k,p in config.items()}
    cells,files,roles=inventory(config)
    catalog=''.join(f"{x['layer']}\t{x['honor']}\t{x['code']}\t{x['size']}\t{x['blocks']}\n" for x in cells)
    catalog_rec=c.once(run/'catalog_all35.tsv',catalog.encode())
    files[catalog_rec['path']]=dict(bytes=catalog_rec['bytes']);roles[catalog_rec['path']]=['new complete all35 catalog']
    config['catalog_file']=catalog_rec['path']
    common=dict(numeric=config['index_root']+'/numeric.bin',ids=config['index_root']+'/numeric_ids.bin',groups=config['index_root']+'/groups.bin')
    value=dict(schema='V17_ALL_LAYER_NATIVE_ACTIVITY_PLAN_V1',status='PLANNED_NO_ACCEPTANCE_IMPORTED',created_utc=c.utc(),
        name=name,config=config,catalog=catalog_rec,cells=cells,input_inventory=files,input_roles=roles,common_identity_fields=common,
        nonempty_buckets=3686,empty_cells=2754,total_cells=6440,total_rows=778532864302,
        old_PASS_or_seed_imported=False,new_verified_rows=0,
        frame_policy=dict(max_rows=67108864,max_source_blocks=8192,max_full_templates=250000,logical_fragments=12,row_rounds=1),
        initial_pool_threads=12,wall_hard_limit_seconds=None,RAM_hard_limit_bytes=None,
        memory_policy='MONITOR_PHYSICAL_AVAILABLE_AND_RESPONSIVENESS_REDUCE_EXECUTION_CONCURRENCY',
        start_condition='NEW_MAIN_REQUIRED_SMOKE_AND_BOOKKEEPER_NEGATIVES_PASS',
        claim_class='FIXED_V17_KERNEL_IMPLICATION_PLUS_NATIVE_COMPUTATION',closed_actual_input_Lean_declaration=False,
        legacy_STOP_left_unchanged=True)
    rec=c.once(run/'PLAN.json',value)
    # This is configuration only. It carries no imported computation acceptance.
    def linux(p):
        v=c.path(p).as_posix();c.need(len(v)>2 and v[1]==':','Windows workspace expected')
        return '/mnt/'+v[0].lower()+v[2:]
    native_config={k:linux(p) for k,p in config.items()}
    native_config_rec=c.once(run/'native_config.json',native_config)
    c.atomic(run/'progress.json',dict(schema='V17_LOCAL_PROGRESS',stage='PLANNED',verified_rows=0,total_rows=value['total_rows'],percent=0,model_calls=0,notifications=False))
    print(json.dumps(dict(run=c.rel(run),plan=rec,native_config=native_config_rec,input_files=len(files),logical_input_bytes=sum(x['bytes'] for x in files.values()),nonempty=3686,rows=value['total_rows'])))

if __name__=='__main__':main()
