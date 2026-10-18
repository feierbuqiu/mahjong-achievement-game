"""Persistent local supervisor. It may run global startup before row permission.

Only loopback RPC is exposed. The Linux adapter owns the Native process and
all GPU activity; this supervisor holds immutable-input custody until cleanup.
"""
import argparse,json,os,queue,secrets,socket,socketserver,subprocess,sys,threading,time,traceback,uuid
from pathlib import Path
import common as c

def wsl(p):
    value=c.path(p).as_posix();c.need(value[1:2]==':','Windows caller required')
    return '/mnt/'+value[0].lower()+value[2:]

def code_paths():
    base=c.BASE;old=c.ROOT/'build/lean_table_checker/gpu_spike_v1'
    values=[base/'service.py',base/'fused_worker.py',base/'recover.py',base/'common.py',base/'rules_v17.py',
        c.ROOT/'build/lean_table_checker/read_lock_footprint_v13/shared_read_locks.py',
        c.ROOT/'build/lean_table_checker/gpu_indexed_byte_v16/worker.py',
        c.ROOT/'build/lean_table_checker/gpu_indexed_byte_receipt_v16/rules.py',
        c.ROOT/'build/lean_table_checker/gpu_stream_v4/worker_compact.py',
        c.ROOT/'build/lean_table_checker/cached_checker_v2/gpu_source_packets.py',
        old/'gpu_benchmark.py',old/'rows.cu',old/'deps/receipt.json',
        c.ROOT/'runs/lean_table_checker/gpu_spike_20261018_v1/acceptance.json']
    dependencies=c.load(old/'deps/receipt.json')
    for name in dependencies['files']:
        p=(old/'deps'/name).resolve();c.need(p.is_relative_to((old/'deps').resolve()),'Dependency escapes own root');values.append(p)
    return sorted(set(values))

