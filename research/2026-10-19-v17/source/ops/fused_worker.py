"""Linux IO adapter. Every accepting row is delegated to the new V17 ELF.

Large untrusted 1B packets stay in Linux. No checkBase/prepare/scan/assembly
logic is copied here. Windows retains actual input read custody.
"""
from pathlib import Path
import ctypes,hashlib,importlib.util,json,os,queue,signal,subprocess,sys,threading,time,traceback
import common as c

GPU_PATH='build/lean_table_checker/gpu_indexed_byte_v16/worker.py'
GPU_SHA='adce9593d5dbbb7937abf6f392d751ad551e189af7daa6b8c6f5bea87584404f'
RULES_PATH='build/lean_table_checker/v17_compute_finish_20261018/ops/rules_v17.py'
RULES_SHA='5fabb26d6459952ea65ae918663ae0670ed6d231ee3fcf65e70b6d0ffb9d63ba'

def emit(v):print(c.canonical(v).decode(),flush=True)
def proc(pid):
    p=Path('/proc')/str(pid);stat=(p/'stat').read_text();tail=stat[stat.rfind(')')+2:].split()
    status={x.split(':')[0]:x.split(':',1)[1].strip() for x in (p/'status').read_text().splitlines() if ':' in x}
    return dict(pid=pid,start_ticks=int(tail[19]),process_group=int(tail[2]),
                RSS_bytes=int(status.get('VmRSS','0 kB').split()[0])*1024,
                user_ticks=int(tail[11]),system_ticks=int(tail[12]))

def import_exact(name,path,sha):
    path=c.path(path);raw=path.read_bytes();c.need(hashlib.sha256(raw).hexdigest()==sha,'Bound application source changed: '+str(path))
    spec=importlib.util.spec_from_file_location(name,path);module=importlib.util.module_from_spec(spec);sys.modules[name]=module
    exec(compile(raw,str(path),'exec'),module.__dict__);return module

def create_gpu_context(run,session,input_config,manifest,manifest_sha256,rules):
    """Shared actual GPU setup for production and its GPU-only connection test.

    This performs no Native/base check and accepts no game row. All untrusted
    ready fields still pass the pinned complete receipt validator.
    """
    run=c.owned(run);session=c.owned(session)
    c.need(session.is_relative_to(run),'GPU output session must belong to this new activity')
    manifest=c.path(manifest);c.need(c.sha_file(manifest)['sha256']==manifest_sha256,'GPU locked digest manifest mismatch')
    producer=import_exact('_v17_private_indexed_proposer',GPU_PATH,GPU_SHA)
    producer.RUN=run;producer.CAMPAIGNS=run
    producer.old.RUN=run;producer.old.CAMPAIGNS=run
    producer.old.HOST_CAP=rules.HOST_RSS_CAP_BYTES
    args=producer.configuration(index=c.path(input_config['index_root']),catalog=c.path(input_config['catalog_file']),
        data=c.path(input_config['data_root']),edges=c.path(input_config['successor_root']),fixed_manifest=manifest,
        fixed_manifest_sha256=manifest_sha256,pid_file=session/'gpu_owner.json',
        max_count=67108864,host_rss_cap_bytes=rules.HOST_RSS_CAP_BYTES)
    gpu=None
    try:
        gpu=producer.SessionContext(args);value=gpu.ready();rules.ready(value,67108864)
        c.once(session/'gpu_ready.json',value);return gpu,value
    except BaseException:
        if gpu is not None:
            cleanup=gpu.close(reason='V17_GPU_SETUP_REJECTED',failed=True)
            c.need(cleanup.get('GPU_context_closed') is True,'Rejected GPU setup cleanup did not confirm context exit')
        raise

