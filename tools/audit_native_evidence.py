#!/usr/bin/env python3
"""Recheck the v2 saved-record archive, including close events and custody handover."""
import argparse
from collections import defaultdict
import importlib.util
import json
from pathlib import Path
import sys
import zipfile

ROOT = Path(__file__).resolve().parents[1]
BASE = ROOT / 'research/2026-10-19-v2'
RUN = 'runs/lean_table_checker/v17_compute_finish_20261018/full_native_20261018_02/'


def load_module(name, path):
    spec = importlib.util.spec_from_file_location(name, path)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


def require(condition, message):
    if not condition:
        raise ValueError(message)


def check_close(event, layer, honor, rows, ranges):
    """This publication audit rejects false/missing flags; historical production did not."""
    require(event.get('event') == 'BUCKET_CLOSED', 'Not a native bucket-close event')
    require((event.get('layer'), event.get('honor')) == (layer, honor), 'Close bucket differs')
    require(event.get('exactCoverage') is True, 'Recorded native exactCoverage is not true')
    require(event.get('checked_rows') == rows, 'Close row count differs')
    require(event.get('ranges') == ranges, 'Close ranges differ from committed frames')


def audit(path):
    descriptor = json.loads((BASE / 'assets.json').read_text())['assets'][0]
    legacy = load_module('v17_saved_records', ROOT / 'research/2026-10-19-v17/verify.py')
    result = legacy.verify_archive(path, descriptor=descriptor)
    privacy = load_module('publication_privacy', ROOT / 'tools/privacy_guard.py')
    privacy_members = privacy.check_zip(path)
    with zipfile.ZipFile(path) as archive:
        contents = json.loads(archive.read('CONTENTS.json'))
        members = {item['path']: item for item in contents['files']}

        def raw(name):
            return archive.read('workspace/' + name)

        def read(name):
            return json.loads(raw(name))

        def record(item):
            name = 'workspace/' + item['path']
            require(name in members, 'Missing supplemental record: ' + item['path'])
            supplied = members[name]
            require(supplied['original_sha256'] == item['sha256'] and
                    supplied['original_bytes'] == item['bytes'], 'Original record binding differs')
            return json.loads(archive.read(name))

        plan = read(RUN + 'PLAN.json')
        cells = {(c['layer'], c['honor']): c for c in plan['cells'] if c['size']}
        ledger = [json.loads(line) for line in raw(RUN + 'ledger.jsonl').splitlines()]
        ranges = defaultdict(list)
        sessions = {}
        for entry in ledger:
            n, h, start, count = entry['frame_key']
            ranges[n, h].append([start, count])
            receipt = record(entry['receipt'])
            sessions[n, h] = (receipt['session_id'], receipt['bucket_open_id'])
        closed = {}
        preflight = []
        reports = []
        for name in members:
            relative = name.removeprefix('workspace/')
            if not relative.startswith(RUN):
                continue
            if relative.endswith('.closed.json'):
                item = read(relative)
                event = item.get('native_event', {})
                if event.get('event') != 'BUCKET_CLOSED':
                    continue
                key = (event['layer'], event['honor'])
                require(key in cells and key not in closed, 'Unknown or duplicate bucket close')
                check_close(event, *key, cells[key]['size'], ranges[key])
                require((item['session_id'], item['bucket_open_id']) == sessions[key],
                        'Close/frame session or bucket-open binding differs')
                closed[key] = relative
            elif relative.endswith('/ROOT_PREFLIGHT.json'):
                preflight.append(read(relative))
            elif relative.startswith(RUN + 'reports/') and relative.endswith('.json'):
                reports.append(read(relative))
        require(set(closed) == set(cells), 'Native bucket-close inventory incomplete')
        require(len(preflight) == 1, 'Root preflight inventory differs')
        root = preflight[0]
        require(root['actual_game_rows_accepted'] == 0 and root['game_winner_claimed'] is False and
                root['full_root_frame_still_required'] is True, 'Preflight incorrectly used as row proof')
        require(root['opened']['native_event']['rootChecked'] is True and
                root['closed']['native_event']['exactCoverage'] is False and
                root['closed']['native_event']['checked_rows'] == 0, 'Preflight root scope differs')
        manifest = read(RUN + 'MANIFEST.json')
        before = record(read(RUN + 'INPUTS_BEFORE.json')['identity_record'])
        prior = record(before['prior_actual_identity'])
        after = record(read(RUN + 'INPUTS_AFTER.json')['identity_record'])
        require(before['files'] == after['files'] == manifest['inputs_before'], 'Custody maps differ')
        require(before['continuous_Windows_deny_write_delete_custody'] is True and
                before['derived_from_actual_continuously_locked_hash'] is True and
                prior['continuous_Windows_deny_write_delete_custody'] is True, 'Recorded custody claim differs')
        require(before['hash_reused_count'] == 11271 and before['hash_reused_bytes'] == 100615716067 and
                before['actual_bytes_hashed_this_invocation'] == 118103, 'Handover counts differ')
        changed = {k: v for k, v in before['files'].items() if k not in prior['files']}
        retired = {k: v for k, v in prior['files'].items() if k not in before['files']}
        shared = set(before['files']) & set(prior['files'])
        require(len(shared) == 11271 and len(changed) == len(retired) == 1 and
                all(before['files'][key] == prior['files'][key] for key in shared),
                'Prior/current handover map relation differs')
        require(sum(v['bytes'] for v in changed.values()) == 118103 and
                sum(before['files'][key]['bytes'] for key in shared) == 100615716067,
                'Handover byte arithmetic differs')
        record(before['new_locks_acquired'])
        record(before['prior_acquired'])
        record(before['prior_pointer'])
        record(before['prior_plan'])
        runtime = read(RUN + 'RUNTIME.json')
        require(isinstance(runtime, dict) and len(reports) == descriptor['resource_reports'] == 3700,
                'Runtime/resource record inventory differs')
        available = [r['physical_memory']['available'] for r in reports
                     if isinstance(r.get('physical_memory', {}).get('available'), int)]
        swap_known = [r['physical_memory']['swap_used'] for r in reports
                      if isinstance(r.get('physical_memory', {}).get('swap_used'), int)]
    return dict(status='PASS_V2_SAVED_RECORD_AND_CUSTODY_AUDIT',
        frames=result['frames'], rows=result['rows'], bucket_close_events=len(closed),
        all_recorded_close_exactCoverage_flags_true=True,
        historical_production_gated_exactCoverage=False,
        root_preflight_records=1, root_preflight_accepts_game_rows=False,
        resource_reports=len(reports), physical_memory_samples=len(available),
        minimum_available_physical_bytes=min(available) if available else None,
        known_swap_samples=len(swap_known), maximum_known_swap_bytes=max(swap_known) if swap_known else None,
        reused_input_files=11271, reused_input_bytes=100615716067,
        newly_hashed_invocation_bytes=118103, privacy_members_checked=privacy_members,
        declared_cross_layer_references=result['cross_layer_target_references'],
        cross_layer_reads_independently_hashed=False,
        transformed_archive_members=descriptor['transformed_files'],
        scope='Offline saved-record audit only. Custody and runtime assertions are recorded evidence, not independent OS verification, full-input rehash, native execution or an opening kernel proof.')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--archive', type=Path, required=True)
    parser.add_argument('--output', type=Path)
    args = parser.parse_args()
    result = audit(args.archive)
    text = json.dumps(result, indent=2) + '\n'
    if args.output:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_bytes(text.encode('utf-8'))
    print(text, end='')


if __name__ == '__main__':
    try:
        main()
    except (OSError, ValueError, KeyError, zipfile.BadZipFile) as error:
        print(str(error), file=sys.stderr)
        raise SystemExit(1)
