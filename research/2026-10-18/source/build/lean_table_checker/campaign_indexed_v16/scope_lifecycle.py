"""Bound cache receipt accumulation at complete bucket boundaries only."""
import campaign_io as c

def policy(frames=4096,buckets=128):
    value=dict(schema="BUCKET_BOUNDARY_FUSED_SCOPE_ROTATION_V7",max_completed_frames_before_next_bucket=frames,
        max_completed_buckets_before_next_bucket=buckets,maximum_single_bucket_frames=1470,
        rotation_inside_bucket=False,normal_native_STOP_EOF_cache_release_and_kernel_empty_required=True,
        parent_input_snapshot_and_locks_survive_scope_rotation=True)
    validate(value);return value

def validate(value):
    exact=dict(schema="BUCKET_BOUNDARY_FUSED_SCOPE_ROTATION_V7",maximum_single_bucket_frames=1470,
        rotation_inside_bucket=False,normal_native_STOP_EOF_cache_release_and_kernel_empty_required=True,
        parent_input_snapshot_and_locks_survive_scope_rotation=True)
    if any(value.get(k)!=v for k,v in exact.items()):raise ValueError("Unknown fused scope lifecycle")
    for key,cap in (("max_completed_frames_before_next_bucket",4096),("max_completed_buckets_before_next_bucket",128)):
        if type(value.get(key)) is not int or not 1<=value[key]<=cap:raise ValueError("Unbounded fused scope event accumulation")
    return value

def needs_rotation(frames,buckets,value):
    validate(value)
    return frames>=value["max_completed_frames_before_next_bucket"] or buckets>=value["max_completed_buckets_before_next_bucket"]

def estimated_scopes(frame_counts,value):
    """Exact lifecycle count for a whole-bucket ordered production schedule."""
    validate(value);scopes=frames=buckets=0
    for count in frame_counts:
        if type(count) is not int or not 0<count<=value["maximum_single_bucket_frames"]:raise ValueError("Bucket schedule exceeds the bounded event policy")
        if buckets==0:scopes+=1
        frames+=count;buckets+=1
        if needs_rotation(frames,buckets,value):frames=buckets=0
    return scopes

def after_bucket(rt,m):
    context=rt.cross_gpu
    if context is None:return None
    value=m["scope_lifecycle_policy"]
    if not needs_rotation(context.frames,context.buckets,value):return None
    if context.active is not None:raise ValueError("Refuse whole-scope rotation before exact bucket leave")
    context.close(abort=False)
    if not context.exit_confirmed:raise RuntimeError("No kernel-empty confirmation for completed scope rotation")
    record=dict(schema="CONFIRMED_BUCKET_BOUNDARY_FUSED_SCOPE_ROTATION_V7",scope=context.client.name,
        policy=value,completed_frames=context.frames,completed_buckets=context.buckets,
        all_owned_services_confirmed_exited=True,parent_semantic_input_snapshot_retained=True,
        extra_CUDA_context_initialization_must_be_in_weighted_cost_readiness=True)
    c.atomic(context.base.with_suffix(".rotation.json"),record)
    rt.cross_gpu=None
    return record