class Host:
    def __init__(self,config_path):
        self.config=c.load(config_path);self.session=c.owned(self.config['session_dir']);self.session.mkdir(parents=True,exist_ok=True)
        self.run=c.owned(self.config['run']);self.native=None;self.gpu=None;self.active=None;self.global_ready=None
        self.lines=queue.Queue();self.done=threading.Event();self.thread=None;self.sequence=0
        self.rules=import_exact('_v17_untrusted_gpu_rules',RULES_PATH,RULES_SHA)
        self.native_identity=self.config['native'];c.need(c.record(self.native_identity['path'])==self.native_identity,'Frozen native identity mismatch')
        # Durable intent precedes the native child. The process is a new session
        # leader; its children inherit this exact process group for recovery.
        try:os.setsid()
        except PermissionError:c.need(os.getpgrp()==os.getpid(),'Dedicated Linux session required')
        self.scope=dict(schema='V17_OWNED_LINUX_PROCESS_SCOPE_V1',session_id=self.config['session_id'],
            helper=proc(os.getpid()),boot_id=Path('/proc/sys/kernel/random/boot_id').read_text().strip(),
            native=self.native_identity,owner=self.config['owner'],config=c.record(config_path),run=c.rel(self.run))
        c.once(self.session/'linux_scope.json',self.scope)
        c.need(not (self.session/'CANCEL_LAUNCH.json').exists(),'Owned service launch was cancelled before Native creation')
        self.stderr=(self.session/'native.stderr.jsonl').open('xb',buffering=0)
        env=dict(os.environ,LEAN_NUM_THREADS=str(self.config['pool_threads']))
        self.native=subprocess.Popen([str(c.path(self.native_identity['path'])),'serve',str(c.path(self.config['native_config']))],
            stdin=subprocess.PIPE,stdout=subprocess.PIPE,stderr=self.stderr,cwd=c.ROOT,env=env,bufsize=0)
        c.once(self.session/'native_started.json',dict(schema='V17_NATIVE_PROCESS_STARTED_V1',
            session_id=self.config['session_id'],process=proc(self.native.pid),native=self.native_identity,
            argv=[self.native_identity['path'],'serve',self.config['native_config']],pool_threads=self.config['pool_threads']))
        def pump():
            try:
                while True:
                    raw=self.native.stdout.readline(2_000_001)
                    if not raw:break
                    c.need(len(raw)<=2_000_000 and raw.endswith(b'\n'),'Oversized or truncated Native JSONL')
                    self.lines.put(json.loads(raw))
            except BaseException as error:self.lines.put(error)
            finally:self.lines.put(EOFError('Native stdout reached EOF'))
        self.reader=threading.Thread(target=pump,daemon=True);self.reader.start()
        def monitor():
            while not self.done.wait(5):
                try:
                    value=dict(schema='V17_LINUX_SERVICE_LIVENESS_V1',session_id=self.config['session_id'],updated_utc=c.utc(),
                        physical_memory=c.system_memory(),helper=proc(os.getpid()),native=proc(self.native.pid) if self.native.poll() is None else None,
                        native_returncode=self.native.poll(),active_bucket=self.active)
                    c.atomic(self.session/'liveness.json',value)
                except BaseException as error:
                    print('MONITOR_DIAGNOSTIC '+repr(error),file=sys.stderr,flush=True)
        self.thread=threading.Thread(target=monitor,daemon=True);self.thread.start()

    def take(self,event):
        # Deliberately no wall timeout: actual startup finite checks can be long.
        item=self.lines.get()
        if isinstance(item,BaseException):raise item
        c.need(item.get('event')==event,'Native protocol event differs: '+repr(item));return item

    def send(self,value):
        c.need(self.native.poll() is None,'Native child exited')
        self.native.stdin.write(c.canonical(value)+b'\n');self.native.stdin.flush()

    def ready(self):
        if self.global_ready is None:
            base=self.take('BASE_CHECKED')
            c.need(base.get('baseChecked') is True and base.get('successorsChecked') is True,'Native base family receipt did not accept')
            c.once(self.session/'native_base_checked.json',base)
            self.global_ready=self.take('GLOBAL_READY')
            c.need(self.global_ready.get('baseChecked') is True and self.global_ready.get('successorsChecked') is True,'Native global finite checks did not accept')
            c.once(self.session/'native_global_ready.json',self.global_ready)
        return self.global_ready

    def initialize_gpu(self,request):
        self.ready();c.need(self.gpu is None,'GPU already initialized')
        self.gpu,value=create_gpu_context(self.run,self.session,self.config['input_config'],
            request['manifest'],request['manifest_sha256'],self.rules)
        return value

    def open(self,request):
        self.ready();c.need(self.active is None and self.gpu is not None,'Open requires closed bucket and initialized proposer')
        n=c.uint(request['layer']);h=c.uint(request['honor']);self.send(dict(open=True,layer=n,honor=h))
        native=self.take('BUCKET_READY')
        c.need(native.get('metadataChecked') is True and native.get('targetIdentity') is True,'Native bucket finite checks rejected')
        gpu=self.gpu.enter_bucket(n,h,c.path(request['manifest']),request['manifest_sha256'])
        self.active=dict(layer=n,honor=h,bucket_open_id=request['bucket_open_id'])
        return dict(native_event=native,gpu_event=gpu)

    def span(self,request):
        c.need(self.active is not None,'Span requires open bucket')
        start=c.uint(request['start']);count=c.uint(request['count']);output=c.owned(request['output'])
        c.need(output.is_relative_to(self.session) and not output.exists(),'New own-session native result required')
        output.parent.mkdir(parents=True,exist_ok=True)
        began=time.monotonic();buffer,proposal=self.gpu.propose(start,count)
        self.rules.proposal(proposal,start,count,67108864)
        command=dict(transport=c.WIRE,start=start,count=count,compact_bytes=count,output=str(output))
        self.send(command);view=memoryview(buffer).cast('B');written=0
        try:
            while written<count:
                take=min(4194304,count-written);part=view[written:written+take]
                while part:
                    n=self.native.stdin.write(part);c.need(n is not None and n>0,'Short Native packet pipe write');part=part[n:];written+=n
            self.native.stdin.write(c.END);self.native.stdin.flush()
        finally:view.release();del buffer
        native=self.take('FRAME_RESULT')
        c.need(native.get('frameAccepted') is True and (native.get('start'),native.get('count'))==(start,count),'Native frame did not accept exact packet')
        with output.open('rb') as f:os.fsync(f.fileno())
        c.need(c.load(output)==native,'Saved Native result differs from stdout')
        proposal_record=c.once(output.with_name(output.name+'.proposal.json'),proposal)
        return dict(native_event=native,native_result=c.record(output),proposal=proposal_record,
            complete_helper_wall_seconds=time.monotonic()-began,linux_native=proc(self.native.pid),physical_memory=c.system_memory())

    def close_bucket(self):
        c.need(self.active is not None,'No active bucket')
        self.send(dict(close=True));native=self.take('BUCKET_CLOSED');gpu=self.gpu.leave_bucket();self.active=None
        return dict(native_event=native,gpu_event=gpu)

    def stop(self):
        c.need(self.active is None,'Close active bucket before stop')
        self.send(dict(stop=True));self.native.stdin.close();native=self.take('GLOBAL_STOPPED')
        code=self.native.wait();c.need(code==0,'Native nonzero exit')
        gpu=self.gpu.close(reason='V17_NEW_ACTIVITY_SERVICE_STOP') if self.gpu is not None else None
        self.gpu=None
        return dict(native_event=native,native_returncode=code,GPU_context_closed=(gpu is None or gpu.get('GPU_context_closed') is True),
                    gpu_cleanup=gpu,all_native_children_waited=True)

    def cleanup(self):
        self.done.set();errors=[]
        if self.native is not None and self.native.poll() is None:
            self.native.terminate()
            try:self.native.wait(timeout=30)
            except subprocess.TimeoutExpired:
                self.native.kill()
                # Holding process custody is safer than abandoning a live tree.
                self.native.wait()
        if self.gpu is not None:
            try:self.gpu.close(reason='V17_ADAPTER_FINALLY',failed=True);self.gpu=None
            except BaseException as error:errors.append(repr(error))
        if self.thread is not None:self.thread.join(timeout=6)
        if getattr(self,'stderr',None) is not None:self.stderr.close()
        value=dict(schema='V17_LINUX_SERVICE_CLEANUP_V1',session_id=self.config['session_id'],
            native_returncode=None if self.native is None else self.native.poll(),native_exited=self.native is None or self.native.poll() is not None,
            GPU_context_closed=self.gpu is None,errors=errors,closed_utc=c.utc())
        c.atomic(self.session/'linux_cleanup.json',value)
        c.need(value['native_exited'] and value['GPU_context_closed'] and not errors,'Linux service cleanup unconfirmed')

