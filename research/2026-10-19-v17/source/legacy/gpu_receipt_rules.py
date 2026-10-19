"""Pure1B proposal provenance rules. Never accept GPU bytes as Lean evidence."""
import math

REVISION = 'INDEXED_ACTUAL_NEXT_BYTE_BOUNDED_8MI_SCRATCH_V16'
PROTOCOL = 'GPU_CROSS_BUCKET_INDEXED_BYTE_PROTOCOL_V16'
TRANSPORT = 'indexed_actual_next_byte_v16'
MAX_ROWS = 67108864
SCRATCH_ROWS = 8388608
FIXED_COMMON_DEVICE_BYTES = 7387104
ORIGINAL_EVALUATE_SOURCE_SHA256 = '060508cfb0ffa8898d0e409e2d442e724ccf4408b81433056c9c37ed280cf566'
KERNEL_SOURCE_SHA256 = 'db89a6ad84b9ec0ad4f89c72a35f4c953ab35715520f4ce2f10080e0302ab609'
LAYOUT = dict(record_bytes=1, P_exact=128, N_less_than=128, N_axis_divisor=32,
              N_actual_next_list_index_modulus=32, error=255,
              source_coordinates_transmitted=False)


def need(value, message):
    if not value:
        raise ValueError(message)


def seconds(value):
    need(type(value) in (int, float) and math.isfinite(value) and value >= 0,
         'Invalid indexed-byte measured timer')
    return float(value)


def exact_fields(value, expected):
    return all(k in value and type(value[k]) is type(v) and value[k] == v
               for k, v in expected.items())


def resources(value, max_rows):
    need(isinstance(value, dict), 'Indexed-byte resource map required')
    need(type(max_rows) is int and 0 < max_rows <= MAX_ROWS, 'Bounded indexed-byte capacity required')
    scratch = min(max_rows, SCRATCH_ROWS)
    expected = dict(implementation_revision=REVISION, scratch_rows=scratch,
        device_output_scratch_bytes=scratch, maximum_proposal_rows=max_rows,
        transport=TRANSPORT, record_bytes=1, device_cap_bytes=6000000000,
        global_device_cap_bytes=7000000000, global_device_free_reserve_bytes=1000000000,
        host_rss_cap_bytes=3000000000)
    need(exact_fields(value, expected), 'Indexed-byte resource policy or identity differs')
    for key, cap in (('allocated_device_bytes', 6000000000), ('peak_host_rss_bytes', 3000000000),
                     ('global_device_used_bytes', 7000000000)):
        need(type(value.get(key)) is int and 0 <= value[key] <= cap, 'Indexed-byte resource hard guard exceeded: ' + key)
    return scratch


def ready(value, max_rows):
    need(isinstance(value, dict) and value.get('event') == 'SESSION_READY' and
         value.get('schema') == PROTOCOL and value.get('max_count') == max_rows,
         'Wrong indexed-byte GPU SESSION_READY')
    scratch = resources(value['resources'], max_rows)
    for key, expected in dict(implementation_revision=REVISION, transport=TRANSPORT, record_bytes=1,
                              scratch_rows=scratch, device_output_scratch_bytes=scratch).items():
        need(type(value.get(key)) is type(expected) and value[key] == expected, 'Wrong indexed-byte READY: ' + key)
    fixed = value.get('fixed_identity')
    need(isinstance(fixed, dict), 'Actual fixed CUDA identity required')
    expected = dict(schema='UNTRUSTED_FIXED_INDEXED_BYTE_CUDA_CONTEXT_V16',
        implementation_revision=REVISION, scratch_rows=scratch, device_output_scratch_bytes=scratch,
        maximum_host_proposal_bytes=max_rows, max_count=max_rows, record_bytes=1,
        transport=TRANSPORT, fixed_device_bytes=FIXED_COMMON_DEVICE_BYTES+scratch,
        indexed_byte_layout=LAYOUT, original_evaluate_source_sha256=ORIGINAL_EVALUATE_SOURCE_SHA256,
        combined_source_sha256=KERNEL_SOURCE_SHA256)
    need(exact_fields(fixed, expected), 'Fixed indexed-byte kernel/layout identity differs')
    need(exact_fields(fixed['indexed_byte_layout'], LAYOUT) and
         set(fixed['indexed_byte_layout']) == set(LAYOUT), 'Indexed-byte layout scalar types differ')
    need(value['resources']['allocated_device_bytes'] == FIXED_COMMON_DEVICE_BYTES+scratch,
         'Initial READY includes unreported or missing fixed device allocations')
    need(value.get('Lean_rows_verified') == 0, 'Untrusted GPU cannot claim Lean verification')
    return dict(implementation_revision=REVISION, record_bytes=1, scratch_rows=scratch,
        device_output_scratch_bytes=scratch, maximum_host_proposal_bytes=max_rows,
        original_evaluate_source_sha256=ORIGINAL_EVALUATE_SOURCE_SHA256,
        new_combined_kernel_source_sha256=KERNEL_SOURCE_SHA256,
        fresh_Native_profile_required=True, GPU_trusted_for_soundness=False)


