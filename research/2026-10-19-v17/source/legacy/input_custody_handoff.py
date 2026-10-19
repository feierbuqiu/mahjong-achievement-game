"""Windows continuous-custody handoff of actual input digests to activity 02.

Only identical paths protected by the live original hasher are reused.  The
new catalog is actually read/hashed under the new complete lock set.  This
records IO identities, never prior game acceptance or a Lean proof.  No old
activity file is written and no Native/GPU process is started.
"""
from pathlib import Path
import argparse, contextlib, datetime, hashlib, importlib, json, os, sys, time, traceback, uuid

BASE = Path(__file__).resolve().parent
ROOT = BASE.parents[2]
OPS = BASE / 'ops'
RUNS = ROOT / 'runs/lean_table_checker/v17_compute_finish_20261018'
OLD = RUNS / 'full_native_20261018_01'
NEW = RUNS / 'full_native_20261018_02'
TOKEN = 'e25c8e79b5c54e37adf9e3b83d5f2c20'
PRIOR_POINTER = dict(path='runs/lean_table_checker/v17_compute_finish_20261018/full_native_20261018_01/INPUTS_BEFORE.json',
    bytes=362, sha256='4a6e3e49c45ce9e8ab307ba4c636c6042f50571404f476d7596688a952e82579')
PRIOR_IDENTITY = dict(path='runs/lean_table_checker/v17_compute_finish_20261018/full_native_20261018_01/input_custody/e25c8e79b5c54e37adf9e3b83d5f2c20/identities.json',
    bytes=1673142, sha256='d64758671f9d0bdd898b079079cccd7ae6dd31d4c4f8252d8d01e31bddc64876')
PRIOR_ACQUIRED = dict(path='runs/lean_table_checker/v17_compute_finish_20261018/full_native_20261018_01/input_custody/e25c8e79b5c54e37adf9e3b83d5f2c20/locks_acquired.json',
    bytes=243, sha256='5eea63976b51253c880ace42cfefdbf66cbe962bdba90e184027b77b58501926')
PRIOR_PLAN = dict(path='runs/lean_table_checker/v17_compute_finish_20261018/full_native_20261018_01/PLAN.json',
    bytes=3306441, sha256='bfc08f67a03cb85ed3aad9cddd6aac4066479297e7192d40d940e5a45da1af25')
NEW_PLAN = dict(path='runs/lean_table_checker/v17_compute_finish_20261018/full_native_20261018_02/PLAN.json',
    bytes=3306441, sha256='bc9b6f02c66b4556b1e9a189d9950d95b994f5bb82170736aa09b1abe0e71baa')
NEW_CONFIG = dict(path='runs/lean_table_checker/v17_compute_finish_20261018/full_native_20261018_02/native_config.json',
    bytes=1623, sha256='6c04f513a522ca8aa00e2a947a48d206e4744b11bf5d0fb2326c997f268531cc')
SOURCE_PINS = {
    'build/lean_table_checker/read_lock_footprint_v13/shared_read_locks.py': dict(bytes=1676, sha256='66fc89d40ef604d0ae7c57ffcd4995b36cc24686b771f81b10d7051e4241f78d'),
    'build/lean_table_checker/v17_compute_finish_20261018/ops/common.py': dict(bytes=7796, sha256='89a10b8631cca8071bbb75f5159f57c678b1d07c0302d8f4c7413012e6022c02'),
    'build/lean_table_checker/v17_compute_finish_20261018/ops/hash_inputs.py': dict(bytes=5621, sha256='c29309a7fd298fd1d4ea064024e09706f7c81e23154d92317e38bacdc3df7e8d')}
PRIOR_OWNER = dict(pid=30124, creation_time=1792314549.3262937)


def need(value, message):
    if not value:
        raise ValueError(message)


def path(value):
    p = Path(value)
    p = (p if p.is_absolute() else ROOT / p).resolve()
    need(p.is_relative_to(ROOT) and p != ROOT, 'Path outside workspace')
    return p


def load(value):
    return json.loads(path(value).read_text(encoding='utf-8-sig'))


def record(value):
    p = path(value)
    digest = hashlib.sha256()
    count = 0
    with p.open('rb') as stream:
        while chunk := stream.read(1048576):
            count += len(chunk)
            digest.update(chunk)
    return dict(path=p.relative_to(ROOT).as_posix(), bytes=count, sha256=digest.hexdigest())


