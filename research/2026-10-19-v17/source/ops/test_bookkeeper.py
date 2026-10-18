"""Small synthetic bookkeeping controls. No Native/GPU acceptance is created."""
import copy,json,math,uuid
import common as c
import finalize as f

def main():
    out=c.RUNS/('bookkeeper_controls_'+uuid.uuid4().hex[:12]);out.mkdir(parents=True)
    run=c.RUNS/'full_native_20261018_01';plan=c.load(run/'PLAN.json')
    before_pointer=c.load(run/'INPUTS_BEFORE.json');before=c.load(c.checked_record(before_pointer['identity_record']))
    source_map={}
    baseline=c.load(c.checked_record(f.BASELINE));build=c.load(c.checked_record(f.BUILD))
    for value in baseline['source_records']:
        for field in ('source','snapshot'):source_map[value[field]['path']]=c.identity(value[field])
    source_map.update(f.APPLICATION_SOURCES)
    for value in build['modules']:
        rec=value['source_snapshot'];source_map[rec['path']]=c.identity(rec)
    manifest=dict(schema=f.MANIFEST_SCHEMA,native=f.NATIVE,final_build=f.BUILD,baseline=f.BASELINE,
        inputs_before=before['files'],input_identity_sha256=c.digest(before['files']),
        old_PASS_or_seed_imported=False,closed_actual_input_Lean_declaration=False,
        smoke_required_controls_passed=True,application_source_binding=source_map)
    msha=c.digest(manifest);fixtures={};reader_calls=[]
    def put(name,value):
        record=dict(path='FIXTURE_ONLY/'+name,bytes=len(c.canonical(value)),sha256=c.digest(value))
        fixtures[(record['path'],record['bytes'],record['sha256'])]=value;return record
    def read(rec):
        reader_calls.append(rec['path'])
        if rec==f.BUILD:return build
        if rec==f.BASELINE:return baseline
        return fixtures[(rec['path'],rec['bytes'],rec['sha256'])]
    cell=next(x for x in plan['cells'] if (x['layer'],x['honor'])==(32,89));c.need(cell['size']==56,'Expected real tiny shape')
    global_rec=put('global',dict(session_id='FIXTURE_SESSION',native=f.NATIVE,native_event=dict(event='GLOBAL_READY',
        baseChecked=True,successorsChecked=True,layers=35,honors=184)))
    targets=f.target_cells(plan,cell);opened=put('open',dict(session_id='FIXTURE_SESSION',bucket_open_id='FIXTURE_OPEN',native=f.NATIVE,
        native_event=dict(event='BUCKET_READY',layer=32,honor=89,size=56,metadataChecked=True,targetIdentity=True,
                          loaded_target_honors=sorted(x['honor'] for x in targets),rootChecked=None)))
    def frame(start,count):
        native=put('result_'+str(start),dict(schema='V17_NATIVE_FRAME_RESULT_V1',event='FRAME_RESULT',
            status='PASS_NATIVE_V17_FRAME',frameAccepted=True,layer=32,honor=89,start=start,count=count,checked_rows=count,
            P_rows=count,N_rows=0,logical_fragments=12,closed_kernel_table_theorem=False))
        value=dict(schema=f.FRAME_SCHEMA,status='COMMITTED_NATIVE_V17_FRAME',manifest_sha256=msha,native=f.NATIVE,
            input_identity_sha256=manifest['input_identity_sha256'],no_old_acceptance_imported=True,layer=32,honor=89,start=start,count=count,
            source_identity=f.source_identity(manifest,plan,cell),target_identities={str(x['honor']):f.source_identity(manifest,plan,x) for x in targets},
            session_id='FIXTURE_SESSION',bucket_open_id='FIXTURE_OPEN',global_ready=global_rec,bucket_ready=opened,native_result=native,
            P_rows=count,N_rows=0,source_span_P_rows=count,source_span_N_rows=0,
            acceptances=dict(base=True,successors=True,metadata=True,frames=True,target_identity=True,root_P=False))
        return dict(frame_key=[32,89,start,count],receipt=put('receipt_'+str(start),value))
    entries=[frame(0,28),frame(28,28)];tests=[]
    def yes(name,action):
        action();tests.append(dict(name=name,status='PASS'))
    def no(name,action):
        try:action()
        except (ValueError,KeyError,TypeError) as error:tests.append(dict(name=name,status='PASS_REJECTED',error=repr(error)));return
        raise AssertionError('Bad fixture was accepted: '+name)
    yes('synthetic_exact_own_prefix_shape',lambda:f.verify_entries(manifest,msha,plan,entries,read))
    no('missing_first_frame',lambda:f.verify_entries(manifest,msha,plan,entries[1:],read))
    no('missing_full_table_frames_cannot_complete',lambda:f.verify_entries(manifest,msha,plan,entries,read,complete=True))
    bad=copy.deepcopy(entries);bad[0]['receipt']['sha256']='0'*64
    no('changed_receipt_hash',lambda:f.verify_entries(manifest,msha,plan,bad,read))
    removed=fixtures.pop(tuple(entries[0]['receipt'][k] for k in ('path','bytes','sha256')))
    no('deleted_receipt',lambda:f.verify_entries(manifest,msha,plan,entries,read))
    fixtures[tuple(entries[0]['receipt'][k] for k in ('path','bytes','sha256'))]=removed
    overlap=[entries[0],frame(27,28)]
    no('overlapping_frame_intervals',lambda:f.verify_entries(manifest,msha,plan,overlap,read))
    no('duplicate_frame',lambda:f.verify_entries(manifest,msha,plan,[entries[0],entries[0]],read))
    for name,modify in [
        ('changed_executable',lambda m:m['native'].update(sha256='0'*64)),
        ('missing_actual_input',lambda m:m['inputs_before'].pop(next(iter(m['inputs_before'])))),
        ('imported_old_PASS',lambda m:m.update(old_PASS_or_seed_imported=True)),
        ('closed_input_Lean_claim',lambda m:m.update(closed_actual_input_Lean_declaration=True)),
        ('different_build_authority',lambda m:m['final_build'].update(sha256='0'*64)),
        ('different_application_source',lambda m:m['application_source_binding'][next(iter(f.APPLICATION_SOURCES))].update(sha256='0'*64)),
    ]:
        bad_manifest=copy.deepcopy(manifest);modify(bad_manifest)
        no(name,lambda m=bad_manifest:f.verify_entries(m,msha,plan,entries,read))
    yes('all6440_actual_catalog_headers',lambda:c.need(f.verify_catalog_headers(plan)['checked_cells']==6440,'Missing headers'))
    scope=put('scope',dict(session_id='FIXTURE_SESSION',native=f.NATIVE))
    linux=put('linux_cleanup',dict(schema='V17_LINUX_SERVICE_CLEANUP_V1',session_id='FIXTURE_SESSION',native_exited=True,
        GPU_context_closed=True,native_returncode=0,errors=[]))
    ack=put('confirmed_cleanup',dict(schema='V17_SUPERVISOR_CONFIRMED_CLEANUP_V1',session_id='FIXTURE_SESSION',native=f.NATIVE,
        all_owned_services_confirmed_exited=True,adapter_returncode=0,scope=scope,linux_cleanup=linux,
        native_stop_event=dict(event='GLOBAL_STOPPED')))
    after=dict(schema='V17_ACTUAL_POST_INPUT_IDENTITIES_V1',files=before['files'])
    cleanup=dict(schema='V17_ALL_OWNED_SERVICES_CONFIRMED_EXITED_V1',all_owned_services_confirmed_exited=True,
        sessions=[ack],all_session_ids=['FIXTURE_SESSION'])
    yes('synthetic_final_identity_and_owned_exit_shape',lambda:f.verify_completion(manifest,plan,entries,after,cleanup,read))
    changed=copy.deepcopy(after);changed['files'][next(iter(changed['files']))]['sha256']='0'*64
    no('changed_post_input_sha',lambda:f.verify_completion(manifest,plan,entries,changed,cleanup,read))
    no('omitted_owned_session_exit',lambda:f.verify_completion(manifest,plan,entries,after,dict(cleanup,sessions=[]),read))
    no('unconfirmed_owned_services',lambda:f.verify_completion(manifest,plan,entries,after,dict(cleanup,all_owned_services_confirmed_exited=False),read))
    # Real fsync/hash-chain code, tiny own files; these are not row receipts.
    jrun=out/'journal_fixture';jrun.mkdir();journal=c.Journal(jrun,'a'*64)
    journal.append((32,89,0,28),entries[0]['receipt']);journal.append((32,89,28,28),entries[1]['receipt'])
    yes('journal_fsync_chain_reopen',lambda:c.need(len(c.Journal(jrun,'a'*64).entries)==2,'Journal lost entry'))
    no('journal_duplicate_frame',lambda:journal.append((32,89,0,28),entries[0]['receipt']))
    with journal.file.open('ab') as file:file.write(b'{"partial":');file.flush()
    no('truncated_ledger_rejects_without_recovery',lambda:c.Journal(jrun,'a'*64))
    yes('only_incomplete_tail_recovered_with_provenance',lambda:c.need(len(c.Journal(jrun,'a'*64,repair_tail=True).entries)==2,'Recovery changed committed prefix'))
    report=dict(schema='V17_EXTERNAL_BOOKKEEPER_PURE_CONTROLS_V1',status='PASS_SYNTHETIC_BOOKKEEPING_CONTROLS_ONLY',
        tests=tests,test_count=len(tests),sources={c.rel(x):c.sha_file(x) for x in (c.BASE/'common.py',c.BASE/'finalize.py',c.BASE/'test_bookkeeper.py')},
        input_plan=c.record(run/'PLAN.json'),Native_processes_started=0,GPU_processes_started=0,
        actual_game_rows_accepted=0,fixture_native_events_are_synthetic=True,no_permission_to_run_from_this_report_alone=True)
    record=c.once(out/'controls.json',report);print(c.canonical(record).decode())

if __name__=='__main__':main()