class Supervisor:
    def __init__(self,run,native,pool):
        import psutil
        self.run=c.owned(run);self.native=c.record(native);self.plan=c.load(self.run/'PLAN.json');self.sid=uuid.uuid4().hex
        self.session=self.run/'sessions'/self.sid;self.session.mkdir(parents=True)
        self.owner=dict(pid=os.getpid(),creation_time=psutil.Process().create_time());self.token=secrets.token_hex(32)
        self.op_lock=threading.Lock();self.responses=queue.Queue();self.child=None;self.booted=None;self.failure=None
        self.stopped=threading.Event();self.ready_event=None;self.locks=None;self.requests=0;self.stderr=None;self.permission=None
        files=list(self.plan['input_inventory'])+code_paths()+[c.path(native),self.run/'PLAN.json',self.run/'native_config.json']
        self.state=dict(stage='ACQUIRING_INPUT_AND_CODE_CUSTODY',session_id=self.sid,owner=self.owner,started_utc=c.utc(),row_permission=False)
        self.persist()
        self.locks=c.ReadLocks(files)
        self.code_identity={c.rel(path):c.sha_file(path) for path in code_paths()}
        # The native file was hashed immediately before custody; hash again once
        # locked so the identity used to execute has no writer race.
        c.need(c.record(native)==self.native,'Native changed before custody')
        config=dict(schema='V17_LINUX_SERVICE_CONFIG_V1',run=c.rel(self.run),session_dir=c.rel(self.session),
            session_id=self.sid,owner=self.owner,native=self.native,pool_threads=pool,
            native_config=c.rel(self.run/'native_config.json'),input_config=self.plan['config'],
            output_adapter_revision='V17_OWN_OUTPUT_CUSTODY_UNCAPPED_HOST_MONITORED_V1')
        config_record=c.once(self.session/'config.json',config)
        self.stderr=(self.session/'adapter.stderr.log').open('xb',buffering=0)
        creation=getattr(subprocess,'CREATE_NO_WINDOW',0)
        self.child=subprocess.Popen(['wsl.exe','--exec','/usr/bin/python3','-B',wsl(c.BASE/'fused_worker.py'),wsl(config_record['path'])],
            stdin=subprocess.PIPE,stdout=subprocess.PIPE,stderr=self.stderr,cwd=c.ROOT,bufsize=0,creationflags=creation)
        c.once(self.session/'windows_child.json',dict(pid=self.child.pid,creation_time=psutil.Process(self.child.pid).create_time(),
             command=['wsl.exe','--exec','/usr/bin/python3','-B',c.rel(c.BASE/'fused_worker.py'),config_record['path']]))
        def read():
            try:
                for raw in iter(self.child.stdout.readline,b''):
                    c.need(len(raw)<=2_000_000 and raw.endswith(b'\n'),'Bad adapter JSONL')
                    self.responses.put(json.loads(raw))
            except BaseException as error:self.responses.put(error)
            finally:self.responses.put(EOFError('Owned Linux adapter stdout closed'))
        threading.Thread(target=read,daemon=True).start()
        first=self.responses.get()
        if isinstance(first,BaseException):raise first
        c.need(first.get('event')=='ADAPTER_BOOTED','Linux adapter failed to start: '+repr(first));self.booted=first
        self.state.update(stage='ACTUAL_NATIVE_BASE_IN_PROGRESS',adapter_booted=first,config=config_record,native=self.native)
        self.persist();c.atomic(self.run/'SERVICE_CURRENT.json',dict(session_id=self.sid,session_dir=c.rel(self.session),owner=self.owner))

    def persist(self):
        self.state.update(updated_utc=c.utc(),physical_memory=c.system_memory(),model_calls=0,notifications=False)
        c.atomic(self.session/'supervisor_status.json',self.state)

    def rpc(self,request):
        with self.op_lock:
            c.need(self.child is not None and self.child.poll() is None,'Owned service not live')
            op=request['op'];self.requests+=1;rid=str(self.requests)
            if op in ('initialize_gpu','open','span'):
                permission=c.load(self.run/'ROW_PERMISSION.json')
                c.need(permission.get('native')==self.native and permission.get('required_controls_passed') is True and
                       permission.get('session_id')==self.sid,'Fresh smoke/finalizer prerequisites required before proposal or rows')
                if self.permission is None:
                    manifest=c.load(c.checked_record(permission['manifest']));runtime=c.load(c.checked_record(permission['runtime']))
                    c.need(manifest.get('native')==self.native and manifest.get('runtime')==permission['runtime'] and runtime.get('native')==self.native,
                           'Row permission runtime/manifest authority differs')
                    c.need(all(manifest.get('code_binding',{}).get(name)==rec for name,rec in self.code_identity.items()),'Permission binds different live adapter/proposer code')
                    self.permission=permission
                else:
                    c.need(permission.get('manifest')==self.permission['manifest'] and permission.get('runtime')==self.permission['runtime'],'Permission changed within live session')
                self.state['row_permission']=True
            body=dict(request,request_id=rid);self.state.update(stage='RPC_'+op.upper(),request_id=rid);self.persist()
            self.child.stdin.write(c.canonical(body)+b'\n');self.child.stdin.flush()
            value=self.responses.get()
            if isinstance(value,BaseException):raise value
            c.need(value.get('event')=='ADAPTER_RESPONSE' and value.get('request_id')==rid,'Linux adapter rejected: '+repr(value))
            if op=='global_ready':self.ready_event=value['value'];self.state['global_ready']=self.ready_event
            if op=='stop':
                self.child.stdin.close();code=self.child.wait();c.need(code==0,'Linux adapter nonzero exit')
                cleanup=c.load(self.session/'linux_cleanup.json')
                c.need(cleanup.get('native_exited') is True and cleanup.get('GPU_context_closed') is True and not cleanup.get('errors'),'Linux cleanup unconfirmed')
                self.state.update(stage='ALL_OWNED_SERVICES_CONFIRMED_EXITED',all_owned_services_confirmed_exited=True,cleanup=cleanup)
                c.once(self.session/'confirmed_cleanup.json',dict(schema='V17_SUPERVISOR_CONFIRMED_CLEANUP_V1',session_id=self.sid,
                    all_owned_services_confirmed_exited=True,adapter_returncode=code,linux_cleanup=c.record(self.session/'linux_cleanup.json'),
                    native=self.native,scope=c.record(self.session/'linux_scope.json'),native_stop_event=value['value']['native_event'],closed_utc=c.utc()))
                self.stopped.set()
            else:self.state['stage']='IDLE_NATIVE_READY' if self.ready_event else 'ACTUAL_NATIVE_BASE_IN_PROGRESS'
            self.persist();return value['value']

    def cleanup(self):
        # This routine never releases input/code locks while an owned service
        # might still be alive. In an error, a visible guardian remains alive.
        if self.child is None:
            if self.locks:self.locks.close()
            if self.stderr is not None:self.stderr.close()
            return
        if not self.stopped.is_set():
            self.state.update(stage='PAUSED_CLEANUP_GUARDIAN',error=self.failure)
            c.atomic(self.session/'CANCEL_LAUNCH.json',dict(cancelled_utc=c.utc(),session_id=self.sid))
            while True:
                try:
                    self.persist()
                    # Closing the adapter's input requests its own finally.
                    if self.child.stdin and not self.child.stdin.closed:self.child.stdin.close()
                    recovery=subprocess.run(['wsl.exe','--exec','/usr/bin/python3','-B',wsl(c.BASE/'recover.py'),wsl(self.session/'linux_scope.json')],
                        capture_output=True,text=True,creationflags=getattr(subprocess,'CREATE_NO_WINDOW',0))
                    c.need(recovery.returncode==0,'Owned Linux recovery not confirmed: '+recovery.stdout+recovery.stderr)
                    # The exact Linux group is now empty; reap the WSL client.
                    self.child.wait()
                    c.once(self.session/('recovered_cleanup_'+uuid.uuid4().hex+'.json'),json.loads(recovery.stdout))
                    break
                except BaseException as error:
                    self.state['cleanup_error']=repr(error)
                    print('V17 cleanup guardian: '+repr(error),file=sys.stderr,flush=True)
                time.sleep(5)
        if self.locks:self.locks.close();self.locks=None
        if self.stderr is not None:self.stderr.close()

    def abort(self):
        # Out-of-band owned cleanup must not wait behind a long global check.
        c.atomic(self.session/'CANCEL_LAUNCH.json',dict(cancelled_utc=c.utc(),session_id=self.sid))
        recovery=subprocess.run(['wsl.exe','--exec','/usr/bin/python3','-B',wsl(c.BASE/'recover.py'),wsl(self.session/'linux_scope.json')],
            capture_output=True,text=True,creationflags=getattr(subprocess,'CREATE_NO_WINDOW',0))
        c.need(recovery.returncode==0,'Owned Linux abort not confirmed: '+recovery.stdout+recovery.stderr)
        result=json.loads(recovery.stdout);c.need(result.get('all_owned_services_confirmed_exited') is True,'Owned group not empty')
        code=self.child.wait()
        result.update(schema='V17_SUPERVISOR_ABORTED_CLEANUP_V1',session_id=self.sid,native=self.native,adapter_returncode=code,
                      clean_NORMAL_STOP=False,scope=c.record(self.session/'linux_scope.json'))
        c.once(self.session/'aborted_cleanup.json',result);self.stopped.set()
        self.state.update(stage='ABORTED_OWNED_SCOPE_CONFIRMED_EMPTY',all_owned_services_confirmed_exited=True)
        self.persist();return result

