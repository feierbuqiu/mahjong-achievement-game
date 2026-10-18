"""Six direct-ELF connection controls, never a replacement mathematical checker.

prepare only copies tiny private inputs. run-case is Linux-only and must run
inside Root's owned outer process/custody supervisor. It executes the same new
V17 ELF with full base/successor startup on every process: there is no cached
PASS import or alternate unchecked entry point. assemble replays raw events
and requires an independently observed outer cleanup/custody receipt.
"""
from pathlib import Path
import argparse, hashlib, json, os, queue, struct, subprocess, sys, threading, time, uuid
import common as c

SCHEMA = 'V17_NATIVE_CONNECTION_CONTROLS_V1'
STATUS = 'PASS_ACTUAL_NATIVE_CONNECTION_CONTROLS'
CASE_IDS = ('positive_full_bucket', 'source_bit_flip', 'deleted_last_row',
            'target_identity_mismatch', 'truncated_source_bits', 'catalog_honor_mismatch')
NATIVE_SHA = '775e05d2601e30847b14b017cb542ea23a8b629d8ebd403aa07bd5942b78f667'
NATIVE_BYTES = 121190888
N, H = 32, 89
CAPTURE = ('build/lean_table_checker/kernel_pilot_v18/capture/'
           'actual56_fc430ddccd7644f2991b54e2accfae51/capture.json')


def input_path(value):
    text = str(value)
    if os.name == 'nt' and text.startswith('/mnt/') and len(text) > 7:
        text = text[5].upper() + ':/' + text[7:]
    return c.path(text)


def linux_path(value):
    p = c.path(value).as_posix()
    if os.name == 'nt':
        c.need(len(p) > 2 and p[1] == ':', 'Expected a local Windows path')
        return '/mnt/' + p[0].lower() + p[2:]
    return p


def read_catalog(path):
    rows = {}
    for line in path.read_text(encoding='utf-8-sig').splitlines():
        if not line.strip():
            continue
        values = list(map(int, line.split()))
        c.need(len(values) == 5, 'Catalog record shape')
        n, h, code, size, blocks = values
        c.need((n, h) not in rows and 0 <= n < 35 and 0 <= h < 184, 'Catalog duplicate/domain')
        rows[n, h] = dict(code=code, size=size, blocks=blocks)
    return rows


def save_bytes(path, data, assets):
    rec = c.once(path, data)
    assets.append(rec)
    return rec


