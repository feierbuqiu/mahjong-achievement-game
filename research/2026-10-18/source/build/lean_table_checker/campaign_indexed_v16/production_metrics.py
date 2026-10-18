"""Streaming timing evidence; no measurement becomes a mathematical premise."""
import datetime,json,os,time
import campaign_io as c


def record(path):return dict(path=c.rel(path),bytes=path.stat().st_size,sha256=c.sha(path))


class RevalidationStream:
    def __init__(self,folder,token,manifest):
        self.path=folder/"revalidation_timings"/(token+".jsonl")
        self.path.parent.mkdir(parents=True,exist_ok=True);self.stream=self.path.open("xb")
        self.count=0;self.worker=manifest["worker"];self.manifest_sha256=c.sha(folder/"manifest.json")

    def append(self,item,seconds):
        value=dict(schema="ACTUAL_GENERATED_STRICT_ITEM_REVALIDATION_WALL_V12",sequence=self.count+1,
            utc=datetime.datetime.now(datetime.timezone.utc).isoformat(),manifest_sha256=self.manifest_sha256,
            worker_binding=self.worker,layer=item["layer"],honor=item["honor"],start=item["start"],count=item["count"],
            result=item["result"],result_sha256=item["result_sha256"],packed_labels=item["packed_labels"],packed_binding=item["packed_binding"],
            strict_item_revalidation_wall_seconds=seconds,
            full_actual_validate_item_called=True,additional_Native_or_GPU_rows=0)
        self.stream.write((json.dumps(value,sort_keys=True,separators=(",",":"))+"\n").encode());self.count+=1

    def close(self):
        if self.stream is None:return self.receipt
        self.stream.flush();os.fsync(self.stream.fileno());self.stream.close();self.stream=None
        self.receipt=record(self.path)
        return self.receipt


def scope(context,phase,seconds,**fields):
    directory=context.rt.f/"scope_timings";directory.mkdir(parents=True,exist_ok=True)
    path=directory/(context.base.name+"_"+phase+"_"+str(time.time_ns())+".json")
    value=dict(schema="ACTUAL_GENERATED_PRODUCTION_SCOPE_WALL_V12",phase=phase,wall_seconds=seconds,
        scope_token=context.client.name,
        worker_binding=context.m["worker"],manifest_sha256=c.sha(context.rt.f/"manifest.json"),
        all_owned_services_confirmed_exited=context.exit_confirmed,**fields)
    c.atomic(path,value)
    return record(path)