def main():
    a=argparse.ArgumentParser();a.add_argument('--run',required=True);a.add_argument('--native',required=True)
    a.add_argument('--native-sha256',required=True);a.add_argument('--pool-threads',type=int,default=12);v=a.parse_args()
    c.need(os.name=='nt','Supervisor runs on Windows');c.need(1<=v.pool_threads<=12,'Pool threads1..12')
    c.need(c.sha_file(v.native)['sha256']==v.native_sha256,'Expected actual build SHA required')
    run=c.owned(v.run);host=None;server=None
    with c.OwnerLock(run/'service_owner.lock'):
        try:
            # Retain the partially initialized owner across a post-Popen error.
            host=Supervisor.__new__(Supervisor);host.__init__(run,v.native,v.pool_threads)
            class Handler(socketserver.StreamRequestHandler):
                def handle(self):
                    request={}
                    try:
                        raw=self.rfile.readline(2_000_001);c.need(len(raw)<=2_000_000,'Oversized local request');request=json.loads(raw)
                        c.need(secrets.compare_digest(request.get('token',''),host.token),'Local RPC token mismatch')
                        if request['op']=='status':reply=dict(ok=True,value=host.state)
                        elif request['op']=='abort':reply=dict(ok=True,value=host.abort())
                        else:reply=dict(ok=True,value=host.rpc({k:x for k,x in request.items() if k!='token'}))
                    except BaseException as error:
                        if host is not None and request.get('op')!='status':host.failure=repr(error)
                        reply=dict(ok=False,error=repr(error),traceback=traceback.format_exc())
                    self.wfile.write(c.canonical(reply)+b'\n');self.wfile.flush()
            class Server(socketserver.ThreadingTCPServer):
                allow_reuse_address=False;daemon_threads=True
            server=Server(('127.0.0.1',0),Handler)
            c.once(host.session/'endpoint.json',dict(schema='V17_LOCAL_SERVICE_ENDPOINT_V1',host='127.0.0.1',port=server.server_address[1],
                 token=host.token,session_id=host.sid,owner=host.owner,native=host.native))
            print(c.canonical(dict(event='V17_SERVICE_BOOTED_BASE_IN_PROGRESS',session_dir=c.rel(host.session),endpoint=c.record(host.session/'endpoint.json'))).decode(),flush=True)
            server.timeout=1
            # Initial global-ready computation runs immediately; requests other
            # than status serialize behind this actual finite computation.
            def startup():
                try:host.rpc(dict(op='global_ready'))
                except BaseException as error:
                    host.failure=repr(error);host.state.update(stage='PAUSED_NATIVE_STARTUP_ERROR',error=repr(error));host.persist()
            threading.Thread(target=startup,daemon=True).start()
            while not host.stopped.is_set():
                server.handle_request()
                if host.failure:raise RuntimeError(host.failure)
        except BaseException as error:
            if host is not None:host.failure=repr(error)
            raise
        finally:
            if server is not None:server.server_close()
            if host is not None and hasattr(host,'child'):host.cleanup()

if __name__=='__main__':main()
