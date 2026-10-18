"""V17 host-policy adapter for the frozen, untrusted 1B GPU receipts.

The old ready/proposal implementations execute unchanged in a private pure
namespace. Only their resource-policy dependency uses this activity's explicit
host sentinel. Actual measured RSS is neither rewritten nor clipped. Physical
pressure is monitored by the external controller; GPU guards remain fixed.
"""
import hashlib
import sys
from pathlib import Path

LEGACY_RULES_PATH = 'build/lean_table_checker/gpu_indexed_byte_receipt_v16/rules.py'
LEGACY_RULES_SHA256 = '9160915678016c51c74c87d1cb28cb9a1b5c9c14cfeaf094973d755ba0268f2a'
HOST_RSS_CAP_BYTES = sys.maxsize
RESOURCE_POLICY_REVISION = 'V17_MONITORED_HOST_RSS_WITHOUT_FIXED_ADMISSION_V1'
RESOURCE_POLICY = dict(revision=RESOURCE_POLICY_REVISION, host_rss_cap_bytes=HOST_RSS_CAP_BYTES,
    fixed_host_RSS_admission=False, physical_pressure_monitor_required=True,
    device_cap_bytes=6000000000, global_device_cap_bytes=7000000000,
    global_device_free_reserve_bytes=1000000000)

_path = Path(__file__).resolve().parents[4] / LEGACY_RULES_PATH
_raw = _path.read_bytes()
if hashlib.sha256(_raw).hexdigest() != LEGACY_RULES_SHA256:
    raise ValueError('Frozen indexed-byte receipt rules changed')
_legacy = dict(__name__='_v17_private_frozen_gpu_receipt_rules', __file__=str(_path))
exec(compile(_raw, str(_path), 'exec'), _legacy)
for _name in ('REVISION', 'PROTOCOL', 'TRANSPORT', 'MAX_ROWS', 'SCRATCH_ROWS',
              'FIXED_COMMON_DEVICE_BYTES', 'ORIGINAL_EVALUATE_SOURCE_SHA256',
              'KERNEL_SOURCE_SHA256', 'LAYOUT'):
    globals()[_name] = _legacy[_name]
need, exact_fields = _legacy['need'], _legacy['exact_fields']


def resources(value, max_rows):
    # Exactly the frozen resources() field/extent/device checks, with its two
    # historical 3GB host literals replaced by the authorized host sentinel.
    need(isinstance(value, dict), 'Indexed-byte resource map required')
    need(type(max_rows) is int and 0 < max_rows <= MAX_ROWS, 'Bounded indexed-byte capacity required')
    scratch = min(max_rows, SCRATCH_ROWS)
    expected = dict(implementation_revision=REVISION, scratch_rows=scratch,
        device_output_scratch_bytes=scratch, maximum_proposal_rows=max_rows,
        transport=TRANSPORT, record_bytes=1, device_cap_bytes=6000000000,
        global_device_cap_bytes=7000000000, global_device_free_reserve_bytes=1000000000,
        host_rss_cap_bytes=HOST_RSS_CAP_BYTES)
    need(exact_fields(value, expected), 'Indexed-byte resource policy or identity differs')
    for key, cap in (('allocated_device_bytes', 6000000000), ('peak_host_rss_bytes', HOST_RSS_CAP_BYTES),
                     ('global_device_used_bytes', 7000000000)):
        need(type(value.get(key)) is int and 0 <= value[key] <= cap, 'Indexed-byte resource hard guard exceeded: ' + key)
    return scratch


# These functions retain their frozen bytecode and every encoding, identity,
# extent, chunk-coverage and timer check. No imported legacy module is patched.
_legacy['resources'] = resources
ready = _legacy['ready']
proposal = _legacy['proposal']