def main():
    c.need(sys.platform=='linux','This adapter is Linux only');host=None
    def stop_signal(signum,frame):raise InterruptedError('Owned adapter signal '+str(signum))
    signal.signal(signal.SIGTERM,stop_signal);signal.signal(signal.SIGINT,stop_signal)
    try:
        # Assign before __init__ so a post-Popen constructor failure still has
        # an exact object available to the mandatory cleanup finally.
        host=Host.__new__(Host);host.__init__(sys.argv[1])
        emit(dict(event='ADAPTER_BOOTED',scope=c.record(host.session/'linux_scope.json'),native_started=c.record(host.session/'native_started.json')))
        for raw in sys.stdin.buffer:
            c.need(len(raw)<=2_000_000,'Oversized control JSON');request=json.loads(raw);op=request['op']
            if op=='global_ready':value=host.ready()
            elif op=='initialize_gpu':value=host.initialize_gpu(request)
            elif op=='open':value=host.open(request)
            elif op=='span':value=host.span(request)
            elif op=='close':value=host.close_bucket()
            elif op=='stop':value=host.stop()
            else:raise ValueError('Unknown adapter operation')
            emit(dict(event='ADAPTER_RESPONSE',request_id=request['request_id'],value=value))
            if op=='stop':break
        else:raise EOFError('Adapter control closed before stop')
        return 0
    except BaseException as error:
        emit(dict(event='ADAPTER_ERROR',error=repr(error),traceback=traceback.format_exc()));return 1
    finally:
        signal.signal(signal.SIGTERM,signal.SIG_IGN);signal.signal(signal.SIGINT,signal.SIG_IGN)
        if host is not None and hasattr(host,'native') and hasattr(host,'done'):host.cleanup()

if __name__=='__main__':raise SystemExit(main())
