"""Registered V14 large-frame accounting: entire epoch-first plan phase as an event fee.

This does not identify a thread-pool cause. The observed first Native event is
defined by exact epoch lifecycles and reference_rows, including after restart.
Every global template is charged again at the maximum measured steady phase/T.
All zero-T steady and unknown wall stays per frame. This is arithmetic only:
fresh raw evidence, production fees, finite premises and a separate authority
remain mandatory. This module can never grant a production launch.
"""
import collections,math

BACKEND='linux_fused_large_frames_generated_native_cache_v14'
MARKER='PROVED_BORROWED_NEXT_GLOBAL_NEXT_GENERATED_PLAN_V12'
PROFILE='OVERNIGHT_V14_LARGE_FRAME_REGISTERED_CALIBRATION_PROFILE'
CONTRACT='ENTIRE_NATIVE_EPOCH_FIRST_PLAN_PLUS_ALL_STEADY_T_V14'
FRAME_ROOT_FIELDS=('root_RPC_wall_seconds','root_result_JSON_read_seconds',
    'root_finite_work_and_timer_validation_seconds','root_native_packed_file_read_seconds',
    'root_original_source_bitspan_read_extract_seconds','root_complete_packed_bytes_compare_seconds',
    'root_packed_popcount_and_PN_seconds','root_reply_atomic_save_seconds',
    'root_native_result_and_packed_fsync_seconds','root_evidence_binding_hash_seconds',
    'root_prefix_atomic_ledger_seconds','root_timing_receipt_save_and_hash_seconds')

def require(value,message):
    if not value:raise ValueError(message)
def seconds(value):
    require(type(value) in (int,float) and math.isfinite(value) and value>=0,'Invalid nonnegative measured wall time')
    return float(value)
def bankclass(size):
    return next(i for i,cap in enumerate((64*1024**2,512*1024**2,2*1024**3,6_000_000_000)) if size<=cap)
def validate_profile(profile):
    require(profile.get('schema')==PROFILE and profile.get('backend')==BACKEND,'Wrong fresh registered V13 epoch-phase profile')
    require(profile.get('accounting_contract')==CONTRACT and profile.get('fresh_registered_calibration') is True,
        'A fresh explicitly registered V13 profile is required; old V12 observations are posthoc only')
    total=profile.get('kernel_proof_counts',{}).get('total')
    require(profile.get('Lean_version')=='4.33.1' and type(total) is int and total>=88 and
        profile.get('pure_theorem_fingerprints')==total,
        'The external bound actual kernel bundle must supply its exact borrowed-next proof inventory')
    require(profile.get('native_checker_kind')==MARKER,'Wrong actual borrowed-next generated checker marker')
    require(profile.get('threads')==12 and profile.get('heavy_jobs')==1,'A single selected8/12/16-thread profile is required')
    require(profile.get('native_max_frames_per_epoch')==16 and
        profile.get('max_frames_per_native_epoch')==16 and
        profile.get('native_recycle_RSS_bytes')==9_000_000_000,'Use actual16-frame/9GB RSS policy')
    require(profile.get('row_schedule_kind')=='PROVED_CONTIGUOUS_PARTITION_STRIDED_FIXED_ROUNDS_V13' and
        profile.get('row_rounds')==1,'Use the actually selected one-round partition')
    require(profile.get('frame_policy')==dict(max_rows=67108864,max_source_blocks=8192,
        max_full_templates=profile.get('selected_template_cap'),raw_plan_rows_diagnostic_only=True,
        raw_plan_edges_diagnostic_only=True,full_first_and_last_block_costs=True,
        all_SAFE_and_unsafe_target_keys=True) and profile.get('selected_template_cap') in (250000,500000),
        'The fresh complete-template frame policy must be explicit')
    require(profile.get('native_stdin_pipe_capacity_bytes')==1_048_576 and
        profile.get('bridge_payload_write_chunk_bytes')==4_194_304,
        'Actual1MiB native stdin pipe capacity and4MiB bridge writes must both be explicit')
    require(profile.get('hard_cumulative_seconds')==72000,'The hard20-hour cumulative envelope changed')
    require(profile.get('checker_semantics')==dict(actual_source_row_guard=True,P_all_actual_successors=True,
        N_actual_successor_member=True,GPU_trusted=False),'Actual source/full-P/actual-N obligations changed')
    limits=profile['resource_limits']
    require(all(type(limits[k]) is int for k in ('all_task_process_memory_max_bytes','Linux_memory_max_bytes',
        'Linux_swap_bytes','GPU_task_bytes','GPU_global_bytes','GPU_free_reserve_bytes','minimum_available_system_RAM_bytes')),
        'Resource limits must be exact byte integers')
    require(0<limits['all_task_process_memory_max_bytes']<=16_000_000_000 and
        0<limits['Linux_memory_max_bytes']<=14_250_000_000 and limits['Linux_swap_bytes']==0 and
        limits['GPU_task_bytes']<=6_000_000_000 and limits['GPU_global_bytes']<=7_000_000_000 and
        limits['GPU_free_reserve_bytes']>=1_000_000_000 and limits['minimum_available_system_RAM_bytes']>=3_000_000_000,
        'A resource safeguard was weakened')

