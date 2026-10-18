"""Synthetic V14 lifecycle controls; no service, table, GPU or Native work."""
from pathlib import Path
import ast
import copy
import hashlib
import json
import time
import types

ROOT=Path(__file__).resolve().parents[3]
BASE=Path(__file__).resolve().parent
MARKER='PROVED_BORROWED_NEXT_GLOBAL_NEXT_GENERATED_PLAN_V12'
SCHEDULE='PROVED_CONTIGUOUS_PARTITION_STRIDED_FIXED_ROUNDS_V13'


def main():
    source=BASE/'span_policy.py';raw=source.read_bytes();tree=ast.parse(raw.decode())
    tree.body=[n for n in tree.body if not isinstance(n,(ast.Import,ast.ImportFrom))]
    env=dict(gate=types.SimpleNamespace(IO_POLICY=dict(native_max_frames_per_epoch=16,pipe_capacity_bytes=1048576),MARKER=MARKER))
    exec(compile(ast.fix_missing_locations(tree),str(source),'exec'),env)
    Tracker=env['EpochTracker'];controls=[]
    def good(name):controls.append(dict(name=name,status='PASS_SYNTHETIC_ONLY'))
    def reject(name,fn):
        try:fn()
        except ValueError as e:controls.append(dict(name=name,status='PASS_REJECTED',error=repr(e)))
        else:raise AssertionError(name)
    def frame(index,origin=0):
        epoch=origin+1+index//16;local=index%16;count=100;start=index*count
        return dict(schema='FUSED_LINUX_INDEXED_BYTE_LEAN_BRIDGE_V16',event='SPAN_DONE',start=start,count=count,
            native_lifecycle=dict(native_io_policy=dict(env['gate'].IO_POLICY),
                stdin_pipe_capacity=dict(requested_capacity_bytes=1048576,set_return_capacity_bytes=1048576,
                    actual_capacity_bytes=1048576,configured_by_uid=1000,capacity_get_confirmed=True),
                RSS_before_bytes=1000000000,native_epochs=epoch,rotated=index>0 and local==0,
                total_seconds=1. if index>0 and local==0 else 0.),
            native_event=dict(schema='INDEXED_BYTE_LARGE_FRAME_RESIDENT_PROTOCOL_V16',event='SPAN_DONE',start=start,count=count,completed_spans=local+1),
            worker=dict(plan_checker_kind=MARKER,actual_successors_all_checked=True,reference_rows=64 if local==0 else 0,
                row_schedule_kind=SCHEDULE,row_rounds=1,row_partition_checked=True,row_partition_chunks=12,
                indexed_byte_mode=True,compact_word_mode=False,gpu_source_packet_mode=False,gpu_witness_mode=True,
                pure_checker_theorem_fingerprints=104,source_r_guard_every_row=True,source_block_cover_checked=True,
                row_checker_kind='PROVED_INDEXED_NEXT_BYTE_SCALAR_SCAN_V16',
                plan_constructor_kind='PROVED_ONCE_CHECKED_TEMPLATE_CONSTRUCTOR_V16',
                small_plan_serial_template_threshold=4096,compact_bytes=count,
                frame_full_templates_without_reuse=100,plan_blocks=2,plan_prepare_workers=1))
    def accept(t,f):t.accept(f,f['start'],f['count'])
    t=Tracker()
    for i in range(17):accept(t,frame(i))
    assert t.completed_counts()==[16,1] and t.frames==17 and t.rows==1700
    good('actual17th_frame_requires_new_epoch_and_reference_repeats')
    fresh=Tracker(7);accept(fresh,frame(0,7));assert fresh.current==8;good('new_bucket_global_epoch_origin_preserved')
    for name,change in (
        ('old128policy',lambda f:f['native_lifecycle']['native_io_policy'].update(native_max_frames_per_epoch=128)),
        ('oldwire',lambda f:f.update(schema='FUSED_LINUX_COMPACT_LEAN_BRIDGE_V8_PIPE128_TIMING')),
        ('wrongpipe',lambda f:f['native_lifecycle']['stdin_pipe_capacity'].update(actual_capacity_bytes=65536)),
        ('old82schedule',lambda f:f['worker'].pop('row_schedule_kind')),
        ('unselected_round4',lambda f:f['worker'].update(row_rounds=4)),
        ('unchecked_partition',lambda f:f['worker'].update(row_partition_checked=False)),
        ('missing_full_actual_successors',lambda f:f['worker'].update(actual_successors_all_checked=False)),
        ('invented_first_rotation',lambda f:f['native_lifecycle'].update(rotated=True)),
        ('wrong_first_epoch',lambda f:f['native_lifecycle'].update(native_epochs=3)),
        ('unobserved_RSS',lambda f:f['native_lifecycle'].update(RSS_before_bytes=0)),
        ('excess_RSS',lambda f:f['native_lifecycle'].update(RSS_before_bytes=11250000000)),
        ('missing_reference',lambda f:f['worker'].update(reference_rows=0))):
        f=frame(0);change(f);reject(name,lambda:accept(Tracker(),f))
    t=Tracker()
    for i in range(16):accept(t,frame(i))
    f=frame(16);f['native_lifecycle'].update(rotated=False,native_epochs=1,total_seconds=0.)
    reject('17th_without_rotation',lambda:accept(t,f))
    t=Tracker();accept(t,frame(0));f=frame(1);f['worker']['reference_rows']=64
    reject('nonfirst_reference_cannot_reclassify_phase_cost',lambda:accept(t,f))
    t=Tracker();accept(t,frame(0));f=frame(1);f['native_lifecycle'].update(rotated=True,native_epochs=2,total_seconds=1.)
    reject('unexplained_early_rotation',lambda:accept(t,f))
    t=Tracker();accept(t,frame(0));f=frame(1)
    f['native_lifecycle'].update(RSS_before_bytes=9000000000,rotated=True,native_epochs=2,total_seconds=1.)
    f['native_event']['completed_spans']=1;f['worker']['reference_rows']=64;accept(t,f)
    assert t.completed_counts()==[1,1];good('actual_RSS_early_rotation_retained')
    for bad in (0,17,True):reject('invalid_cost_floor_'+str(bad),lambda b=bad:Tracker().set_cost_floor(b))
    for n,accepted in ((5,False),(6,True)):
        t=Tracker();t.set_cost_floor(6)
        for i in range(n):accept(t,frame(i))
        f=frame(n);f['native_lifecycle'].update(RSS_before_bytes=9000000000,rotated=True,native_epochs=2,total_seconds=1.)
        f['native_event']['completed_spans']=1;f['worker']['reference_rows']=64
        if accepted:
            accept(t,f);assert t.completed_counts()==[6,1];good('exact_charged_floor_resource_rotation_accepted')
        else:
            reject('shorter_than_charged_epoch_pauses_before_tracker_advance',lambda:accept(t,f))
            assert t.completed_counts()==[5] and t.frames==5
    t=Tracker();accept(t,frame(0));reject('active_epoch_floor_cannot_change',lambda:t.set_cost_floor(6))
    files={'source.bits':dict(bytes=64*1024**2-8),'source.dir':dict(bytes=32),
        'unrelated.bin':dict(bytes=1000000000000)}
    assert env['bank_class_from_locked_files'](files)=='1';good('actual_directory_bytes_can_move_bank_to_next_class')
    reject('bank_without_actual_bits_or_directories',lambda:env['bank_class_from_locked_files']({'data.bin':dict(bytes=1)}))
    reject('unmeasured_bank_size',lambda:env['bank_class_from_locked_files']({'source.bits':dict(bytes=6000000008)}))
    basis=dict(minimum_validated_full_epoch_frames_by_bank_class={'0':10,'1':16,'2':16,'3':7})
    rec=dict(path='runs/lean_table_checker/synthetic_resource_only.json',bytes=1,sha256='0'*64)
    env['gate'].record=lambda value:None  # Evidence identity is covered by the separate gate controls.
    policy=env['cost_floor_policy'](rec,basis)
    assert policy['minimum_complete_epoch_frames_by_bank_class']=={'0':9,'1':15,'2':15,'3':6} and policy['resource_acceptance']==rec
    assert basis['minimum_validated_full_epoch_frames_by_bank_class']['3']==7
    good('cost_floor_charges_one_extra_frame_of_margin_without_mutating_observations')
    reject('cost_floor_missing_class',lambda:env['cost_floor_policy'](rec,dict(minimum_validated_full_epoch_frames_by_bank_class={'3':7})))
    report=dict(schema='V16_INDEXED_CONTROLLER_EPOCH_SYNTHETIC_CONTROLS',status='PASS_SOURCE_ONLY_SYNTHETIC',controls=controls,
        source=dict(path=source.relative_to(ROOT).as_posix(),bytes=len(raw),sha256=hashlib.sha256(raw).hexdigest()),
        test=dict(path=Path(__file__).relative_to(ROOT).as_posix(),sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest()),
        new_Native_GPU_Lean_rows=0,full_launch_allowed=False)
    out=ROOT/'runs/lean_table_checker/campaign_indexed_20261018_v16/pure_controls'
    out.mkdir(parents=True,exist_ok=True);p=out/f'epoch_{time.time_ns()}.json'
    with p.open('x',encoding='utf-8') as stream:json.dump(report,stream,indent=2);stream.write('\n')
    print(json.dumps(dict(receipt=p.relative_to(ROOT).as_posix(),controls=len(controls),full_launch_allowed=False)))


if __name__=='__main__':main()