def checked(rec):
    need(record(rec['path']) == rec, 'Actual immutable metadata/source identity differs: ' + rec['path'])
    return path(rec['path'])


@contextlib.contextmanager
def readlocks(files, failure_guard=None):
    need(os.name == 'nt', 'Actual Windows deny-write/delete custody required')
    name = 'build/lean_table_checker/read_lock_footprint_v13/shared_read_locks.py'
    raw = path(name).read_bytes()
    need(dict(bytes=len(raw), sha256=hashlib.sha256(raw).hexdigest()) == SOURCE_PINS[name], 'ReadLocks implementation changed')
    ns = dict(__name__='_v17_input_handoff_locks', __file__=str(path(name)))
    exec(compile(raw, str(path(name)), 'exec'), ns)
    handle = ns['ReadLocks']([path(p) for p in sorted(set(map(str, files)))])
    try:
        yield
    except BaseException as error:
        if failure_guard is not None:
            failure_guard(error)
        raise
    finally:
        handle.close()


def check_prior_pointer(pointer, prior):
    need(pointer.get('identity_record') == PRIOR_IDENTITY and pointer.get('token') == TOKEN and
        pointer.get('owner') == PRIOR_OWNER and prior.get('owner') == PRIOR_OWNER and prior.get('token') == TOKEN,
        'Different original actual hasher identity')


def check_release(request, token, identities):
    need(request.get('token') == token and request.get('identity_record') == identities and
        request.get('all_owned_services_confirmed_exited') is True, 'Wrong new-guardian exact release request')


def live_prior(pointer, prior):
    import psutil
    check_prior_pointer(pointer, prior)
    folder = path(PRIOR_IDENTITY['path']).parent
    need(not any((folder / name).exists() for name in ('RELEASE.json', 'release_ack.json', 'closed.json', 'failure.json')),
        'Original hasher released/failed before continuous overlap')
    try:
        need(psutil.Process(PRIOR_OWNER['pid']).create_time() == PRIOR_OWNER['creation_time'], 'Original custodian PID was reused')
    except (psutil.NoSuchProcess, psutil.AccessDenied) as error:
        raise ValueError('Original custodian not actually visible/live; use Root elevated Windows host: ' + repr(error)) from error
    heartbeat = load(folder / 'progress.json')
    need(heartbeat.get('schema') == 'V17_INPUT_HASH_PROGRESS_V1' and heartbeat.get('stage') == 'HASH_COMPLETE_CUSTODY_HELD' and
        heartbeat.get('token') == TOKEN and heartbeat.get('owner') == PRIOR_OWNER and
        heartbeat.get('files_completed') == prior['input_count'] and heartbeat.get('bytes_completed') == prior['input_bytes'],
        'Original hasher heartbeat is not the completed continuous-custody state')
    now = datetime.datetime.now(datetime.timezone.utc)
    stamp = datetime.datetime.fromisoformat(heartbeat['updated_utc'])
    need(stamp.tzinfo is not None and -5 <= (now-stamp).total_seconds() <= 60, 'Original custodian heartbeat is stale')
    return heartbeat


