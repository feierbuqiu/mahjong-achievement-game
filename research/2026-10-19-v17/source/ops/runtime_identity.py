"""Bind the actual new build and replay actual connection-control evidence."""
import argparse,importlib.util,json,sys
from pathlib import Path
import common as c
import finalize as f

CASE_IDS=('positive_full_bucket','source_bit_flip','deleted_last_row','target_identity_mismatch','truncated_source_bits','catalog_honor_mismatch')

def source_binding():
    baseline=c.load(c.checked_record(f.BASELINE));build=c.load(c.checked_record(f.BUILD));result={}
    for value in baseline['source_records']:
        for key in ('source','snapshot'):
            rec=value[key];result[rec['path']]=c.identity(rec)
    result.update(f.APPLICATION_SOURCES)
    for value in build['modules']:
        rec=value['source_snapshot'];result[rec['path']]=c.identity(rec)
    return result

def verify_native_controls(rec,code_binding):
    p=c.checked_record(rec);report=c.load(p)
    c.need(report.get('schema')=='V17_NATIVE_CONNECTION_CONTROLS_V1' and
        report.get('status')=='PASS_ACTUAL_NATIVE_CONNECTION_CONTROLS' and report.get('native')==f.NATIVE and
        report.get('required_controls_passed') is True and report.get('old_acceptance_or_seed_imported') is False and
        report.get('all_owned_services_confirmed_exited') is True,'Fresh actual Native connection controls incomplete')
    source=report['source_record'];c.need(source['path']==c.rel(c.BASE/'native_controls.py') and
        code_binding.get(source['path'])==c.identity(source),'Native controls do not bind the current frozen source')
    source_path=c.checked_record(source)
    raw=source_path.read_bytes();ns=dict(__name__='_v17_control_raw_replay',__file__=str(source_path))
    exec(compile(raw,str(source_path),'exec'),ns)
    fixtures=c.load(c.checked_record(report['manifest']));outer=c.load(c.checked_record(report['outer_cleanup']))
    c.need(fixtures['native']==f.NATIVE and fixtures['source_record']==source,'Control fixture executable/source differs')
    cases=report['cases'];c.need(len(cases)==6 and {x['case_id'] for x in cases}==set(CASE_IDS),'All six actual connection controls required')
    records=[];ranges=[];shared_session=None
    for item in cases:
        actual=c.load(c.checked_record(item['report']));records.append(item['report'])
        c.need(actual['manifest']==report['manifest'] and actual['native']==f.NATIVE and actual['source_record']==source and
               actual.get('native_process_waited_and_exited') is True,'Control invocation/source/exit differs')
        for key in ('stdout','stderr','saved_result','native_started'):
            if actual.get(key) is not None:c.checked_record(actual[key])
        case=next(x for x in fixtures['cases'] if x['case_id']==item['case_id'])
        saved=c.load(c.path(actual['saved_result']['path'])) if actual['saved_result'] else None
        events=ns['decode_events'](c.path(actual['stdout']['path']).read_bytes())
        if actual.get('execution_mode')=='CONTROLS_ONE_ACTUAL_BASE_SESSION_V1':
            session=c.load(c.checked_record(actual['session_report']))
            c.need(session.get('status')=='PASS_ACTUAL_SIX_CASE_SESSION' and session.get('native')==f.NATIVE and
                session.get('manifest')==report['manifest'] and session.get('source_record')==source and
                session.get('native_process_id')==actual['native_process_id'] and session.get('native_returncode')==0 and
                session.get('native_process_waited_and_exited') is True and session.get('stdout_EOF_confirmed') is True and
                session.get('stdout')==actual['stdout'] and session.get('stderr')==actual['stderr'] and
                actual.get('native_returncode')==0 and actual.get('timed_out') is False,'Actual same-session STOP/EOF/exit differs')
            if shared_session is None:shared_session=actual['session_report']
            c.need(shared_session==actual['session_report'],'Controls were not from one actual session')
            ns['checked_session_events'](events);first,stop=actual['event_range']
            c.need(type(first) is int and type(stop) is int and 2<=first<stop<len(events),'Bad actual case event range')
            ranges.append((CASE_IDS.index(item['case_id']),first,stop,len(events)))
            verdict=ns['classify_control'](case,events[first:stop],saved)
        else:
            verdict=ns['classify'](case,events,c.path(actual['stderr']['path']).read_text(encoding='utf-8',errors='replace'),
                actual['native_returncode'],actual['timed_out'],saved)
        c.need(verdict['passed'] is True and actual.get('passed') is True and item.get('passed') is True,'Actual native rejection/acceptance cause differs')
        for key,value in verdict.items():c.need(item.get(key)==value,'Stored Native-control verdict differs from actual raw replay')
    if ranges:
        c.need(len(ranges)==6,'Cannot mix shared-session and independent Native case receipts')
        cursor=2
        for _,first,stop,event_count in sorted(ranges):
            c.need(first==cursor,'Shared-session case events overlap or have gaps');cursor=stop
        c.need(cursor==event_count-1,'Shared-session Native events were omitted before final STOP')
    c.need(outer.get('schema')=='V17_NATIVE_CONTROLS_OUTER_CLEANUP_V1' and outer.get('native')==f.NATIVE and
           outer.get('manifest')==report['manifest'] and outer.get('all_owned_services_confirmed_exited') is True and
           outer.get('all_child_trees_confirmed_empty') is True and outer.get('actual_input_and_code_readlocks_held_through_exit') is True,
           'Outer actual control cleanup/custody incomplete')
    c.need(sorted(outer.get('case_reports',[]),key=lambda x:x['path'])==sorted(records,key=lambda x:x['path']),'Outer control cleanup bound different invocations')
    return report