def normalize_timed_case(raw):
    """Arithmetic only after external exact range/hash/IO/proof validation.

    `root_complete_frame_wall_seconds` is the caller's full RPC-through-packed
    comparison/fsync/prefix envelope. Child write/read/GPU timers overlap and
    are diagnostic only. Only explicit reference, restart, final leave and
    the actual first nonprefetched blocked fill move to their fixed event fees.
    """
    require(raw.get('backend')==BACKEND and raw.get('conditional_performance_only') is True and
        raw.get('TargetCorrect_registry_entries_added')==0,'Not a conditional fresh sparse timing case')
    require(raw.get('accounting_contract')==CONTRACT,'The registered epoch-first plan accounting contract is missing')
    frames=raw['frames'];require(bool(frames),'No actual timed frame')
    rows=plan_edges=raw_edges=0;plan=row=frame_wall=variable=reference_total=restart_total=0.
    reference_upper=0.;epoch_counts=collections.Counter();seen_epochs=set();restart_upper=0.;previous_epoch=None
    raw_templates=actual_templates=steady_templates=0;initial_fill=0.;observed_plan=zero_template_plan=0.;later_unprefetched=[]
    epoch_first_plan_total=epoch_first_plan_upper=0.;epoch_first_plan_events=[]
    steady_plan_phase_events=[];steady_plan_phase_T_upper=0.
    nested=collections.Counter()
    for frame_index,frame in enumerate(frames):
        worker=frame['worker'];timing=frame['root_frame_timings'];life=frame['native_lifecycle']
        require(worker.get('plan_checker_kind')==MARKER and worker.get('actual_successors_all_checked') is True,
            'Worker skipped the actual sparse/P/N checker')
        require(worker['checked_rows']==frame['count'] and worker['P_rows']+worker['N_rows']==frame['count'],
            'Actual frame row/PN totals mismatch')
        epoch=frame['native_epoch'];require(type(epoch) is int and epoch>=1,'Missing actual native epoch identity')
        if previous_epoch is None:require(life['rotated'] is False,'A fresh sampled bucket cannot begin by rotating an inherited epoch')
        elif epoch!=previous_epoch:require(epoch==previous_epoch+1 and life['rotated'] is True,'Missing/out-of-order actual epoch rotation')
        else:require(life['rotated'] is False,'Repeated epoch identity falsely claims a rotation')
        previous_epoch=epoch
        first=epoch not in seen_epochs;seen_epochs.add(epoch);epoch_counts[epoch]+=1
        expected_reference=min(frame['count'],64) if first else 0
        require(worker['reference_rows']==expected_reference,'Reference is once per actual native epoch, not once per calibration case')
        observed_p=seconds(worker['plan_phase_wall_ns'])/1e9;r=seconds(worker['row_scan_ns'])/1e9
        materialized=worker['plan_templates'];full_templates=frame['frame_templates']
        require(type(materialized) is int and type(full_templates) is int and 0<=materialized<=full_templates,
            'Actual/new and full template counts are invalid')
        require(frame['template_work']['actual_plan_templates']==materialized and
            frame['template_work']['templates']==full_templates and
            frame['template_work']['all_SAFE_and_unsafe_keys_counted'] is True,
            'Independent complete template work differs from native counters')
        # Entire first-phase wall is an epoch fee even at T=0.
        # Every nonfirst T=0 phase stays in the per-frame residual fee.
        first_plan=observed_p if first else 0.
        p=observed_p if not first and materialized else 0.
        observed_plan+=observed_p
        zero_template_plan+=observed_p if not first and not materialized else 0.
        epoch_first_plan_total+=first_plan;epoch_first_plan_upper=max(epoch_first_plan_upper,first_plan)
        if first:epoch_first_plan_events.append(dict(frame_index=frame_index,native_epoch=epoch,phase_seconds=first_plan,templates=materialized))
        steady_templates+=materialized if not first else 0
        if not first and materialized:
            per_T=observed_p/materialized;steady_plan_phase_T_upper=max(steady_plan_phase_T_upper,per_T)
            steady_plan_phase_events.append(dict(frame_index=frame_index,native_epoch=epoch,phase_seconds=observed_p,templates=materialized,seconds_per_T=per_T))
        raw_templates+=full_templates;actual_templates+=materialized
        transport=frame['transport_timing']
        prefetched=transport.get('payload_was_prefetched')
        require(type(prefetched) is bool,'Actual prefetch-state identity is missing')
        fill=seconds(transport['prefetch_wait_wall_seconds']) if frame_index==0 and not prefetched else 0.
        if frame_index and not prefetched:later_unprefetched.append(frame_index)
        initial_fill+=fill
        # Keep the tiny zero-reference timing overhead inside the frame fee.
        ref=seconds(worker['reference_ns'])/1e9 if first else 0.
        rest=seconds(life['total_seconds']);require(life['rotated'] or rest==0,'A nonrotation has restart time')
        wall=seconds(timing['root_complete_frame_wall_seconds'])
        phase_sum=sum(seconds(timing[name]) for name in FRAME_ROOT_FIELDS)
        require(phase_sum<=wall+1e-5,'Root exclusive phases exceed their complete wall envelope')
        residual=wall-p-first_plan-r-ref-rest-fill
        require(residual>=-1e-5,'Core/reference/restart costs exceed complete root frame wall')
        variable+=max(0.,residual);frame_wall+=wall;plan+=p;row+=r;reference_total+=ref
        reference_upper=max(reference_upper,ref);restart_total+=rest;restart_upper=max(restart_upper,rest)
        rows+=frame['count'];plan_edges+=worker['plan_edges'];raw_edges+=frame['plan_edges']
        for key in ('stream_payload_read_ns','save_ns'):nested[key]+=seconds(worker[key])/1e9
        proposal=frame['proposal']
        for key in ('proposal_work_seconds','combined_kernel_seconds','copy_seconds'):nested[key]+=seconds(proposal[key])
        transport=frame['transport_timing']
        require(transport.get('schema')=='FUSED_LINUX_FRAME_WALL_ENVELOPES_V14','Wrong nested transport timing schema')
        for key in ('prefetch_wait_wall_seconds','bridge_span_total_wall_seconds','native_span_total_wall_seconds',
                    'payload_write_wall_seconds','receive_response_wall_seconds'):nested[key]+=seconds(transport[key])
    whole=seconds(raw['bucket_total_seconds']);cold=seconds(raw['bucket_cold_seconds'])
    explicit_leave=raw.get('root_bucket_leave_wall_seconds')
    leave=seconds(explicit_leave) if explicit_leave is not None else 0.
    unclassified=whole-cold-frame_wall-leave
    require(unclassified>=-1e-5,'Cold/frames/explicit leave exceed the complete bucket envelope')
    # Unknown wall may be frame-related; it is conservatively charged per
    # frame, never guessed to be a one-off bucket fee.
    variable+=max(0.,unclassified)
    restart_upper=max(restart_upper,seconds(raw['initial_usable_native_READY_seconds'])+
        seconds(raw['final_native_shutdown_seconds']))
    return dict(case_id=raw['case_id'],layer=raw['layer'],honor=raw['honor'],rows=rows,frames=len(frames),
        profile_sha256=raw['profile_sha256'],worker_executable_sha256=raw['worker_executable_sha256'],
        raw_plan_templates=raw_templates,actual_materialized_plan_templates=actual_templates,steady_actual_materialized_plan_templates=steady_templates,
        epoch_first_plan_phase_total_seconds=epoch_first_plan_total,epoch_first_plan_phase_upper_seconds=epoch_first_plan_upper,
        epoch_first_plan_events=epoch_first_plan_events,accounting_contract=CONTRACT,
        steady_plan_phase_events=steady_plan_phase_events,steady_plan_phase_seconds_per_T_upper=steady_plan_phase_T_upper,
        observed_plan_phase_wall_seconds=observed_plan,zero_template_plan_wall_kept_per_frame=zero_template_plan,
        initial_nonprefetched_fill_seconds=initial_fill,later_nonprefetched_frame_indices=later_unprefetched,
        native_epochs=len(seen_epochs),epoch_frame_counts=dict(epoch_counts),plan_seconds=plan,row_seconds=row,
        plan_cost_denominator='steady_actual_materialized_plan_templates',old_E_counts_are_diagnostic_only=True,
        entire_first_plan_phase_charged_once_per_actual_Native_epoch=True,all_global_T_still_charged_at_steady_cap=True,
        conservative_noncore_frame_wall_seconds=variable,explicit_bucket_leave_seconds=leave,
        explicit_bucket_leave_measured=explicit_leave is not None,unclassified_bucket_wall_seconds=max(0.,unclassified),
        epoch_reference_total_seconds=reference_total,epoch_reference_upper_seconds=reference_upper,
        actual_intermediate_restart_total_seconds=restart_total,complete_native_restart_upper_seconds=restart_upper,
        cold_bucket_seconds=cold,whole_bucket_seconds=whole,raw_plan_edges=raw_edges,actual_materialized_plan_edges=plan_edges,
        observed_nested_or_overlapping_timers_NOT_ADDITIVE=dict(nested),
        exact_accounting_identity=dict(cold=cold,steady_core=plan+row,epoch_first_plan=epoch_first_plan_total,epoch_reference=reference_total,
            intermediate_restart=restart_total,initial_nonprefetched_fill=initial_fill,
            per_frame_including_unknown=variable,bucket_leave=leave,total=whole))