def validate_maps(old_plan, new_plan, prior):
    """Pure exact-domain check. Reuse never renames or synthesizes a digest."""
    need(prior.get('schema') == 'V17_ACTUAL_READLOCKED_INPUT_IDENTITIES_V1' and prior.get('plan') == PRIOR_PLAN and
        prior.get('continuous_Windows_deny_write_delete_custody') is True and
        prior.get('no_old_acceptance_imported') is True and prior.get('source_files') == SOURCE_PINS,
        'Original result is not the pinned actual read-locked hash computation')
    for p in (old_plan, new_plan):
        need(p.get('schema') == 'V17_ALL_LAYER_NATIVE_ACTIVITY_PLAN_V1' and p.get('old_PASS_or_seed_imported') is False and
            p.get('new_verified_rows') == 0 and p.get('total_cells') == 6440 and p.get('total_rows') == 778532864302,
            'Only these fresh all35 plans may use this handoff')
    for key in ('cells', 'common_identity_fields', 'frame_policy', 'nonempty_buckets', 'empty_cells', 'total_cells', 'total_rows'):
        need(old_plan[key] == new_plan[key], 'New mathematical input inventory/schedule differs: ' + key)
    need({k:v for k,v in old_plan['config'].items() if k != 'catalog_file'} ==
        {k:v for k,v in new_plan['config'].items() if k != 'catalog_file'}, 'Input roots changed')
    old_files, new_files, actual = old_plan['input_inventory'], new_plan['input_inventory'], prior['files']
    need(set(old_files) == set(actual) and prior['input_count'] == len(actual), 'Original hash domain is incomplete')
    need(prior['input_bytes'] == sum(v['bytes'] for v in actual.values()), 'Original byte-count total differs')
    canonical = json.dumps(actual, sort_keys=True, separators=(',', ':'), ensure_ascii=False, allow_nan=False).encode()
    need(prior['files_sha256'] == hashlib.sha256(canonical).hexdigest(), 'Original actual map digest differs')
    old_catalog, new_catalog = old_plan['catalog']['path'], new_plan['catalog']['path']
    need(new_catalog != old_catalog and path(new_catalog).parent == NEW and path(old_catalog).parent == OLD,
        'Only the new own catalog path may replace the old catalog path')
    need(set(old_files)-set(new_files) == {old_catalog} and set(new_files)-set(old_files) == {new_catalog},
        'Unexpected new or omitted input path; use a full new hash instead')
    shared = sorted(set(old_files) & set(new_files))
    for name in shared:
        rec = actual[name]
        need(type(rec.get('bytes')) is int and rec['bytes'] >= 0 and isinstance(rec.get('sha256'), str) and
            len(rec['sha256']) == 64 and all(c in '0123456789abcdef' for c in rec['sha256']), 'Invalid original actual digest')
        need(old_files[name]['bytes'] == new_files[name]['bytes'] == rec['bytes'], 'Shared input extent changed')
    need(old_files[old_catalog]['bytes'] == actual[old_catalog]['bytes'] == new_files[new_catalog]['bytes'], 'Catalog extent differs')
    need(len(old_files) == len(new_files) == 11272, 'Actual all35 input count differs')
    return shared, new_catalog, old_catalog


