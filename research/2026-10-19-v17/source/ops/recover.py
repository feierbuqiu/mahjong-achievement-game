"""Exact Linux scope recovery for this new activity; no global WSL killing."""
from pathlib import Path
import json,os,signal,sys,time
import common as c

def stat(pid):
    try:
        p=Path('/proc')/str(pid);text=(p/'stat').read_text();fields=text[text.rfind(')')+2:].split()
        return dict(pid=pid,start_ticks=int(fields[19]),process_group=int(fields[2]),state=fields[0])
    except FileNotFoundError:return None

def recover(scope_path):
    p=c.owned(scope_path);session=p.parent
    if not p.exists():
        # Revoke a queued helper launch BEFORE treating a missing Native intent
        # as empty. Kill only exact helper/config command lines, never a guessed
        # WSL tree. The helper checks this revocation after fsyncing its scope.
        c.need((session/'CANCEL_LAUNCH.json').exists(),'Revoke owned launch before recovering an absent scope')
        target=str((session/'config.json').resolve());script=str((c.BASE/'fused_worker.py').resolve())
        found=[]
        for leaf in Path('/proc').iterdir():
            if not leaf.name.isdigit():continue
            try:args=(leaf/'cmdline').read_bytes().split(b'\0');args=[v.decode() for v in args if v]
            except (FileNotFoundError,PermissionError,UnicodeDecodeError):continue
            if len(args)==4 and args[1]=='-B' and args[2]==script and args[3]==target:
                v=stat(int(leaf.name))
                if v is not None and v['state']!='Z':found.append(v);os.kill(v['pid'],signal.SIGTERM)
        for v in found:
            deadline=time.monotonic()+30
            while True:
                current=stat(v['pid'])
                if current is None or current['start_ticks']!=v['start_ticks'] or current['state']=='Z':break
                if time.monotonic()>=deadline:os.kill(v['pid'],signal.SIGKILL)
                time.sleep(.2)
        if p.exists():return recover(p)
        return dict(scope_absent=True,session_id=session.name,all_owned_services_confirmed_exited=True,reason='REVOKED_NO_NATIVE_CREATE_INTENT',
                    exact_helpers_waited=len(found))
    value=c.load(p);c.need(value['schema']=='V17_OWNED_LINUX_PROCESS_SCOPE_V1','Unknown process scope')
    if value['boot_id']!=Path('/proc/sys/kernel/random/boot_id').read_text().strip():
        return dict(schema='V17_EXACT_SCOPE_RECOVERY_V1',session_id=value['session_id'],native=value['native'],scope=c.record(p),
                    all_owned_services_confirmed_exited=True,reason='PRIOR_LINUX_BOOT')
    helper=value['helper'];pgid=helper['process_group'];c.need(helper['pid']==pgid and pgid>1,'Exact private session leader required')
    expected={helper['pid']:helper['start_ticks']};started=session/'native_started.json'
    if started.exists():
        native=c.load(started);c.need(native['native']==value['native'],'Recovery executable identity differs')
        expected[native['process']['pid']]=native['process']['start_ticks']
    def members():
        found=[]
        for leaf in Path('/proc').iterdir():
            if leaf.name.isdigit():
                v=stat(int(leaf.name))
                if v is not None and v['process_group']==pgid and v['state']!='Z':found.append(v)
        return found
    current=members()
    for item in current:
        if item['pid'] not in expected:
            # Popen can succeed just before a crash prevents its PID ACK. The
            # prior scope intent plus exact native argv in this private group
            # identify that narrow race without inventing a start timestamp.
            args=[v.decode() for v in (Path('/proc')/str(item['pid'])/'cmdline').read_bytes().split(b'\0') if v]
            config=c.load(session/'config.json')
            c.need(args==[str(c.path(value['native']['path'])),'serve',str(c.path(config['native_config']))],
                   'Unknown process in owned session group')
            expected[item['pid']]=item['start_ticks']
        c.need(item['pid'] in expected and item['start_ticks']==expected[item['pid']],
               'Unrecognized or reused PID in owned process group; keep input guardian alive')
    # An intent-only creation race can leave an unrecorded native child. Refuse
    # rather than guess its identity; the supervisor keeps all source locks.
    if current:
        os.killpg(pgid,signal.SIGTERM)
        deadline=time.monotonic()+30
        while members() and time.monotonic()<deadline:time.sleep(.2)
        if members():os.killpg(pgid,signal.SIGKILL)
    deadline=time.monotonic()+60
    while members() and time.monotonic()<deadline:time.sleep(.2)
    c.need(not members(),'Owned Linux process group has not become empty')
    return dict(schema='V17_EXACT_SCOPE_RECOVERY_V1',session_id=value['session_id'],native=value['native'],scope=c.record(p),
                all_owned_services_confirmed_exited=True,process_group=pgid,checked_utc=c.utc())

if __name__=='__main__':
    try:
        result=recover(sys.argv[1]);print(c.canonical(result).decode())
    except BaseException as error:print(c.canonical(dict(error=repr(error),all_owned_services_confirmed_exited=False)).decode());raise SystemExit(1)
