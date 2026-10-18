"""Read-lock actual all35 inputs and hash them; no checker or scan is launched.

With --hold, custody remains live until the owning controller has confirmed
all Linux services exited and writes an exact token-bearing release request.
The result is IO identity evidence, never a mathematical acceptance.
"""
import argparse,os,sys,time,traceback,uuid
from pathlib import Path
import common as c

def owner():
    import psutil
    return dict(pid=os.getpid(),creation_time=psutil.Process().create_time())

def run(run_dir,hold):
    run_dir=c.owned(run_dir);plan_path=run_dir/'PLAN.json';plan=c.load(plan_path)
    c.need(plan['schema']=='V17_ALL_LAYER_NATIVE_ACTIVITY_PLAN_V1' and plan['old_PASS_or_seed_imported'] is False,'Only a new all35 plan')
    token=uuid.uuid4().hex;attempt=run_dir/'input_custody'/token;attempt.mkdir(parents=True)
    own=owner();started=time.monotonic();files={};last=0.;done=0
    total=sum(x['bytes'] for x in plan['input_inventory'].values())
    intent=dict(schema='V17_INPUT_CUSTODY_INTENT_V1',token=token,owner=own,plan=c.record(plan_path),
                created_utc=c.utc(),hold=hold,input_count=len(plan['input_inventory']),input_bytes=total)
    c.once(attempt/'intent.json',intent)
    c.atomic(run_dir/'INPUT_CUSTODY_CURRENT.json',dict(intent=c.record(attempt/'intent.json'),token=token))
    def report(stage,current=None,current_done=0,force=False):
        nonlocal last
        now=time.monotonic()
        if force or now-last>=15:
            value=dict(schema='V17_INPUT_HASH_PROGRESS_V1',stage=stage,token=token,owner=own,updated_utc=c.utc(),
                files_completed=len(files),files_total=len(plan['input_inventory']),bytes_completed=done,
                bytes_total=total,current_file=current,current_file_bytes_hashed=current_done,
                elapsed_seconds=now-started,physical_memory=c.system_memory(),model_calls=0,notifications=False)
            c.atomic(attempt/'progress.json',value);c.atomic(run_dir/'input_hash_progress.json',value);last=now
    def guard():
        c.need(not (run_dir/'STOP').exists(),'Own activity STOP requested during input hash')
    static=[plan_path,run_dir/'native_config.json',Path(__file__),c.BASE/'common.py',
            c.ROOT/'build/lean_table_checker/read_lock_footprint_v13/shared_read_locks.py']
    with c.OwnerLock(run_dir/'input_hash_owner.lock'):
        locks=None
        try:
            report('ACQUIRING_ALL_INPUT_READLOCKS',force=True)
            locks=c.ReadLocks(list(plan['input_inventory'])+static)
            c.once(attempt/'locks_acquired.json',dict(schema='V17_INPUT_LOCKS_ACQUIRED_V1',token=token,owner=own,
                acquired_utc=c.utc(),input_count=len(plan['input_inventory']),continuous_until_release=True))
            # Metadata first, then label banks. This is scheduling only.
            names=sorted(plan['input_inventory'],key=lambda x:(x.endswith('.bits'),plan['input_inventory'][x]['bytes'],x))
            for name in names:
                guard();report('HASHING_ACTUAL_LOCKED_INPUTS',name)
                got=c.sha_file(name,guard,lambda count:report('HASHING_ACTUAL_LOCKED_INPUTS',name,count))
                c.need(got['bytes']==plan['input_inventory'][name]['bytes'],'Planned input extent changed: '+name)
                files[name]=got;done+=got['bytes']
            result=dict(schema='V17_ACTUAL_READLOCKED_INPUT_IDENTITIES_V1',token=token,owner=own,plan=intent['plan'],
                input_count=len(files),input_bytes=done,files=files,files_sha256=c.digest(files),
                wall_seconds=time.monotonic()-started,continuous_Windows_deny_write_delete_custody=os.name=='nt',
                no_old_acceptance_imported=True,Native_processes_started=0,GPU_processes_started=0,
                source_files={c.rel(p):c.sha_file(p) for p in static if str(p).endswith('.py')})
            rec=c.once(attempt/'identities.json',result)
            c.atomic(run_dir/'INPUTS_BEFORE.json',dict(identity_record=rec,token=token,owner=own))
            report('HASH_COMPLETE_CUSTODY_HELD' if hold else 'HASH_COMPLETE_NO_CONTINUING_CUSTODY',force=True)
            print(c.canonical(dict(event='INPUT_HASH_COMPLETE',identities=rec,token=token,hold=hold)).decode(),flush=True)
            if hold:
                release=attempt/'RELEASE.json'
                while not release.exists():
                    report('HASH_COMPLETE_CUSTODY_HELD');time.sleep(1)
                request=c.load(release)
                c.need(request.get('token')==token and request.get('identity_record')==rec and
                       request.get('all_owned_services_confirmed_exited') is True,'Invalid custody release request')
                c.once(attempt/'release_ack.json',dict(schema='V17_INPUT_CUSTODY_RELEASE_ACK_V1',token=token,
                    request=c.record(release),confirmed_utc=c.utc()))
            c.once(attempt/'closed.json',dict(schema='V17_INPUT_CUSTODY_CLOSED_V1',token=token,owner=own,
                closed_utc=c.utc(),normal=True,Native_processes_started=0,GPU_processes_started=0))
        except BaseException as error:
            c.atomic(attempt/'failure.json',dict(error=repr(error),traceback=traceback.format_exc(),token=token,
                at_utc=c.utc(),new_verified_rows=0,Native_processes_started=0,GPU_processes_started=0))
            raise
        finally:
            if locks is not None:locks.close()

def main():
    parser=argparse.ArgumentParser();parser.add_argument('--run',required=True);parser.add_argument('--hold',action='store_true')
    args=parser.parse_args();run(args.run,args.hold)

if __name__=='__main__':main()