def run(a):
    need(a.hold and path(a.run) == NEW, 'Only new activity02 with persistent --hold is allowed')
    need(record(__file__)['sha256'] == a.self_sha256, 'Externally pinned handoff source differs')
    metadata = [__file__, *SOURCE_PINS, *[rec['path'] for rec in (PRIOR_POINTER, PRIOR_IDENTITY, PRIOR_ACQUIRED, PRIOR_PLAN, NEW_PLAN, NEW_CONFIG)]]
    with readlocks(metadata):
        need(record(__file__)['sha256'] == a.self_sha256, 'Handoff source changed before its read lock was acquired')
        for name, identity in SOURCE_PINS.items():
            need(record(name) == dict(path=name, **identity), 'Pinned original hasher/ReadLocks source changed')
        for rec in (PRIOR_POINTER, PRIOR_IDENTITY, PRIOR_ACQUIRED, PRIOR_PLAN, NEW_PLAN, NEW_CONFIG):
            checked(rec)
        need('common' not in sys.modules, 'Unreviewed common module already imported')
        sys.path.insert(0, str(OPS))
        c = importlib.import_module('common')
        with c.OwnerLock(NEW / 'input_hash_owner.lock'):
            need(not (NEW / 'INPUTS_BEFORE.json').exists(), 'Do not replace an existing new-activity identity pointer')
            token = uuid.uuid4().hex
            attempt = NEW / 'input_custody' / token
            attempt.mkdir(parents=True)
            own = dict(pid=os.getpid(), creation_time=__import__('psutil').Process().create_time())
            started = time.monotonic()
            source = record(__file__)
            intent = dict(schema='V17_CONTINUOUS_ACTUAL_HASH_HANDOFF_INTENT_V1', token=token, owner=own,
                plan=NEW_PLAN, prior_pointer=PRIOR_POINTER, prior_identity=PRIOR_IDENTITY, prior_acquired=PRIOR_ACQUIRED,
                prior_plan=PRIOR_PLAN, source_record=source, created_utc=c.utc(), hold=True,
                game_rows_accepted=0, Native_processes_started=0, GPU_processes_started=0)
            c.once(attempt / 'intent.json', intent)
            c.atomic(NEW / 'INPUT_CUSTODY_CURRENT.json', dict(intent=record(attempt / 'intent.json'), token=token))
            state = dict(published=False, released=False, identities=None)
            def release_request(request):
                check_release(request, token, state['identities'])
            def keep_published_custody(error):
                # A disk/report failure after publishing a live identity cannot
                # silently drop the handles while a controller might adopt it.
                # Keep the complete set until the exact cleanup release arrives.
                if not state['published'] or state['released']:
                    return
                while True:
                    try:
                        c.atomic(attempt / 'guardian_failure.json', dict(schema='V17_INPUT_CUSTODY_PAUSED_GUARDIAN_V1',
                            token=token,owner=own,identity_record=state['identities'],error=repr(error),
                            all_input_readlocks_still_held=True,updated_utc=c.utc()))
                        release = attempt / 'RELEASE.json'
                        if release.exists():
                            release_request(load(release))
                            c.once(attempt / 'release_ack.json', dict(schema='V17_INPUT_CUSTODY_RELEASE_ACK_V1',
                                token=token,request=record(release),confirmed_utc=c.utc()))
                            c.once(attempt / 'closed.json', dict(schema='V17_INPUT_CUSTODY_CLOSED_V1',
                                token=token,owner=own,normal=False,closed_utc=c.utc(),
                                Native_processes_started=0,GPU_processes_started=0))
                            state['released'] = True
                            return
                    except BaseException as diagnostic:
                        print('Input handoff guardian keeps all locks: '+repr(diagnostic),file=sys.stderr,flush=True)
                    time.sleep(5)
            try:
                pointer, prior, old_plan, plan = load(PRIOR_POINTER['path']), load(PRIOR_IDENTITY['path']), load(PRIOR_PLAN['path']), load(NEW_PLAN['path'])
                shared, fresh, old_catalog = validate_maps(old_plan, plan, prior)
                acquired = load(PRIOR_ACQUIRED['path'])
                need(acquired.get('schema') == 'V17_INPUT_LOCKS_ACQUIRED_V1' and acquired.get('owner') == PRIOR_OWNER and
                    acquired.get('token') == TOKEN and acquired.get('continuous_until_release') is True and
                    acquired.get('input_count') == len(prior['files']), 'Original lock-acquisition receipt differs')
                before = live_prior(pointer, prior)
                with readlocks(list(plan['input_inventory']), failure_guard=keep_published_custody):
                    # The old custodian stays live while every same-path new
                    # handle is acquired, making this an actual continuous
                    # handoff rather than offline reuse of expected hashes.
                    after = live_prior(pointer, prior)
                    c.need(not (NEW / 'STOP').exists(), 'Own new activity STOP requested')
                    acquired_new = c.once(attempt / 'locks_acquired.json', dict(schema='V17_INPUT_LOCKS_ACQUIRED_V1',
                        token=token, owner=own, acquired_utc=c.utc(), input_count=len(plan['input_inventory']),
                        continuous_until_release=True, handoff_prior_identity=PRIOR_IDENTITY, source_record=source))
                    fresh_identity = c.sha_file(fresh)
                    need(fresh_identity['bytes'] == plan['input_inventory'][fresh]['bytes'] and
                        fresh_identity == prior['files'][old_catalog], 'Actually hashed new catalog differs from original contents')
                    files = {name: dict(prior['files'][name]) for name in shared}
                    files[fresh] = fresh_identity
                    need(set(files) == set(plan['input_inventory']), 'Derived identity map omits or adds an input')
                    live_prior(pointer, prior)
                    result = dict(schema='V17_ACTUAL_READLOCKED_INPUT_IDENTITIES_V1', token=token, owner=own, plan=NEW_PLAN,
                        input_count=len(files), input_bytes=sum(v['bytes'] for v in files.values()), files=files, files_sha256=c.digest(files),
                        wall_seconds=time.monotonic()-started, continuous_Windows_deny_write_delete_custody=True,
                        no_old_acceptance_imported=True, Native_processes_started=0, GPU_processes_started=0,
                        source_files={name: dict(value) for name, value in SOURCE_PINS.items() if not name.endswith('/hash_inputs.py')},
                        prior_hash_source_files=SOURCE_PINS, handoff_source_record=source,
                        derived_from_actual_continuously_locked_hash=True, prior_actual_identity=PRIOR_IDENTITY,
                        prior_pointer=PRIOR_POINTER, prior_acquired=PRIOR_ACQUIRED, prior_plan=PRIOR_PLAN,
                        prior_owner_verified_live=PRIOR_OWNER, prior_heartbeat_before_acquisition=before,
                        prior_heartbeat_after_acquisition=after, new_locks_acquired=acquired_new,
                        hash_reused_count=len(shared), hash_reused_bytes=sum(files[x]['bytes'] for x in shared),
                        actual_new_files_hashed={fresh:fresh_identity}, actual_bytes_hashed_this_invocation=fresh_identity['bytes'],
                        all_input_bytes_rehashed_in_this_invocation=False, old_activity_files_written=False)
                    rec = c.once(attempt / 'identities.json', result)
                    # This pointer is new, atomically published, and belongs to
                    # this OwnerLock. No old activity pointer is rewritten.
                    need(not (NEW / 'INPUTS_BEFORE.json').exists(), 'A new identity pointer appeared unexpectedly')
                    state['identities'] = rec
                    state['published'] = True
                    c.atomic(NEW / 'INPUTS_BEFORE.json', dict(identity_record=rec, token=token, owner=own))
                    c.once(attempt / 'handoff_confirmed.json', dict(schema='V17_ACTUAL_CONTINUOUS_INPUT_CUSTODY_HANDOFF_CONFIRMED_V1',
                        prior_actual_identity=PRIOR_IDENTITY, identities=rec, owner=own, new_locks_acquired=acquired_new,
                        original_guardian_was_live_through_new_lock_acquisition=True, all_new_input_locks_currently_held=True,
                        actual_new_bytes_hashed=fresh_identity['bytes'], reused_actual_hash_count=len(shared),
                        original_guardian_release_requested_by_this_helper=False, confirmed_utc=c.utc()))
                    print(c.canonical(dict(event='INPUT_HASH_HANDOFF_COMPLETE', identities=rec, token=token,
                        hold=True, hash_reused_count=len(shared), actual_new_bytes_hashed=fresh_identity['bytes'])).decode(), flush=True)
                    release = attempt / 'RELEASE.json'
                    last = 0.0
                    while not release.exists():
                        now = time.monotonic()
                        if now-last >= 15:
                            progress = dict(schema='V17_INPUT_HASH_PROGRESS_V1', stage='HASH_COMPLETE_CUSTODY_HELD',
                                token=token, owner=own, updated_utc=c.utc(), files_completed=len(files), files_total=len(files),
                                bytes_completed=result['input_bytes'], bytes_total=result['input_bytes'],
                                elapsed_seconds=now-started, physical_memory=c.system_memory(), model_calls=0, notifications=False,
                                derived_from_actual_continuously_locked_hash=True, hash_reused_count=len(shared),
                                actual_bytes_hashed_this_invocation=fresh_identity['bytes'])
                            c.atomic(attempt / 'progress.json', progress)
                            c.atomic(NEW / 'input_hash_progress.json', progress)
                            last = now
                        time.sleep(1)
                    request = load(release)
                    release_request(request)
                    c.once(attempt / 'release_ack.json', dict(schema='V17_INPUT_CUSTODY_RELEASE_ACK_V1', token=token,
                        request=record(release), confirmed_utc=c.utc()))
                    c.once(attempt / 'closed.json', dict(schema='V17_INPUT_CUSTODY_CLOSED_V1', token=token, owner=own,
                        closed_utc=c.utc(), normal=True, Native_processes_started=0, GPU_processes_started=0))
                    state['released'] = True
            except BaseException as error:
                c.atomic(attempt / 'failure.json', dict(error=repr(error), traceback=traceback.format_exc(), token=token,
                    at_utc=c.utc(), new_verified_rows=0, Native_processes_started=0, GPU_processes_started=0))
                raise