def stratum_key(bucket,threshold):
    n=bucket['layer']
    band=next(f'{lo:02}-{hi:02}' for lo,hi in ((0,16),(17,20),(21,24),(25,28),(29,31),(32,34)) if lo<=n<=hi)
    density='dense' if bucket['raw_plan_edges']/bucket['rows']>=threshold else 'sparse'
    return f'{band}|parity={n%2}|honor3={int(bucket["has_honor_triplet"])}|{density}'

def scope_count(counts,max_frames=4096,max_buckets=128):
    require(1<=max_frames<=4096 and 1<=max_buckets<=128,'Unbounded scope event policy')
    scopes=frames=buckets=0
    for count in counts:
        require(type(count) is int and 0<count<=1470,'A canonical whole bucket exceeds the actual bounded policy')
        if buckets==0:scopes+=1
        frames+=count;buckets+=1
        if frames>=max_frames or buckets>=max_buckets:frames=buckets=0
    return scopes

def compute_components(geometry,plan,observations,stability,production):
    """Conservative scenario, with actual epoch intervals and explicit fees.

    This is intentionally not a raw-evidence verifier or launch permission.
    Unknown/absent production-ledger costs and restart intervals reject.
    """
    cases={case['id']:case for case in plan['cases']}
    require(len(cases)==34 and len(observations)==34 and {o['case_id'] for o in observations}==set(cases),
        'All34 fresh same-profile observations are required')
    require(len({o['profile_sha256'] for o in observations})==len({o['worker_executable_sha256'] for o in observations})==1,
        'A timed matrix cannot mix profiles, thread counts or executable identities')
    pending=sorted((b for b in geometry['buckets'] if b['layer']<=31),key=lambda b:(-b['layer'],b['honor']))
    weights=collections.defaultdict(lambda:collections.Counter())
    by_stratum=collections.defaultdict(list);by_bank=collections.defaultdict(list)
    for b in pending:
        w=weights[stratum_key(b,plan['density_threshold'])]
        w['rows']+=b['rows'];w['frames']+=b['frame_count'];w['edges']+=b['raw_plan_edges'];w['buckets']+=1
        w['templates']+=b['raw_templates'];w['frame_templates']+=b['frame_templates_without_reuse']
    for s in plan['strata']:
        w=weights[s['key']]
        require(w['rows']==s['rows'] and w['edges']==s['raw_plan_edges'] and w['buckets']==s['buckets'] and
            w['templates']==s['raw_templates'] and w['frame_templates']==s['frame_templates_without_reuse'],
            'Actual stratified frame inventory differs from the selected frozen experiment')
    for o in observations:
        case=cases[o['case_id']]
        require((o['layer'],o['honor'])==(case['layer'],case['honor']) and o['rows']>0 and o['frames']>0,
            'Observation belongs to another case')
        require(case['minimum_completed_frames']<=o['frames']<=case['maximum_requested_frames'] and
            o['whole_bucket_seconds']<=case['hard_case_seconds'],'Case is underfilled or outside its selected hard envelope')
        if case.get('must_observe_native_recycle'):require(o['native_epochs']>=2,'Actual16-frame recycle was not observed')
        require(o['accounting_contract']==CONTRACT and o['raw_plan_templates']>=o['actual_materialized_plan_templates']>=o['steady_actual_materialized_plan_templates']>=0,
            'Actual registered epoch/steady all-key template work was undercharged')
        for key in case['covers_strata']:by_stratum[key].append(o)
        by_bank[bankclass(case['source_and_child_bank_bytes'])].append(o)
    require(set(by_stratum)==set(weights),'A stratum is missing')
    substantial=[o for o in observations if o['rows']>=1_000_000];require(bool(substantial),'No useful row sample')
    fallback=max(o['row_seconds']/o['rows'] for o in substantial)
    row_cost=frame_cost=0.;caps=[]
    for key,w in sorted(weights.items()):
        useful=[o for o in by_stratum[key] if o['rows']>=1_000_000]
        row_cap=max((o['row_seconds']/o['rows'] for o in useful),default=fallback)
        frame_cap=max(o['conservative_noncore_frame_wall_seconds']/o['frames'] for o in by_stratum[key])
        row_cost+=w['rows']*row_cap;frame_cost+=w['frames']*frame_cap
        caps.append(dict(stratum=key,rows=w['rows'],frames=w['frames'],row_ns=row_cap*1e9,noncore_seconds_per_frame=frame_cap))
    steady=[o for o in observations if o['steady_actual_materialized_plan_templates']]
    require(bool(steady),'A positive actual nonfirst template phase is mandatory')
    template_cap=max(o['steady_plan_phase_seconds_per_T_upper'] for o in steady)
    require(stability.get('profile_epoch_cap')==16,'Fresh16-frame stability is required for V14 costing')
    intervals=stability['minimum_validated_full_epoch_frames_by_bank_class']
    cold=leave=fill=reference=restart=first_plan=0.;epoch_count=0
    for b in pending:
        cls=bankclass(b['source_and_child_bank_bytes']);group=by_bank[cls];require(bool(group),'Actual bank class lacks an observation')
        interval=intervals[str(cls)]
        require(type(interval) is int and 1<=interval<=16,'Missing/invalid actual resource-driven epoch interval')
        epochs=math.ceil(b['frame_count']/interval);epoch_count+=epochs
        cold+=max(o['cold_bucket_seconds'] for o in group)
        leave+=max(o['explicit_bucket_leave_seconds'] for o in group)
        fill+=max(o['initial_nonprefetched_fill_seconds'] for o in group)
        reference+=max(o['epoch_reference_upper_seconds'] for o in group)*epochs
        first_plan_cap=max([o['epoch_first_plan_phase_upper_seconds'] for o in group]+[
            seconds(stability['maximum_epoch_first_plan_phase_seconds_by_bank_class'][str(cls)])])
        first_plan+=first_plan_cap*epochs
        restart_cap=max([o['complete_native_restart_upper_seconds'] for o in group]+[
            seconds(stability['maximum_complete_native_restart_seconds_by_bank_class'][str(cls)])])
        restart+=restart_cap*(epochs-1)
    # No absent cost may be silently converted to zero. Future evidence must
    # separately validate these production-only coefficients and identities.
    require(production.get('status')=='PASS_MEASURED_PRODUCTION_INCREMENT_SAME_PROFILE',
        'Actual full production-ledger/registry increment is not yet supplied')
    scopes=scope_count([b['frame_count'] for b in pending],production['scope_max_frames'],production['scope_max_buckets'])
    total_frames=sum(b['frame_count'] for b in pending)
    parts=dict(row_seconds=row_cost,steady_plan_seconds=sum(b['frame_templates_without_reuse'] for b in pending)*template_cap,
        entire_epoch_first_plan_phase_seconds=first_plan,
        conservative_transport_verify_save_seconds=frame_cost,cold_bucket_seconds=cold,explicit_bucket_leave_seconds=leave,
        initial_nonprefetched_fill_per_bucket_seconds=fill,
        once_per_native_epoch_reference_seconds=reference,intermediate_native_restart_seconds=restart,
        extra_production_ledger_per_frame_seconds=seconds(production['ledger_increment_per_frame_upper_seconds'])*total_frames,
        extra_certificate_registry_per_bucket_seconds=seconds(production['certificate_registry_per_bucket_upper_seconds'])*len(pending),
        shared_once_hash_setup_seconds=seconds(production['shared_once_hash_setup_upper_seconds']),
        final_scope_cleanup_seconds=seconds(production['final_scope_cleanup_upper_seconds']),
        additional_GPU_scope_initialization_cleanup_seconds=max(0,scopes-1)*seconds(production['additional_scope_init_close_inclusive_upper_seconds']))
    upper=sum(parts.values())*1.25+seconds(production['retry_recovery_reserve_seconds'])
    return dict(status='DRAFT_ACCOUNTING_ONLY_NO_LAUNCH',allow_full_run=False,
        empirical_16h_threshold_met_arithmetically=upper<=57600,conservative_empirical_upper_seconds=upper,
        components_before25percent_margin=parts,margin_multiplier=1.25,soft_gate_seconds=57600,hard_cumulative_seconds=72000,
        pending_rows=sum(b['rows'] for b in pending),canonical_frames=total_frames,pending_buckets=len(pending),
        actual_interval_native_epochs=epoch_count,minimum_native_epochs_if_all16=sum(math.ceil(b['frame_count']/16) for b in pending),
        native_intermediate_restarts=epoch_count-len(pending),GPU_scopes=scopes,additional_GPU_scope_start_stop_pairs=max(0,scopes-1),
        stratum_caps=caps,global_steady_plan_wall_seconds_per_actual_materialized_template=template_cap,
        accounting_contract=CONTRACT,entire_epoch_first_phase_and_every_global_template_both_charged=True,
        all_context_and_buildHot_costs_remain_in_first_epoch_or_steady_T_or_zero_T_frame_fees=True,
        raw_hash_IO_proof_runtime_and_negative_controls_verifier_still_required=True,
        old_V7_V9_V12_V13_results_not_used_as_fresh_V14_timings=True,starts_any_process=False,full_table_Lean='NOT_VERIFIED')