def proposal(value, start, count, max_rows):
    need(type(start) is int and start >= 0 and type(count) is int and
         0 < count <= max_rows <= MAX_ROWS and start+count <= 2**64,
         'Invalid indexed-byte exact requested extent')
    need(isinstance(value, dict), 'Indexed-byte proposal map required')
    scratch = resources(value['resources'], max_rows)
    expected = dict(schema='UNTRUSTED_CROSS_BUCKET_INDEXED_BYTE_PROPOSAL_V16',
        status='STREAMED_NOT_LEAN_CERTIFIED', implementation_revision=REVISION,
        start=start, count=count, scratch_rows=scratch, device_output_scratch_bytes=scratch,
        compact_bytes=count, indexed_bytes=count, record_bytes=1, transport=TRANSPORT, mode=1,
        source_coordinates_transmitted=False, native_actual_next_membership_required=True,
        native_actual_source_r_guard_required=True, gpu_flags_trusted=False,
        per_row_timing_or_sampling_added=False, GPU_trusted_for_soundness=False, Lean_rows_verified=0)
    need(exact_fields(value, expected), 'Wrong indexed-byte proposal or encoding boundary')
    chunks = value.get('chunks')
    need(isinstance(chunks, list) and type(value.get('actual_chunk_count')) is int and
         len(chunks) == value.get('actual_chunk_count') ==
         (count+scratch-1)//scratch, 'Indexed-byte launches do not cover the complete frame')
    offset, kernels, copies = 0, [], []
    for chunk in chunks:
        take = min(scratch, count-offset)
        need(isinstance(chunk, dict) and exact_fields(chunk, dict(start=start+offset,
             count=take, host_row_offset=offset, host_byte_offset=offset,
             compact_bytes=take, indexed_bytes=take)), 'Indexed-byte chunks overlap, skip or escape host bytes')
        kernels.append(seconds(chunk['kernel_seconds']))
        copies.append(seconds(chunk['copy_seconds']))
        envelope = seconds(chunk['enclosing_chunk_wall_seconds'])
        need(envelope+1e-6 >= kernels[-1] and envelope+1e-6 >= copies[-1],
             'Indexed-byte chunk timer exceeds its actual enclosing wall')
        offset += take
    need(offset == count, 'Indexed-byte launches omit rows')
    need(math.isclose(seconds(value['combined_kernel_seconds']), sum(kernels), rel_tol=1e-10, abs_tol=1e-9)
         and math.isclose(seconds(value['copy_seconds']), sum(copies), rel_tol=1e-10, abs_tol=1e-9),
         'Indexed-byte per-chunk timer totals differ')
    need(value.get('copy_timing_policy') == 'SUM_CHUNK_DTOH_AND_GUARD_WALL_HOST_ALLOCATION_SEPARATE'
         and value.get('host_output_buffer_allocations') == 1 and value.get('intermediate_chunk_host_buffers') == 0,
         'Indexed-byte producer uses an unregistered host lifecycle')
    whole = seconds(value['proposal_work_seconds'])
    need(whole+1e-6 >= seconds(value['host_allocation_seconds']) and whole+1e-6 >= sum(copies),
         'Indexed-byte envelope hides actual allocation/copy work')
    return dict(implementation_revision=REVISION, transport=TRANSPORT, record_bytes=1,
        count=count, indexed_bytes=count, actual_chunk_count=len(chunks),
        device_scratch_bytes=scratch, all_consecutive_host_offsets_verified=True,
        host_output_buffer_allocations=1, GPU_trusted_for_soundness=False,
        Lean_rows_verified_here=0, native_actual_next_membership_and_source_r_still_required=True)