def self_test(a):
    """Pure mutation tests of the exact plan/map contract; no handle or process."""
    import copy
    old_plan, new_plan, prior = load(PRIOR_PLAN['path']), load(NEW_PLAN['path']), load(PRIOR_IDENTITY['path'])
    shared, fresh, old_catalog = validate_maps(old_plan, new_plan, prior)
    need(len(shared) == 11271 and fresh == new_plan['catalog']['path'] and old_catalog == old_plan['catalog']['path'], 'Real metadata partition differs')
    cases = []
    mutations = (
        ('missing_old_actual_path', lambda p,o,n:p['files'].pop(shared[0])),
        ('changed_actual_digest', lambda p,o,n:p['files'][shared[0]].update(sha256='0'*64)),
        ('changed_shared_size', lambda p,o,n:n['input_inventory'][shared[0]].update(bytes=1)),
        ('unexpected_new_path', lambda p,o,n:n['input_inventory'].update({'runs/unexpected_input.bin':{'bytes':1}})),
        ('wrong_prior_schema', lambda p,o,n:p.update(schema='EXPECTED_HASHES_NOT_ACTUAL')),
        ('wrong_prior_plan', lambda p,o,n:p.update(plan={})),
        ('wrong_hash_source', lambda p,o,n:p.update(source_files={})),
        ('no_continuous_prior_custody', lambda p,o,n:p.update(continuous_Windows_deny_write_delete_custody=False)),
        ('changed_new_mathematical_inventory', lambda p,o,n:n.update(total_rows=1)),
        ('changed_input_roots', lambda p,o,n:n['config'].update(raw_root='runs/other_inputs')),
        ('changed_frame_policy', lambda p,o,n:n['frame_policy'].update(max_rows=1)),
        ('game_acceptance_imported', lambda p,o,n:n.update(old_PASS_or_seed_imported=True)))
    for name, mutate in mutations:
        p,o,n = copy.deepcopy(prior),copy.deepcopy(old_plan),copy.deepcopy(new_plan)
        mutate(p,o,n)
        try:
            validate_maps(o,n,p)
        except (ValueError,KeyError):
            cases.append(dict(name=name,status='PASS_SYNTHETIC_REJECTION'))
        else:
            raise AssertionError('Bad handoff fixture accepted: '+name)
    pointer = load(PRIOR_POINTER['path'])
    check_prior_pointer(pointer, prior)
    for key,bad in (('identity_record',{}),('token','wrong'),('owner',dict(pid=1,creation_time=1.0))):
        value=dict(pointer);value[key]=bad
        try:check_prior_pointer(value,prior)
        except ValueError:cases.append(dict(name='reject_prior_pointer_'+key,status='PASS_SYNTHETIC_REJECTION'))
        else:raise AssertionError('Wrong prior-pointer fixture accepted')
    request=dict(token='new',identity_record={'path':'fixture'},all_owned_services_confirmed_exited=True)
    check_release(request,'new',{'path':'fixture'})
    for key,bad in (('identity_record',{}),('token','wrong'),('all_owned_services_confirmed_exited',False)):
        value=dict(request);value[key]=bad
        try:check_release(value,'new',{'path':'fixture'})
        except ValueError:cases.append(dict(name='reject_release_'+key,status='PASS_SYNTHETIC_REJECTION'))
        else:raise AssertionError('Wrong release fixture accepted')
    value = dict(schema='V17_CUSTODY_HANDOFF_PURE_CONTROLS_ONLY_V1',status='PASS_METADATA_AND_SYNTHETIC_REJECTIONS_ONLY',
        source_record=record(__file__), tests=cases, test_count=len(cases), real_metadata_files_only=True,
        expected_reused_paths=len(shared), expected_new_catalog_path=fresh, Windows_custody_acquired=False,
        actual_handoff_performed=False, Native_processes_started=0,GPU_processes_started=0,game_rows_accepted=0)
    out=path(a.output);need(out.is_relative_to(RUNS) and out!=RUNS,'Only new V17 test output')
    out.parent.mkdir(parents=True,exist_ok=True)
    with out.open('xb') as stream:
        stream.write(json.dumps(value,sort_keys=True,ensure_ascii=False,allow_nan=False).encode()+b'\n');stream.flush();os.fsync(stream.fileno())
    print(json.dumps(record(out)),flush=True)


def main():
    p=argparse.ArgumentParser(description=__doc__);sub=p.add_subparsers(dest='mode',required=True)
    q=sub.add_parser('hold');q.add_argument('--run',required=True);q.add_argument('--hold',action='store_true',required=True)
    q.add_argument('--self-sha256',required=True);q.set_defaults(function=run)
    q=sub.add_parser('self-test');q.add_argument('--output',required=True);q.set_defaults(function=self_test)
    a=p.parse_args();a.function(a)


if __name__=='__main__':
    main()
