"""Archive the new external ops; does not run Native or authorize any row."""
import argparse,os,time,uuid
import common as c
import finalize as f

def main():
    p=argparse.ArgumentParser();p.add_argument('--bookkeeper-controls',required=True);p.add_argument('--transport-controls',required=True)
    p.add_argument('--output-name',choices=['SOURCE_FREEZE.json','SOURCE_FREEZE_REVISION2.json','SOURCE_FREEZE_REVISION3.json'],default='SOURCE_FREEZE.json');a=p.parse_args()
    out=c.RUNS/('ops_source_freeze_'+uuid.uuid4().hex[:12]);out.mkdir(parents=True)
    paths=sorted(c.BASE.glob('*.py'))
    with c.ReadLocks(paths):
        files={c.rel(path):c.sha_file(path) for path in paths};snapshots=[]
        for path in paths:snapshots.append(c.once(out/'source'/path.name,path.read_bytes()))
        bk=c.load(c.checked_record(c.record(a.bookkeeper_controls)));tr=c.load(c.checked_record(c.record(a.transport_controls)))
        for field in ('sources',):
            for name,expected in bk[field].items():c.need(files.get(name)==expected,'Bookkeeper controls do not bind current ops')
        for name,expected in tr['source_binding'].items():c.need(files.get(name)==expected,'Transport controls do not bind current ops')
        value=dict(schema='V17_EXTERNAL_OPS_SOURCE_FREEZE_V1',source_revision={'SOURCE_FREEZE.json':1,'SOURCE_FREEZE_REVISION2.json':2,'SOURCE_FREEZE_REVISION3.json':3}[a.output_name],
            created_utc=c.utc(),files=files,source_snapshots=snapshots,
            native=f.NATIVE,final_build=f.BUILD,baseline=f.BASELINE,
            bookkeeper_controls=c.record(a.bookkeeper_controls),transport_controls=c.record(a.transport_controls),
            actual_native_controls_required_separately=True,new_game_rows_verified_by_this_freeze=0,
            old_acceptance_or_seed_imported=False,closed_actual_input_Lean_declaration=False,
            scope='EXTERNAL_IO_AND_NATIVE_EXECUTION_EVIDENCE_ONLY_NO_CHECKER_LOGIC_COPY',
            no_fixed_wall_or_RAM_admission=True,logical_fragments=12,initial_execution_pool_threads=12,
            all_layers=[0,34],full_original_rows=778532864302,original_r3i_STOP_unchanged=True)
        c.once(out/'SOURCE_FREEZE.json',value)
        target=c.BASE/a.output_name;c.need(not target.exists(),'Do not overwrite an existing source freeze')
        with target.open('xb') as file:file.write(c.canonical(value)+b'\n');file.flush();os.fsync(file.fileno())
        print(c.canonical(c.record(target)).decode())

if __name__=='__main__':main()
