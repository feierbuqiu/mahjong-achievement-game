#!/usr/bin/env python3
"""Check frozen paper identities, corrected status and v2 publication provenance."""
import hashlib
import json
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[1]
BASE = ROOT / 'research/2026-10-19-v2'


def read(path):
    return json.loads(path.read_text(encoding='utf-8-sig'))


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def require(condition, message):
    if not condition:
        raise ValueError(message)


def verify():
    freeze = read(ROOT / 'papers/FREEZE.json')
    require(freeze['release'] == 'v2.0.0' and len(freeze['papers']) == 3,
            'Frozen paper inventory differs')
    for item in freeze['papers'] + freeze['associated_audit_memos']:
        path = (ROOT / item['path']).resolve()
        require(path.is_relative_to(ROOT) and path.stat().st_size == item['bytes'] and
                sha(path) == item['sha256'], 'Frozen paper/memo changed: ' + item['path'])
    require(all(not item['scientific_text_changed'] and
                item['scientific_body_sha256'] == item['sha256'] for item in freeze['papers']),
            'Paper scientific-body identity differs')
    current = read(ROOT / 'RESEARCH_STATUS.json')
    require(current['current_work_frozen'] and current['paper']['frozen'] and
            current['release']['tag'] == 'v2.0.0', 'Release/freeze status differs')
    native = current['native_verification']
    require(native['rows'] == 778532864302 and
            native['actual_full_input_acceptance'] == 'COMPLETE_NATIVE_COMPONENT_COVERAGE_WITH_EXTERNAL_ASSEMBLY_AND_CUSTODY' and
            native['whole_input_native_Boolean_premises_all_evaluated_over_one_Candidate'] is False and
            'six_acceptance_families_complete' not in native and
            native['whole_input_typed_finishWhole_executed'] is False and
            native['bucket_exactCoverage_gated_in_historical_production'] is False and
            native['cross_layer_independent_native_read_identity_check'] is False and
            native['recorded_true_bucket_close_events'] == 3686,
            'Corrected execution boundary differs')
    require(current['formal_verification']['empty_game_lean'] == 'NOT_VERIFIED' and
            not current['formal_verification']['end_to_end_Lean_theorem_published'],
            'Snapshot must not imply a closed opening proof')
    history = read(BASE / 'evidence/historical-kernel-status.json')
    restored = current['historical_progress']['2026-10-18-kernel']
    canonical = json.dumps(restored, sort_keys=True, separators=(',', ':')).encode()
    require(restored == history['value'] and
            hashlib.sha256(canonical).hexdigest() == history['canonical_sha256'] and
            history['source_commit'] == 'c7a0833511f03b1ccc7f59b0f5dd7a677f6e9fe2' and
            restored['latest_progress_source_modules'] == 165,
            'Historical kernel status differs from the restored dated object')
    dependencies = read(BASE / 'dependencies.json')['artifacts']
    require(len(dependencies) == 4, 'Additional trust-source inventory differs')
    for item in dependencies:
        path = (ROOT / item['published_path']).resolve()
        require(path.is_relative_to(ROOT) and sha(path) == item['published_sha256'] and
                path.stat().st_size == item['published_bytes'], 'Trust-source publication changed')
        if not item['transformations']:
            require(item['original_sha256'] == item['published_sha256'],
                    'Unrecorded trust-source transformation')
    assets = read(BASE / 'assets.json')
    descriptor = assets['assets'][0]
    require(assets['release_tag'] == 'v2.0.0' and not assets['full_input_dataset_included'] and
            descriptor['payload_files'] == 46202 and descriptor['added_payload_files'] == 7873 and
            descriptor['bucket_closed_records'] == 3686 and descriptor['resource_reports'] == 3700 and
            descriptor['transformed_files'] == 24,
            'Supplementary saved-record scope differs')
    audit = read(BASE / 'evidence/saved-record-audit.json')
    require(audit['status'] == 'PASS_V2_SAVED_RECORD_AND_CUSTODY_AUDIT' and
            audit['bucket_close_events'] == 3686 and audit['all_recorded_close_exactCoverage_flags_true'] and
            audit['historical_production_gated_exactCoverage'] is False and
            audit['cross_layer_reads_independently_hashed'] is False and
            audit['root_preflight_accepts_game_rows'] is False and
            audit['privacy_members_checked'] == descriptor['payload_files'] + 1,
            'Recorded v2 offline audit differs')
    review = read(BASE / 'review-provenance.json')
    require(sha(ROOT / review['published_path']) == review['published_sha256'] and
            review['same_declared_model_as_previous_review'] and not review['human_peer_review'] and
            not review['independent_execution_replication'], 'Supplied AI review scope differs')
    privacy = read(BASE / 'evidence/privacy-transformation.json')
    require(sha(ROOT / privacy['path']) == privacy['published_sha256'] and
            privacy['identifying_paths_redacted'] == 8 and
            not privacy['historical_commits_and_releases_rewritten'],
            'Privacy-correction identity differs')
    return dict(status='PASS_FROZEN_V2_PUBLICATION', papers=3,
        frozen_audit_memos=len(freeze['associated_audit_memos']), additional_trust_sources=4,
        recorded_close_events=3686, evidence_archive_payload_files=46202,
        historical_status_restored=True, actual_opening_kernel_proof=False,
        scope='Snapshot identities and recorded boundaries; no new research or independent execution')


if __name__ == '__main__':
    try:
        print(json.dumps(verify()))
    except (OSError, ValueError, KeyError) as error:
        print(str(error), file=sys.stderr)
        raise SystemExit(1)
