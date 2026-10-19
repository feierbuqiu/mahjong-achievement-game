#!/usr/bin/env python3
"""Check the working English trust paper, GitHub math and recorded evidence scopes."""
import hashlib
import json
import math
from pathlib import Path
import re
from urllib.parse import unquote
from verify_paper import normalise

ROOT=Path(__file__).resolve().parents[1]
BASE=ROOT/'papers/trust-verification'


def read(path):return json.loads(path.read_text(encoding='utf-8-sig'))
def sha(path):return hashlib.sha256(path.read_bytes()).hexdigest()
def need(value,message):
    if not value:raise ValueError(message)
def near(a,b):need(math.isclose(a,b,rel_tol=1e-10,abs_tol=1e-6),'Recorded arithmetic mismatch')


def verify():
    provenance=read(BASE/'provenance.json');expected=read(BASE/'equations.json')
    need(provenance['primary_language']=='en' and not provenance['chinese_manuscript_published'],'English-only scope changed')
    need(not provenance['current_work_frozen'] and not provenance['new_release_created'] and not provenance['new_tag_created'],'Working publication/freeze boundary changed')
    need(not provenance['new_Lean_native_GPU_or_full_scan_started'],'Publication research-execution boundary changed')
    need(sha(BASE/'manuscript.md')==provenance['published_manuscript_sha256'] and
         expected['original_manuscript_sha256']==provenance['original_manuscript_sha256'],'Manuscript identity differs')
    paths=set()
    for item in provenance['artifacts']:
        p=(BASE/item['published_path']).resolve()
        need(p.is_relative_to(BASE) and p.is_file() and item['published_path'] not in paths,'Invalid/duplicate artifact')
        paths.add(item['published_path'])
        need(p.stat().st_size==item['published_bytes'] and sha(p)==item['published_sha256'],'Changed publication artifact: '+item['published_path'])
        if not item['transformations']:need(item['original_sha256']==item['published_sha256'],'Unrecorded transformation')
    pattern=re.compile(r'^```math\n(?P<display>.*?)\n```|\$`(?P<inline>.*?)`\$',re.M|re.S)
    count=0
    for name,formulas in expected['documents'].items():
        text=(BASE/name).read_text(encoding='utf-8')
        observed=[dict(kind=m.lastgroup,tex=normalise(m[m.lastgroup])) for m in pattern.finditer(text)]
        need(observed==[dict(kind=x['kind'],tex=normalise(x['tex'])) for x in formulas],'Formula content/order differs: '+name)
        count+=len(observed)
        need(not re.search(r'\\[\[\]()]|\\tag\{|\\operatorname',text),'Incompatible publication math dialect')
        for line in text.splitlines():
            if line.startswith('|'):need(all('|' not in x for x in re.findall(r'\$`(.*?)`\$',line)),'Unprotected table math pipe')
    need(count==19 and len(expected['documents']['manuscript.md'])==16 and
         sum(x['kind']=='display' for x in expected['documents']['manuscript.md'])==5,'Formula count differs')
    text=(BASE/'manuscript.md').read_text(encoding='utf-8')
    table_text=re.sub(r'\[([^\]]+)\]\([^)]+\)',r'\1','\n'.join(x for x in text.splitlines() if x.startswith('|')))
    need(re.findall(r'\d+(?:,\d{3})*(?:\.\d+)?',table_text)==expected['manuscript_table_numeric_tokens'],'Numerical table changed')
    need(re.findall(r'\\qquad\s*\\text\{\(([^)]+)\)\}',text)==expected['manuscript_equation_tags']==['1','2','3','4','5'],'Equation numbering differs')
    states=sorted(set(re.findall(r'(?<!\d)[0-4]{34}(?!\d)',text)))
    need(states==expected['physical_states'] and len(states)==3 and all(sum(map(int,x))==32 for x in states),'Physical game states changed')
    references=text.split('## References\n',1)[1].split('## Appendix A.',1)[0]
    need(len([x for x in references.split('\n\n') if x.strip()])==11,'Bibliography entry count changed')
    source=(ROOT/'research/2026-10-18-kernel/source/v17/Mahjong/FastWholeInputV17.lean').read_text(encoding='utf-8')
    signature=text.split('```lean\ntheorem from_finite_input',1)[1].split('\n```',1)[0]
    signature='theorem from_finite_input'+signature
    need(re.sub(r'\s+','',signature) in re.sub(r'\s+','',source),'Exact whole-input type differs from frozen source')
    sources=read(BASE/'source-map.json')['sources']
    for row in sources:
        if row['availability']=='PUBLIC_GIT_COPY':
            p=(ROOT/row['published_path']).resolve()
            need(p.is_relative_to(ROOT) and p.stat().st_size==row['published_bytes'] and sha(p)==row['published_sha256'],'Evidence mapping differs')
        elif row['availability']=='EXISTING_PUBLIC_EVIDENCE_ASSET':need(row['asset_descriptor']=='research/2026-10-19-v17/assets.json','Existing asset mapping differs')
        else:need(row['availability']=='RETAINED_OUTSIDE_PUBLIC_GIT','Unknown availability')
    links=0
    for p in BASE.rglob('*.md'):
        for url in re.findall(r'\]\(([^\s)]+)\)',p.read_text(encoding='utf-8-sig')):
            if re.match(r'[a-zA-Z]+:',url) or url.startswith('#'):continue
            target=(p.parent/unquote(url.split('#',1)[0])).resolve()
            need(target.is_relative_to(ROOT) and target.exists(),'Broken publication resource: '+url);links+=1
            if '#source-' in url:need('## '+url.split('#',1)[1] in target.read_text(encoding='utf-8'),'Missing evidence anchor')
    delivery=read(BASE/'delivery.json')
    need(not delivery['new_release_created'] and not delivery['archived_files_uploaded_in_this_update'],'Delivery/upload boundary changed')
    need([(x['bytes'],x['availability'],x['download_url']) for x in delivery['archives']]==[
        (1407097086,'VALIDATED_LOCAL_DELIVERY_NOT_PUBLICLY_HOSTED',None),
        (8087887655,'VALIDATED_LOCAL_DELIVERY_NOT_PUBLICLY_HOSTED',None),
        (21136243,'VALIDATED_LOCAL_DELIVERY_NOT_PUBLICLY_HOSTED',None)],'Local archive availability differs')
    evidence=BASE/'evidence'
    packed=read(evidence/'packed/report.json')
    need(packed['status']=='PASS_FRESH_COMPLETE_FIXED_SAMPLE_KERNEL_COMPONENTS' and packed['saved_PN_proof'] and
         not packed['empty_game_proved'] and not packed['closed_actual_SAFE_or_target_lookup'] and not packed['full_table_scan'],'Packed proof scope changed')
    need((packed['blocks'],packed['raw_words'],packed['layout_equalities'],packed['mathematical_modules'],packed['actual_colex_rows'],packed['Cartesian_coordinates'])==
         (28,402,1234,273,1035129,1077270),'Packed sample dimensions changed')
    manifest=read(evidence/'packed/certificate-manifest.json')
    need(sum(x.endswith('.olean') for x in manifest)==273 and sum(x['bytes'] for x in manifest.values())==packed['certificate_bytes']==134862920,'Certificate inventory differs')
    near(packed['replay']['wall_seconds'],61.828391958);near(packed['wall_seconds'],132.205101013)
    native_audit=read(BASE/'native_record_audit.json')
    need(native_audit['problem_count']==0 and native_audit['records_read']==38323 and native_audit['totals']['rows']==778532864302 and
         native_audit['totals']['frames']==17317 and native_audit['cross_layer_identity_references']==54548,'Native saved-record audit scope changed')
    d=evidence/'delivery'
    validation=read(d/'validation.json');pilots=read(d/'kernel-pilots.json')
    need(validation['source_project_modules']==149 and not validation['production_full_table_recomputed'] and
         not validation['independent_second_machine_test_performed'],'Portable validation scope changed')
    need(pilots['status']=='PASS_EXTRACTED_PORTABLE_PURE_KERNEL_PILOTS' and len(pilots['lanes'])==3 and
         not pilots['empty_game_proved'] and not pilots['full_table_scan'],'Saved-pilot scope changed')
    need(all(x['returncode']==0 and not x['empty_game_proved'] and not x['game_Native_or_GPU_started'] for x in pilots['lanes']),'Saved-pilot replay incomplete')
    current=read(ROOT/'RESEARCH_STATUS.json')
    need(current['paper']['primary_manuscript']=='papers/trust-verification/manuscript.md' and len(current['paper']['reports'])==3,'Current paper entry differs')
    need(not current['current_work_frozen'] and not current['current_update']['new_release_created'] and not current['current_update']['new_tag_created'],'Current publication/freeze state differs')
    need(current['formal_verification']['empty_game_lean']=='NOT_VERIFIED' and
         not current['formal_verification']['end_to_end_Lean_theorem_published'],'Component and whole-game proofs conflated')
    near(current['portable_reproduction']['generic_kernel_replay_seconds'],validation['cold_kernel_replay_seconds'])
    need(current['portable_reproduction']['archives_publicly_hosted'] is False and
         not current['portable_reproduction']['independent_second_physical_machine_test'],'Local delivery and public replication conflated')
    return dict(status='PASS_WORKING_TRUST_SUPPLEMENT',formulas=16,display_formulas=5,inline_formulas=11,auxiliary_display_formulas=3,
        bibliography_entries=11,artifacts=len(paths),evidence_entries=len(sources),paper_local_links_checked=links,
        recorded_packed_modules=273,recorded_portable_source_modules=149,
        new_release_created=False,current_work_frozen=False,
        scope='Paper byte/formula/link and selected recorded-scope consistency; no new mathematical proof, research execution or independent review')


if __name__=='__main__':print(json.dumps(verify()))