def prepare(a):
    cfg_path = c.path(a.config)
    config = c.load(cfg_path)
    plan_path = c.path(a.plan) if a.plan else cfg_path.parent / 'PLAN.json'
    plan = c.load(plan_path)
    c.need(plan.get('schema') == 'V17_ALL_LAYER_NATIVE_ACTIVITY_PLAN_V1', 'Exact fresh all-layer plan required')
    native = c.path(a.native)
    c.need(a.native_sha256 == NATIVE_SHA and native.stat().st_size == NATIVE_BYTES,
           'Exact new controls-mode V17 ELF required; old diagnostic9d is not the same artifact')
    expected_native = dict(path=c.rel(native), bytes=native.stat().st_size, sha256=a.native_sha256)
    catalog = input_path(config['catalog_file'])
    data = input_path(config['data_root'])
    original_target_data = input_path(config.get('target_data_root', config['data_root']))
    edges = input_path(config['successor_root']) / 'honors.bin'
    source = data / (c.bucket_key(N, H) + '.bits')
    capture = c.path(a.capture or CAPTURE)
    name = a.name or ('native_controls_' + uuid.uuid4().hex[:12])
    c.need(name.replace('_', '').replace('-', '').isalnum() and len(name) <= 60, 'Short unique controls name')
    run = c.owned(c.RUNS / name)
    c.need(not run.exists(), 'Never overwrite a controls run')
    run.mkdir(parents=True)
    assets = []
    with c.ReadLocks([cfg_path, plan_path, catalog, edges, source, capture]):
        rows = read_catalog(catalog)
        c.need((N, H) in rows and rows[N, H]['size'] == 56, 'Actual complete 56-row bucket required')
        source_bytes = source.read_bytes()
        c.need(len(source_bytes) == 8 and source_bytes[0] & 1, 'Actual source row zero must be P')
        proposal = c.load(capture)
        actual_rows = proposal['actual_rows']
        c.need(len(actual_rows) == 56 and [r['row'] for r in actual_rows] == list(range(56)),
               'Raw proposal must cover 56 distinct ordered rows')
        for r in actual_rows:
            c.need((r['layer'], r['honor']) == (N, H) and
                   bytes.fromhex(r['source_bits_hex']) == source_bytes, 'Raw proposal input differs')
            c.need(type(r['byte']) is int and 0 <= r['byte'] <= 128, 'Proposal byte domain')
            c.need(type(r['source_P']) is bool and r['source_P'] == bool(source_bytes[r['row'] // 8] >> (r['row'] % 8) & 1),
                   'Raw proposal source-bit metadata differs')
        packet = bytes(r['byte'] for r in actual_rows)
        c.need(packet[0] == 128, 'Row-zero P proposal required for source-bit mutation control')
        payload = save_bytes(run / 'proposal_56_untrusted.bin', packet, assets)
        dropped = save_bytes(run / 'proposal_55_untrusted.bin', packet[:-1], assets)
        honor_edges = edges.read_bytes()
        c.need(len(honor_edges) == 184 * 24, 'Honor successor input extent')
        code, arity, *next_honors = struct.unpack_from('<6I', honor_edges, H * 24)
        c.need(arity <= 4 and rows[N, H]['code'] == code, 'Actual honor binding')
        needed = sorted(set([H] + next_honors[:arity]))
        c.need(all(0 <= h < 184 for h in needed), 'Actual next honor bounds')
        loaded = [h for h in needed if rows.get((N + 1, h), {}).get('size', 0)]
        c.need(loaded, 'At least one real target required for replacement control')
        target_paths = [data / (c.bucket_key(N + 1, h) + '.bits') for h in loaded]
        target_input_paths = [original_target_data / (c.bucket_key(N + 1, h) + '.bits') for h in loaded]
        with c.ReadLocks(target_paths + target_input_paths):
            target_bytes = {h: p.read_bytes() for h, p in zip(loaded, target_paths)}
            target_original = {h: p.read_bytes() for h, p in zip(loaded, target_input_paths)}
            c.need(all(target_bytes[h] == target_original[h] and target_bytes[h] for h in loaded),
                   'Positive target bytes must equal the actual adjacent source')
            cases = []
            for case_id in CASE_IDS:
                folder = run / case_id
                folder.mkdir()
                private = dict(config)
                count = 55 if case_id == 'deleted_last_row' else 56
                cause = {
                    'positive_full_bucket': 'COMPLETE_TYPED_NATIVE_BUCKET_ACCEPTANCE',
                    'source_bit_flip': 'fragment_cover_source_address_or_indexed_row_rejected',
                    'deleted_last_row': 'BUCKET_CLOSED_EXACT_COVERAGE_FALSE',
                    'target_identity_mismatch': 'actual next-layer byte identity rejected',
                    'truncated_source_bits': 'bucket length mismatch: n32_h089',
                    'catalog_honor_mismatch': 'source catalog honor binding rejected',
                }[case_id]
                if case_id in ('source_bit_flip', 'truncated_source_bits'):
                    shadow = folder / 'source_data'
                    shadow.mkdir()
                    changed = bytes([source_bytes[0] ^ 1]) + source_bytes[1:] if case_id == 'source_bit_flip' else source_bytes[:-1]
                    save_bytes(shadow / source.name, changed, assets)
                    for h, value in target_bytes.items():
                        save_bytes(shadow / (c.bucket_key(N + 1, h) + '.bits'), value, assets)
                    private['data_root'] = linux_path(shadow)
                    private['target_data_root'] = linux_path(original_target_data)
                if case_id == 'target_identity_mismatch':
                    shadow = folder / 'target_data'
                    shadow.mkdir()
                    replaced = loaded[0]
                    for h, value in target_original.items():
                        changed = bytes([value[0] ^ 1]) + value[1:] if h == replaced else value
                        save_bytes(shadow / (c.bucket_key(N + 1, h) + '.bits'), changed, assets)
                    private['target_data_root'] = linux_path(shadow)
                if case_id == 'catalog_honor_mismatch':
                    lines = []
                    for (n, h), row in sorted(rows.items()):
                        row_code = (row['code'] + 1) % 78125 if (n, h) == (N, H) else row['code']
                        lines.append(f"{n}\t{h}\t{row_code}\t{row['size']}\t{row['blocks']}\n")
                    changed_catalog = save_bytes(folder / 'catalog_wrong_honor.tsv', ''.join(lines).encode(), assets)
                    private['catalog_file'] = linux_path(changed_catalog['path'])
                config_record = c.once(folder / 'native_config.json', private)
                assets.append(config_record)
                cases.append(dict(case_id=case_id, config=config_record,
                    payload=dropped if case_id == 'deleted_last_row' else payload,
                    layer=N, honor=H, start=0, count=count, source_size=56,
                    P_rows=sum(source_bytes[r // 8] >> (r % 8) & 1 for r in range(count)),
                    N_rows=count-sum(source_bytes[r // 8] >> (r % 8) & 1 for r in range(count)),
                    expected_cause=cause, expected_rejection=case_id != 'positive_full_bucket',
                    expected_zero_rows=case_id not in ('positive_full_bucket', 'deleted_last_row'),
                    expected_loaded_target_honors=loaded,
                    result_path=c.rel(folder / 'native_frame.json')))
        value = dict(schema='V17_PRIVATE_NATIVE_CONTROLS_FIXTURES_V1', status='PREPARED_UNRUN',
            created_utc=c.utc(), native=expected_native, source_record=c.record(__file__),
            common_source=c.record(c.BASE / 'common.py'), original_config=c.record(cfg_path), plan=c.record(plan_path),
            untrusted_byte_proposal_source=c.record(capture), original_source_bits=c.record(source),
            original_catalog=c.record(catalog), actual_honor_successors=c.record(edges),
            old_acceptance_or_seed_imported=False, proposal_truth_assumed=False,
            cases=cases, private_assets=assets,
            required_outer_input_readlocks=sorted(set(plan['input_inventory']) | {c.rel(native), c.rel(capture)}),
            every_process_must_run_full_actual_base_and_successors=True,
            preferred_execution='CONTROLS_ONE_ACTUAL_BASE_SESSION_V1',
            outer_process_tree_and_custody_supervision_required=True,
            Native_runs=0, GPU_contexts=0, original_files_written=False)
        manifest = c.once(run / 'MANIFEST.json', value)
    print(c.canonical(dict(manifest=manifest, cases=list(CASE_IDS), status='PREPARED_UNRUN')).decode())


def protocol(case, payload, output):
    command = dict(transport=c.WIRE, start=case['start'], count=case['count'],
                   compact_bytes=case['count'], output=str(output))
    c.need(len(payload) == case['count'], 'Fixture payload extent')
    return (c.canonical(dict(open=True, layer=case['layer'], honor=case['honor'])) + b'\n' +
            c.canonical(command) + b'\n' + payload + c.END +
            c.canonical(dict(close=True)) + b'\n' + c.canonical(dict(stop=True)) + b'\n')


def decode_events(raw):
    lines = raw.decode('utf8').splitlines()
    events = [json.loads(line) for line in lines]
    c.need(all(isinstance(v, dict) for v in events), 'Every Native line must be a JSON object')
    return events


def classify(case, events, stderr, returncode, timed_out, saved):
    """Admission over actual raw outputs; this function never executes a checker."""
    if timed_out:
        return dict(passed=False, actual_native_cause='INCONCLUSIVE_TIMEOUT')
    names = [v.get('event') for v in events]
    c.need(names[:2] == ['BASE_CHECKED', 'GLOBAL_READY'], 'Fresh complete global checks did not reach readiness')
    for value in events[:2]:
        c.need(value.get('baseChecked') is True and value.get('successorsChecked') is True,
               'Actual global acceptance flags missing')
    case_id = case['case_id']
    if case_id in ('positive_full_bucket', 'deleted_last_row'):
        c.need(returncode == 0 and names == ['BASE_CHECKED', 'GLOBAL_READY', 'BUCKET_READY',
            'FRAME_RESULT', 'BUCKET_CLOSED', 'GLOBAL_STOPPED'], 'Clean complete Native protocol required')
        ready, frame, closed = events[2:5]
        c.need(ready.get('metadataChecked') is True and ready.get('targetIdentity') is True and
               ready.get('loaded_target_honors') == case['expected_loaded_target_honors'],
               'Native metadata/actual target list differs')
        expected = dict(layer=case['layer'], honor=case['honor'], start=case['start'], count=case['count'],
                        checked_rows=case['count'], P_rows=case['P_rows'], N_rows=case['N_rows'], logical_fragments=12)
        c.need(all(type(frame.get(k)) is int and frame[k] == v for k, v in expected.items()), 'Actual Native frame extent/count differs')
        c.need(frame.get('frameAccepted') is True and saved == frame, 'Native saved and emitted accepted frame must agree')
        c.need(closed.get('checked_rows') == case['count'] and closed.get('ranges') == [[0, case['count']]],
               'Actual typed completed ranges differ')
        exact = case_id == 'positive_full_bucket'
        c.need(closed.get('exactCoverage') is exact, 'Deleted tail must be refused by the actual Native exact-cover Bool')
        return dict(passed=True, actual_native_cause=case['expected_cause'],
                    accepted_frame_rows=case['count'], exact_bucket_coverage=exact)
    expected_names = ['BASE_CHECKED', 'GLOBAL_READY', 'BUCKET_READY'] if case_id == 'source_bit_flip' else ['BASE_CHECKED', 'GLOBAL_READY']
    c.need(case_id in CASE_IDS and returncode != 0 and names == expected_names, 'Expected Native rejection point/exit differs')
    c.need(case['expected_cause'] in stderr and saved is None, 'Exact genuine Native rejection cause required; no saved accepted frame')
    return dict(passed=True, actual_native_cause=case['expected_cause'], accepted_frame_rows=0,
                exact_bucket_coverage=False)


def classify_control(case, events, saved):
    """Actual controls-mode events, never synthetic GLOBAL_STOPPED padding.

The full Session's actual startup, final STOP/EOF and OS exit are separately
bound and replayed. A control rejection may be caught only in this new IO
mode; its precise error and stage still come from the same native checks.
"""
    case_id = case['case_id']
    c.need(events and all(v.get('control_case_id', case_id) == case_id for v in events),
           'Control event case identity differs')
    names = [v.get('event') for v in events]
    if case_id in ('positive_full_bucket', 'deleted_last_row'):
        c.need(names == ['BUCKET_READY', 'FRAME_RESULT', 'BUCKET_CLOSED'], 'Actual complete control-bucket protocol required')
        ready, frame, closed = events
        c.need(ready.get('metadataChecked') is True and ready.get('targetIdentity') is True and
               ready.get('loaded_target_honors') == case['expected_loaded_target_honors'], 'Actual target/metadata binding')
        expected = dict(layer=case['layer'], honor=case['honor'], start=0, count=case['count'],
            checked_rows=case['count'], P_rows=case['P_rows'], N_rows=case['N_rows'], logical_fragments=12)
        c.need(all(type(frame.get(k)) is int and frame[k] == v for k, v in expected.items()), 'Actual frame extent/count')
        c.need(frame.get('frameAccepted') is True and saved == frame, 'Actual saved/emitted frame differs')
        c.need(closed.get('checked_rows') == case['count'] and closed.get('ranges') == [[0, case['count']]], 'Actual completed ranges differ')
        exact = case_id == 'positive_full_bucket'
        c.need(closed.get('exactCoverage') is exact, 'Actual complete/deleted-tail cover outcome differs')
        return dict(passed=True, actual_native_cause=case['expected_cause'],
            accepted_frame_rows=case['count'], exact_bucket_coverage=exact)
    expected = ['BUCKET_READY', 'CONTROL_REJECTED'] if case_id == 'source_bit_flip' else ['CONTROL_REJECTED']
    c.need(case_id in CASE_IDS and names == expected and saved is None, 'Actual control rejection point differs')
    rejected = events[-1]
    c.need(rejected.get('control_case_id') == case_id and case['expected_cause'] in rejected.get('error', ''),
           'Precise genuine native checker rejection required')
    c.need(rejected.get('stage') == ('frame' if case_id == 'source_bit_flip' else 'open'), 'Actual native rejection stage differs')
    return dict(passed=True, actual_native_cause=case['expected_cause'], accepted_frame_rows=0,
        exact_bucket_coverage=False)


def checked_session_events(events):
    c.need(len(events) >= 3 and [v.get('event') for v in events[:2]] == ['BASE_CHECKED', 'GLOBAL_READY'],
           'One fresh actual base/successor startup required')
    for event in events[:2]:
        c.need(event.get('baseChecked') is True and event.get('successorsChecked') is True, 'Actual global checks missing')
    c.need(events[1].get('mode') == 'controls', 'Dedicated actual controls mode required')
    c.need(sum(v.get('event') == 'BASE_CHECKED' for v in events) == 1 and
           sum(v.get('event') == 'GLOBAL_READY' for v in events) == 1, 'Startup must run once, not be synthesized per case')
    end = events[-1]
    c.need(end.get('event') == 'GLOBAL_STOPPED' and end.get('mode') == 'controls' and
           end.get('completed_controls') == 6 and end.get('control_case_ids') == list(CASE_IDS),
           'Actual complete six-case STOP accounting required')


def run_session(a):
    c.need(sys.platform == 'linux', 'Controls run in Root\'s owned Linux outer supervisor')
    mp = c.path(a.manifest)
    manifest = c.load(mp)
    c.need(manifest['schema'] == 'V17_PRIVATE_NATIVE_CONTROLS_FIXTURES_V1', 'Fixture manifest schema')
    c.need(c.record(__file__) == manifest['source_record'] and c.record(c.BASE / 'common.py') == manifest['common_source'],
           'Controls implementation changed after preparation')
    c.need([v['case_id'] for v in manifest['cases']] == list(CASE_IDS), 'Exact ordered six-case registration')
    for record in manifest['private_assets']:
        c.checked_record(record)
    c.checked_record(manifest['native'])
    c.checked_record(manifest['original_config'])
    folder = mp.parent / 'single_native_session'
    folder.mkdir()
    stdout_path, stderr_path = folder / 'native.stdout.jsonl', folder / 'native.stderr.log'
    argv = [str(c.path(manifest['native']['path'])), 'controls', str(c.path(manifest['original_config']['path']))]
    child = None
    reader = None
    started = time.monotonic()
    q = queue.Queue()
    eof = object()
    events, case_data = [], []
    timed_out = False
    failure = None
    stdout = stdout_path.open('xb')
    stderr = stderr_path.open('xb')
    c.once(folder / 'invocation_intent.json', dict(schema='V17_NATIVE_CONTROLS_SESSION_INTENT_V1',
        native=manifest['native'], manifest=c.record(mp), source_record=manifest['source_record'],
        argv=argv, full_base_recheck=True, one_actual_base_session=True,
        outer_supervisor_required=True, created_utc=c.utc()))
    try:
        child = subprocess.Popen(argv, cwd=c.ROOT, env=dict(os.environ, LEAN_NUM_THREADS=str(a.pool_threads)),
            stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=stderr, bufsize=0)
        c.once(folder / 'native_started.json', dict(pid=child.pid, native=manifest['native'],
            source_record=manifest['source_record'], argv=argv, started_utc=c.utc()))
        print(c.canonical(dict(event='NATIVE_CONTROLS_SESSION_STARTED', pid=child.pid, native=manifest['native'])).decode(), flush=True)
        def pump():
            try:
                while True:
                    raw = child.stdout.readline(2_000_001)
                    if not raw:
                        break
                    c.need(len(raw) <= 2_000_000 and raw.endswith(b'\n'), 'Native event extent/framing')
                    stdout.write(raw)
                    stdout.flush()
                    q.put(json.loads(raw))
            except BaseException as error:
                q.put(error)
            finally:
                q.put(eof)
        reader = threading.Thread(target=pump, daemon=True)
        reader.start()
        def take():
            nonlocal timed_out
            remaining = None if a.timeout_seconds is None else max(0.001, a.timeout_seconds-(time.monotonic()-started))
            try:
                value = q.get(timeout=remaining)
            except queue.Empty:
                timed_out = True
                raise TimeoutError('Explicit whole diagnostic timeout; not a successful rejection')
            if isinstance(value, BaseException):
                raise value
            c.need(value is not eof and isinstance(value, dict), 'Native EOF before expected event')
            events.append(value)
            return value
        def send(value):
            child.stdin.write(c.canonical(value) + b'\n')
            child.stdin.flush()
        base, ready = take(), take()
        c.need(base.get('event') == 'BASE_CHECKED' and ready.get('event') == 'GLOBAL_READY' and
               ready.get('mode') == 'controls', 'Actual new controls startup protocol')
        for value in (base, ready):
            c.need(value.get('baseChecked') is True and value.get('successorsChecked') is True, 'Actual global checks did not accept')
        for case in manifest['cases']:
            output = c.owned(case['result_path'])
            c.need(not output.exists(), 'New result path required')
            first = len(events)
            send(dict(control=True, case_id=case['case_id'], config=linux_path(case['config']['path']),
                      layer=case['layer'], honor=case['honor']))
            event = take()
            if event.get('event') == 'BUCKET_READY':
                payload = c.path(case['payload']['path']).read_bytes()
                c.need(len(payload) == case['count'], 'Actual proposal byte extent')
                send(dict(transport=c.WIRE, start=case['start'], count=case['count'],
                          compact_bytes=case['count'], output=str(output)))
                child.stdin.write(payload + c.END)
                child.stdin.flush()
                event = take()
                if event.get('event') == 'FRAME_RESULT':
                    send(dict(close=True))
                    event = take()
            saved = c.load(output) if output.exists() else None
            verdict = classify_control(case, events[first:], saved)
            case_data.append((case, first, len(events), verdict))
            print(c.canonical(dict(event='ACTUAL_CONTROL_CASE_COMPLETED', case_id=case['case_id'],
                                   actual_native_cause=verdict['actual_native_cause'])).decode(), flush=True)
        send(dict(stop=True))
        child.stdin.close()
        take()
        child.wait()
        c.need(child.returncode == 0, 'Actual controls Native nonzero exit')
        checked_session_events(events)
        c.need(q.get(timeout=10) is eof, 'Extra Native stdout after STOP')
        reader.join(timeout=10)
        c.need(not reader.is_alive(), 'Native stdout reader has not reached EOF')
    except BaseException as error:
        failure = repr(error)
    finally:
        if child is not None and child.poll() is None:
            child.terminate()
            try:
                child.wait(timeout=15)
            except subprocess.TimeoutExpired:
                child.kill()
                child.wait()
        if reader is not None:
            reader.join(timeout=10)
        stdout.close()
        stderr.close()
    if failure:
        result = c.once(folder / 'session_report.json', dict(schema='V17_ACTUAL_NATIVE_CONTROLS_SESSION_V1',
            status='FAILED_OR_INCONCLUSIVE', error=failure, native=manifest['native'], manifest=c.record(mp),
            source_record=manifest['source_record'], native_returncode=None if child is None else child.poll(),
            native_process_waited_and_exited=child is not None and child.poll() is not None,
            timed_out=timed_out, stdout=c.record(stdout_path), stderr=c.record(stderr_path),
            completed_actual_cases=[x[0]['case_id'] for x in case_data], GPU_contexts=0))
        print(c.canonical(dict(report=result, status='FAILED_OR_INCONCLUSIVE')).decode(), flush=True)
        return 2
    session_report = dict(schema='V17_ACTUAL_NATIVE_CONTROLS_SESSION_V1', status='PASS_ACTUAL_SIX_CASE_SESSION',
        native=manifest['native'], manifest=c.record(mp), source_record=manifest['source_record'],
        native_process_id=child.pid, native_returncode=0, native_process_waited_and_exited=True,
        stdout_EOF_confirmed=True, one_actual_base_session=True, actual_base_event_count=1,
        completed_actual_cases=list(CASE_IDS), timed_out=False, elapsed_seconds=time.monotonic()-started,
        stdout=c.record(stdout_path), stderr=c.record(stderr_path), native_started=c.record(folder/'native_started.json'),
        outer_scope_cleanup_must_be_independently_confirmed=True, GPU_contexts=0,
        closed_actual_input_Lean_declaration=False)
    sr = c.once(folder / 'session_report.json', session_report)
    reports = []
    for case, first, stop, verdict in case_data:
        output = c.owned(case['result_path'])
        report = dict(schema='V17_ACTUAL_NATIVE_CONNECTION_CASE_V1', case_id=case['case_id'],
            execution_mode='CONTROLS_ONE_ACTUAL_BASE_SESSION_V1', status='PASS_ACTUAL_CASE', **verdict,
            native=manifest['native'], source_record=manifest['source_record'], manifest=c.record(mp),
            config=case['config'], payload=case['payload'], session_report=sr, event_range=[first,stop],
            stdout=session_report['stdout'], stderr=session_report['stderr'],
            saved_result=c.record(output) if output.exists() else None,
            native_started=session_report['native_started'], native_process_id=child.pid,
            native_returncode=0, native_process_waited_and_exited=True, timed_out=False,
            expected_zero_rows=case['expected_zero_rows'], GPU_contexts=0,
            outer_scope_cleanup_must_be_independently_confirmed=True,
            original_files_written=False, closed_actual_input_Lean_declaration=False)
        reports.append(c.once(c.path(case['config']['path']).parent / 'case_report.json', report))
    print(c.canonical(dict(session_report=sr, case_reports=reports,
        status='PASS_ACTUAL_SIX_CASE_SESSION_PENDING_OUTER_CLEANUP')).decode(), flush=True)
    return 0


def run_case(a):
    c.need(sys.platform == 'linux', 'Direct V17 ELF controls run only in the owned Linux outer supervisor')
    manifest_path = c.path(a.manifest)
    manifest = c.load(manifest_path)
    c.need(manifest['schema'] == 'V17_PRIVATE_NATIVE_CONTROLS_FIXTURES_V1', 'Fixture manifest schema')
    c.need(c.record(__file__) == manifest['source_record'] and c.record(c.BASE / 'common.py') == manifest['common_source'],
           'Controls implementation changed after fixture preparation')
    case = next((v for v in manifest['cases'] if v['case_id'] == a.case), None)
    c.need(case is not None, 'Unregistered case')
    for asset in manifest['private_assets']:
        c.checked_record(asset)
    c.checked_record(manifest['native'])
    if a.timeout_seconds is not None:
        c.need(a.timeout_seconds > 0, 'Positive explicit diagnostic timeout')
    folder = c.path(case['config']['path']).parent
    output = c.owned(case['result_path'])
    stdout_path, stderr_path = folder / 'native.stdout.jsonl', folder / 'native.stderr.log'
    c.need(not output.exists() and not stdout_path.exists() and not stderr_path.exists(), 'Case is single use; prepare a new run after failure')
    payload = c.path(case['payload']['path']).read_bytes()
    argv = [str(c.path(manifest['native']['path'])), 'serve', str(c.path(case['config']['path']))]
    started = time.monotonic()
    c.once(folder / 'invocation_intent.json', dict(schema='V17_NATIVE_CONTROL_INVOCATION_INTENT_V1',
        case_id=a.case, native=manifest['native'], manifest=c.record(manifest_path), argv=argv,
        outer_supervisor_required=True, full_base_recheck=True, created_utc=c.utc()))
    child = None
    timed_out = False
    try:
        with stdout_path.open('xb') as stdout, stderr_path.open('xb') as stderr:
            # The child stays in Root's owned outer scope. We deliberately do
            # not establish another process group or duplicate its guardian.
            child = subprocess.Popen(argv, cwd=c.ROOT, env=dict(os.environ, LEAN_NUM_THREADS=str(a.pool_threads)),
                stdin=subprocess.PIPE, stdout=stdout, stderr=stderr)
            c.once(folder / 'native_started.json', dict(case_id=a.case, pid=child.pid,
                native=manifest['native'], source_record=manifest['source_record'], started_utc=c.utc()))
            print(c.canonical(dict(event='NATIVE_CONTROL_STARTED', case_id=a.case, pid=child.pid,
                                   native=manifest['native'])).decode(), flush=True)
            try:
                child.communicate(protocol(case, payload, output), timeout=a.timeout_seconds)
            except subprocess.TimeoutExpired:
                timed_out = True
                child.terminate()
                try:
                    child.communicate(timeout=15)
                except subprocess.TimeoutExpired:
                    child.kill()
                    child.communicate()
        raw_events = decode_events(stdout_path.read_bytes())
        stderr_text = stderr_path.read_text(encoding='utf8', errors='replace')
        saved = c.load(output) if output.exists() else None
        try:
            verdict = classify(case, raw_events, stderr_text, child.returncode, timed_out, saved)
        except (ValueError, KeyError, TypeError) as error:
            verdict = dict(passed=False, actual_native_cause='UNEXPECTED_NATIVE_OUTCOME', error=repr(error))
        report = dict(schema='V17_ACTUAL_NATIVE_CONNECTION_CASE_V1', case_id=a.case,
            status='PASS_ACTUAL_CASE' if verdict['passed'] else 'FAILED_OR_INCONCLUSIVE',
            **verdict, native=manifest['native'], source_record=manifest['source_record'],
            manifest=c.record(manifest_path), config=case['config'], payload=case['payload'],
            stdout=c.record(stdout_path), stderr=c.record(stderr_path),
            saved_result=c.record(output) if output.exists() else None,
            native_started=c.record(folder / 'native_started.json'), native_process_id=child.pid,
            native_returncode=child.returncode, native_process_waited_and_exited=child.poll() is not None,
            timed_out=timed_out, elapsed_seconds=time.monotonic()-started,
            expected_zero_rows=case['expected_zero_rows'], GPU_contexts=0,
            outer_scope_cleanup_must_be_independently_confirmed=True,
            original_files_written=False, closed_actual_input_Lean_declaration=False)
        record = c.once(folder / 'case_report.json', report)
        print(c.canonical(dict(report=record, passed=verdict['passed'], case_id=a.case)).decode(), flush=True)
        return 0 if verdict['passed'] else 2
    finally:
        if child is not None and child.poll() is None:
            child.terminate()
            try:
                child.wait(timeout=15)
            except subprocess.TimeoutExpired:
                child.kill()
                child.wait()


def assemble(a):
    manifest_path = c.path(a.manifest)
    manifest = c.load(manifest_path)
    files = [manifest_path] + [c.path(v) for v in a.reports] + [c.path(a.cleanup)]
    with c.ReadLocks(files):
        c.need(manifest['source_record'] == c.record(__file__), 'Current reviewed controls source required')
        reports = [c.load(p) for p in files[1:-1]]
        c.need(len(reports) == len(CASE_IDS) and {v.get('case_id') for v in reports} == set(CASE_IDS), 'Exactly six distinct actual cases required')
        records, cases = [], []
        for report, path in zip(reports, files[1:-1]):
            case = next(v for v in manifest['cases'] if v['case_id'] == report['case_id'])
            c.need(report['schema'] == 'V17_ACTUAL_NATIVE_CONNECTION_CASE_V1' and
                   report['manifest'] == c.record(manifest_path) and report['native'] == manifest['native'] and
                   report['source_record'] == manifest['source_record'] and
                   report['native_process_waited_and_exited'] is True, 'Actual case identity/exit binding')
            for key in ('stdout', 'stderr', 'saved_result', 'native_started'):
                if report.get(key) is not None:
                    c.checked_record(report[key])
            saved = c.load(c.path(report['saved_result']['path'])) if report['saved_result'] else None
            events = decode_events(c.path(report['stdout']['path']).read_bytes())
            if report.get('execution_mode') == 'CONTROLS_ONE_ACTUAL_BASE_SESSION_V1':
                c.checked_record(report['session_report'])
                session = c.load(c.path(report['session_report']['path']))
                c.need(session.get('status') == 'PASS_ACTUAL_SIX_CASE_SESSION' and
                       session.get('native') == manifest['native'] and session.get('manifest') == c.record(manifest_path) and
                       session.get('native_process_id') == report['native_process_id'] and
                       session.get('native_returncode') == 0 and session.get('stdout_EOF_confirmed') is True and
                       session.get('stdout') == report['stdout'], 'Actual same-session STOP/EOF/exit binding')
                checked_session_events(events)
                first, stop = report['event_range']
                c.need(type(first) is int and type(stop) is int and 2 <= first < stop < len(events), 'Actual case event range')
                verdict = classify_control(case, events[first:stop], saved)
            else:
                verdict = classify(case, events,
                    c.path(report['stderr']['path']).read_text(encoding='utf8', errors='replace'),
                    report['native_returncode'], report['timed_out'], saved)
            c.need(verdict['passed'] and report['passed'] is True, 'Actual Native case failed independent raw replay')
            record = c.record(path)
            records.append(record)
            cases.append(dict(case_id=case['case_id'], report=record, **verdict,
                              expected_zero_rows=case['expected_zero_rows']))
        cleanup = c.load(files[-1])
        # This is an explicit outer OS/custody observation, not a mathematical
        # premise or a synthetic control fixture. Root's guardian produces it
        # only after these exact invocations and their full child trees exit.
        c.need(cleanup.get('schema') == 'V17_NATIVE_CONTROLS_OUTER_CLEANUP_V1' and
               cleanup.get('manifest') == c.record(manifest_path) and cleanup.get('native') == manifest['native'],
               'Exact independently observed outer cleanup record required')
        c.need(sorted(cleanup.get('case_reports', []), key=lambda v: v['path']) == sorted(records, key=lambda v: v['path']),
               'Outer cleanup must bind these exact six actual reports')
        c.need(cleanup.get('all_owned_services_confirmed_exited') is True and
               cleanup.get('all_child_trees_confirmed_empty') is True and
               cleanup.get('actual_input_and_code_readlocks_held_through_exit') is True,
               'Outer process/custody confirmation incomplete')
        result = dict(schema=SCHEMA, status=STATUS, native=manifest['native'],
            source_record=c.record(__file__), manifest=c.record(manifest_path), cases=cases,
            all_owned_services_confirmed_exited=True, outer_cleanup=c.record(files[-1]),
            required_controls_passed=True, raw_outcomes_independently_replayed=True,
            old_acceptance_or_seed_imported=False, GPU_contexts=0, whole_table_verified=False,
            claim_class='FIXED_V17_KERNEL_IMPLICATION_PLUS_ACTUAL_NATIVE_CONTROLS',
            closed_actual_input_Lean_declaration=False, completed_utc=c.utc())
        output = c.once(c.owned(a.output), result)
    print(c.canonical(dict(report=output, status=STATUS)).decode())


def self_test(a):
    """Synthetic admission tests only; never an actual Native acceptance."""
    case = dict(case_id='positive_full_bucket', layer=32, honor=89, start=0, count=56,
        P_rows=41, N_rows=15, expected_loaded_target_honors=[125], expected_cause='POSITIVE')
    base = dict(event='BASE_CHECKED', baseChecked=True, successorsChecked=True)
    ready = dict(event='GLOBAL_READY', baseChecked=True, successorsChecked=True)
    bucket = dict(event='BUCKET_READY', metadataChecked=True, targetIdentity=True, loaded_target_honors=[125])
    frame = dict(event='FRAME_RESULT', layer=32, honor=89, start=0, count=56, checked_rows=56,
        P_rows=41, N_rows=15, logical_fragments=12, frameAccepted=True)
    closed = dict(event='BUCKET_CLOSED', checked_rows=56, ranges=[[0,56]], exactCoverage=True)
    values = [base, ready, bucket, frame, closed, dict(event='GLOBAL_STOPPED')]
    count = 0
    c.need(classify(case, values, '', 0, False, frame)['passed'], 'Synthetic positive admission')
    count += 1
    def rejects(*args):
        nonlocal count
        try:
            value = classify(*args)
        except (ValueError, KeyError, TypeError):
            count += 1
            return
        c.need(not value['passed'], 'Synthetic invalid evidence was accepted')
        count += 1
    rejects(case, values, '', 0, True, frame)
    rejects(case, values[1:], '', 0, False, frame)
    rejects(case, values, '', 1, False, frame)
    rejects(case, values, '', 0, False, None)
    rejects(case, values[:-1], '', 0, False, frame)
    wrong = [dict(v) for v in values]
    wrong[2]['loaded_target_honors'] = []
    rejects(case, wrong, '', 0, False, frame)
    wrong = [dict(v) for v in values]
    wrong[3]['count'] = True
    rejects(case, wrong, '', 0, False, frame)
    for case_id in CASE_IDS[1:]:
        if case_id == 'deleted_last_row':
            continue
        bad = dict(case, case_id=case_id, expected_cause='ACTUAL_EXPECTED_CAUSE')
        prefix = values[:3] if case_id == 'source_bit_flip' else values[:2]
        c.need(classify(bad, prefix, 'uncaught exception: ACTUAL_EXPECTED_CAUSE', 1, False, None)['passed'],
               'Synthetic exact rejection admission')
        count += 1
        rejects(bad, prefix, 'timeout', 1, False, None)
        rejects(bad, prefix, 'ACTUAL_EXPECTED_CAUSE', 0, False, None)
        rejects(bad, prefix, 'ACTUAL_EXPECTED_CAUSE', 1, True, None)
        rejects(bad, prefix, 'ACTUAL_EXPECTED_CAUSE', 1, False, frame)
        rejects(bad, prefix + [frame], 'ACTUAL_EXPECTED_CAUSE', 1, False, None)
    dropped = dict(case, case_id='deleted_last_row', count=55, P_rows=40, N_rows=15,
                   expected_cause='BUCKET_CLOSED_EXACT_COVERAGE_FALSE')
    tail = [dict(v) for v in values]
    tail[3].update(count=55, checked_rows=55, P_rows=40)
    tail[4].update(checked_rows=55, ranges=[[0,55]], exactCoverage=False)
    c.need(classify(dropped, tail, '', 0, False, tail[3])['passed'], 'Synthetic actual tail refusal admission')
    count += 1
    tail[4]['exactCoverage'] = True
    rejects(dropped, tail, '', 0, False, tail[3])
    control_events = [dict(v) for v in (bucket, frame, closed)]
    control_events[0]['control_case_id'] = case['case_id']
    control_events[-1]['control_case_id'] = case['case_id']
    c.need(classify_control(case, control_events, frame)['passed'], 'Synthetic controls-mode positive')
    count += 1
    def controls_reject(bad_case, events, saved):
        nonlocal count
        try:
            classify_control(bad_case, events, saved)
        except (ValueError, KeyError, TypeError):
            count += 1
            return
        raise ValueError('Synthetic controls-mode invalid evidence accepted')
    controls_reject(case, control_events[:-1], frame)
    controls_reject(case, control_events, None)
    for case_id in CASE_IDS[1:]:
        if case_id == 'deleted_last_row':
            continue
        bad = dict(case, case_id=case_id, expected_cause='ACTUAL_EXPECTED_CAUSE')
        rejection = dict(event='CONTROL_REJECTED', control_case_id=case_id,
            stage='frame' if case_id == 'source_bit_flip' else 'open', error='ACTUAL_EXPECTED_CAUSE')
        prefix = [dict(bucket, control_case_id=case_id)] if case_id == 'source_bit_flip' else []
        c.need(classify_control(bad, prefix+[rejection], None)['passed'], 'Synthetic genuine controls rejection')
        count += 1
        controls_reject(bad, prefix+[dict(rejection, error='timeout')], None)
        controls_reject(bad, prefix+[dict(rejection, stage='unrelated')], None)
        controls_reject(bad, prefix+[rejection], frame)
    session_events = [base, dict(ready, mode='controls')] + control_events + [dict(event='GLOBAL_STOPPED',
        mode='controls', completed_controls=6, control_case_ids=list(CASE_IDS))]
    checked_session_events(session_events)
    count += 1
    for altered in (session_events[1:], session_events+[base],
                    session_events[:-1]+[dict(session_events[-1], completed_controls=5)]):
        try:
            checked_session_events(altered)
        except (ValueError, KeyError, TypeError):
            count += 1
        else:
            raise ValueError('Synthetic wrong startup/STOP accepted')
    value = dict(schema='V17_NATIVE_CONTROL_ADMISSION_SYNTHETIC_TESTS_V1', status='PASS_SYNTHETIC_ONLY',
        source_record=c.record(__file__), control_count=count, Native_runs=0, GPU_contexts=0,
        actual_controls_passed=False, utc=c.utc())
    if a.output:
        result = c.once(c.owned(a.output), value)
        print(c.canonical(result).decode())
    else:
        print(c.canonical(value).decode())


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    sub = parser.add_subparsers(dest='command', required=True)
    p = sub.add_parser('prepare')
    p.add_argument('--config', required=True)
    p.add_argument('--plan')
    p.add_argument('--native', required=True)
    p.add_argument('--native-sha256', required=True)
    p.add_argument('--capture')
    p.add_argument('--name')
    p = sub.add_parser('run-case')
    p.add_argument('--manifest', required=True)
    p.add_argument('--case', choices=CASE_IDS, required=True)
    p.add_argument('--timeout-seconds', type=float)
    p.add_argument('--pool-threads', type=int, choices=range(1, 13), default=12)
    p = sub.add_parser('run-session', help='All six cases, one actual base Session; outer supervisor required')
    p.add_argument('--manifest', required=True)
    p.add_argument('--timeout-seconds', type=float)
    p.add_argument('--pool-threads', type=int, choices=range(1, 13), default=12)
    p = sub.add_parser('assemble')
    p.add_argument('--manifest', required=True)
    p.add_argument('--reports', nargs='+', required=True)
    p.add_argument('--cleanup', required=True)
    p.add_argument('--output', required=True)
    p = sub.add_parser('self-test')
    p.add_argument('--output')
    args = parser.parse_args()
    return {'prepare': prepare, 'run-case': run_case, 'run-session': run_session,
            'assemble': assemble, 'self-test': self_test}[args.command](args)


if __name__ == '__main__':
    raise SystemExit(main())