def verify_bookkeeper(rec,code_binding):
    value=c.load(c.checked_record(rec));c.need(value.get('schema')=='V17_EXTERNAL_BOOKKEEPER_PURE_CONTROLS_V1' and
        value.get('status')=='PASS_SYNTHETIC_BOOKKEEPING_CONTROLS_ONLY' and value.get('actual_game_rows_accepted')==0,
        'Bookkeeper control identity differs')
    for name in ('common.py','finalize.py','test_bookkeeper.py'):
        p=c.rel(c.BASE/name);c.need(value['sources'].get(p)==code_binding.get(p),'Bookkeeper controls bind a different implementation')
    names={v['name'] for v in value['tests'] if v['status'].startswith('PASS')}
    c.need({'changed_receipt_hash','deleted_receipt','overlapping_frame_intervals','missing_first_frame','missing_full_table_frames_cannot_complete',
            'changed_executable','different_build_authority','different_application_source'}.issubset(names),'Required bookkeeping negative controls missing')
    return value

def validate_runtime(value,code_binding):
    c.need(value.get('schema')=='V17_COMPUTE_RUNTIME_IDENTITY_AND_SMOKE_V1' and value.get('native')==f.NATIVE and
        value.get('final_build')==f.BUILD and value.get('baseline')==f.BASELINE,'Different runtime/build/baseline authority')
    expected=source_binding();c.need(value.get('application_source_binding')==expected,'Runtime mathematical/application input list differs')
    for name,rec in expected.items():c.need(code_binding.get(name)==rec,'Actual locked source map omits frozen mathematical/application source')
    verify_native_controls(value['native_controls'],code_binding);verify_bookkeeper(value['bookkeeper_controls'],code_binding)
    return True

def main():
    a=argparse.ArgumentParser();a.add_argument('--run',required=True);a.add_argument('--native-controls',required=True)
    a.add_argument('--bookkeeper-controls',required=True);v=a.parse_args();run=c.owned(v.run)
    sources=source_binding();paths=list(sources)+[c.BASE/'native_controls.py',c.BASE/'common.py',c.BASE/'finalize.py',c.BASE/'test_bookkeeper.py',
        f.NATIVE['path'],f.BUILD['path'],f.BASELINE['path'],v.native_controls,v.bookkeeper_controls]
    with c.ReadLocks(paths):
        actual={c.rel(c.path(name)):c.sha_file(name) for name in paths}
        for name,rec in sources.items():c.need(actual[name]==rec,'Current source differs from actual compiled/frozen input')
        value=dict(schema='V17_COMPUTE_RUNTIME_IDENTITY_AND_SMOKE_V1',native=f.NATIVE,final_build=f.BUILD,baseline=f.BASELINE,
            application_source_binding=sources,native_controls=c.record(v.native_controls),bookkeeper_controls=c.record(v.bookkeeper_controls),
            created_utc=c.utc(),claim_class='FIXED_V17_KERNEL_IMPLICATION_PLUS_NATIVE_COMPUTATION',closed_actual_input_Lean_declaration=False,
            old_PASS_or_seed_imported=False)
        validate_runtime(value,actual);record=c.once(run/'RUNTIME.json',value)
        print(c.canonical(record).decode())

if __name__=='__main__':main()
