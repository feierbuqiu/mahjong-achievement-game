"""Prepare the exact full queue, and optionally its immutable manifest. Never run."""
from pathlib import Path
import argparse,json,subprocess,sys
import campaign_io as c
import campaign as s
import prior_import as prior

def definition():
    table=s.slots();rows=[dict(layer=n,honor=h,size=r["size"],reuse="CERTIFIED_34_33" if n>=33 else ("COMPLETE_V5_LAYER32" if n==32 else "REQUIRES_NEW_NATIVE_CHECK"))
        for (n,h),r in sorted(table.items(),key=lambda item:(-item[0][0],item[0][1])) if r["size"]]
    total=sum(r["size"] for r in rows);known=sum(r["size"] for r in rows if r["layer"]>=32)
    assert len(rows)==3686 and total==778532864302
    return dict(schema="EXACT_CROSS_LAYER_FULL_QUEUE_PLAN_ONLY_V16_INDEXED_BYTE",state="PLANNED_NOT_STARTED",all_slots=6440,nonempty_buckets=len(rows),
        total_unique_rows=total,certified_layer34_33_32_unique_rows=known,rows_requiring_new_native_checks=total-known,
        all_buckets=dict(path=c.rel(c.DATASET/"all_buckets.json"),sha256=c.sha(c.DATASET/"all_buckets.json")),
        reused_layer32=dict(manifest=c.rel(prior.OLD/"manifest.json"),manifest_sha256=prior.EXPECTED,acceptance=c.rel(prior.ACCEPTANCE),acceptance_sha256=prior.ACCEPTANCE_SHA,
            unique_rows=280542509,full_buckets=68,nested_old13_rows=5228859,partial_old_h106_is_not_an_additional_import=True),
        layer_counts=[dict(layer=n,buckets=sum(r["layer"]==n for r in rows),rows=sum(r["size"] for r in rows if r["layer"]==n)) for n in range(34,-1,-1)],
        requests=rows,cumulative_total_budget_seconds=72000,cleanup_reserved_inside_invocation_seconds=60,
        auto_run=False,full_launch_allowed=False,full_table_verification="NOT_VERIFIED",completion_in_20h_guaranteed=False,
        required_before_launch=["Actual independently gated104-proof one-byte Linux checker profile","New production start authority after weighted cost and actual production readiness",
            "Exact source/target proof registry and all immutable input locks","Current full bucket schedule and actual resource guards"])

def main():
    p=argparse.ArgumentParser();p.add_argument("--name",default="overnight_v16_indexed");p.add_argument("--worker-gate");p.add_argument("--backend",choices=["linux_fused_joint_indexed_byte_checked_constructor_native_cache_v16"],default="linux_fused_joint_indexed_byte_checked_constructor_native_cache_v16")
    p.add_argument("--threads",type=int,choices=(12,),default=12);p.add_argument("--start-evaluator")
    p.add_argument("--write-manifest",action="store_true",help="Plan and seed only; this flag never starts certification")
    a=p.parse_args();out=c.RUN/"queue_plans"/(a.name+".json")
    s.folder(a.name)  # Validate the name before making any new artifact.
    value=definition()
    if out.exists():
        if c.read(out)!=value:raise ValueError("Preserve a different existing full queue definition")
    else:c.atomic(out,value)
    if a.write_manifest:
        if not a.worker_gate:raise ValueError("A real accepted worker gate is mandatory for a production manifest")
        if not a.start_evaluator:raise ValueError("Bind the independently reviewed final evaluator before the full manifest is frozen")
        argv=[sys.executable,"-B",str(c.BASE/"campaign.py"),"plan","--name",a.name,"--backend",a.backend,"--worker-gate",a.worker_gate,
            "--protocol","fused_linux_v16_joint_indexed_byte_checked_constructor_native_cache","--threads",str(a.threads),"--reuse-layer32-v5","--pending-layers-only","--budget","72000","--start-evaluator",a.start_evaluator]
        subprocess.run(argv,cwd=c.ROOT,check=True)
        subprocess.run([sys.executable,"-B",str(c.BASE/"campaign.py"),"seed-tail","--name",a.name],cwd=c.ROOT,check=True)
    print(json.dumps(dict(queue_definition=c.rel(out),sha256=c.sha(out),requests=len(value["requests"]),new_rows=value["rows_requiring_new_native_checks"],
        immutable_manifest_created=a.write_manifest,any_native_or_GPU_work_started=False)))

if __name__=="__main__":main()
