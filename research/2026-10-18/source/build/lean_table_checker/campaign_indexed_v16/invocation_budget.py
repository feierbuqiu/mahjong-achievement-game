"""Crash-conservative invocation reservations, separate from progress journals.

Caller holds invocation.lock for the entire process subtree. An abrupt exit
leaves its complete requested window charged. Only confirmed clean cleanup
refunds unused time. The launcher reserves before input/code hashing and passes
one exact ticket to its child; a direct core invocation reserves for itself.
"""
import math,os,time,uuid
import campaign_io as c

SCHEMA="OWNED_CRASH_CONSERVATIVE_RUNTIME_BUDGET_V4"
CLEANUP_RESERVE_SECONDS=60

def state_path(folder):return folder/"runtime_budget.json"

def reserve(folder,manifest,maximum):
    if not isinstance(maximum,(int,float)) or not math.isfinite(maximum) or maximum<=0:raise ValueError("Positive finite invocation window required")
    path=state_path(folder);identity=c.sha(folder/"manifest.json");limit=manifest["cumulative_runtime_budget_seconds"]
    value=c.read(path) if path.exists() else dict(schema=SCHEMA,manifest_sha256=identity,limit_seconds=limit,charged_seconds=0.,reservation=None,completed_invocations=0,abandoned_invocations=0)
    if value.get("schema")!=SCHEMA or value.get("manifest_sha256")!=identity or value.get("limit_seconds")!=limit or not 0<limit<=72000:
        raise ValueError("Runtime budget identity or hard 20h limit changed")
    charged=value.get("charged_seconds")
    if not isinstance(charged,(float,int)) or not math.isfinite(charged) or charged<0:raise ValueError("Invalid cumulative runtime charge")
    if value.get("reservation"):
        prior=value["reservation"]
        c.atomic(folder/"budget_events"/(prior["token"]+".abandoned.json"),dict(kind="UNCLEAN_INVOCATION_FULL_WINDOW_REMAINS_CHARGED",reservation=prior,charged_seconds=charged))
        value["abandoned_invocations"]+=1;value["reservation"]=None
    window=min(float(maximum),limit-charged)
    if window<=CLEANUP_RESERVE_SECONDS:raise InterruptedError("INSUFFICIENT_CUMULATIVE_20H_BUDGET_FOR_WORK_AND_60S_CLEANUP")
    now=time.monotonic();ticket=dict(token=uuid.uuid4().hex,owner_pid=os.getpid(),owner_create_time=c.legacy.psutil.Process().create_time(),
        began_monotonic=now,reserved_seconds=window,prior_charged_seconds=charged,requested_seconds=maximum)
    value.update(charged_seconds=charged+window,reservation=ticket)
    c.atomic(path,value)
    return Ticket(folder,manifest,ticket)

def adopt(folder,manifest,token):
    value=c.read(state_path(folder));ticket=value.get("reservation")
    if value.get("schema")!=SCHEMA or value.get("manifest_sha256")!=c.sha(folder/"manifest.json") or not ticket or ticket.get("token")!=token:
        raise ValueError("Delegated invocation reservation identity mismatch")
    owner=c.legacy.psutil.Process(os.getppid())
    if ticket["owner_pid"]!=owner.pid or ticket["owner_create_time"]!=owner.create_time():raise ValueError("Reservation may only be adopted by the reserving launcher's direct child")
    return Ticket(folder,manifest,ticket)

class Ticket:
    def __init__(self,folder,manifest,ticket):self.folder=folder;self.manifest=manifest;self.ticket=ticket;self.closed=False;self.cleanup_confirmed=True
    @property
    def deadline(self):return self.ticket["began_monotonic"]+self.ticket["reserved_seconds"]
    @property
    def work_deadline(self):return self.deadline-CLEANUP_RESERVE_SECONDS
    def mirror(self,state):
        value=c.read(state_path(self.folder))
        if value.get("reservation")!=self.ticket:raise ValueError("Invocation reservation changed during execution")
        state["budget_used_seconds"]=value["charged_seconds"];state["invocation_reservation"]=self.ticket
    def finish(self,cleanup_confirmed=False):
        if self.closed:return
        value=c.read(state_path(self.folder))
        if value.get("reservation")!=self.ticket:raise ValueError("Cannot settle another invocation reservation")
        if cleanup_confirmed is not True:
            receipt=dict(schema="OWNED_UNCONFIRMED_CLEANUP_WINDOW_RETAINED_V4",reservation=self.ticket,charged_seconds=value["charged_seconds"],unused_time_refunded=False)
            c.atomic(self.folder/"budget_events"/(self.ticket["token"]+".cleanup_unconfirmed.json"),receipt)
            return receipt
        elapsed=max(0.,time.monotonic()-self.ticket["began_monotonic"])
        actual=self.ticket["prior_charged_seconds"]+elapsed
        receipt=dict(schema="OWNED_CLEAN_INVOCATION_BUDGET_SETTLEMENT_V4",reservation=self.ticket,wall_seconds=elapsed,
            charged_seconds=actual,unused_refund_seconds=max(0.,self.ticket["reserved_seconds"]-elapsed),cleanup_overrun_seconds=max(0.,elapsed-self.ticket["reserved_seconds"]))
        c.atomic(self.folder/"budget_events"/(self.ticket["token"]+".settled.json"),receipt)
        value.update(charged_seconds=actual,reservation=None,completed_invocations=value["completed_invocations"]+1,last_settlement=c.rel(self.folder/"budget_events"/(self.ticket["token"]+".settled.json")))
        c.atomic(state_path(self.folder),value);self.closed=True
        checkpoint=self.folder/"checkpoint.json"
        if checkpoint.exists():
            from ledger import save_root
            state=c.read(checkpoint);state.update(budget_used_seconds=actual,invocation_reservation=None,last_budget_settlement=value["last_settlement"])
            save_root(self.folder,state)
        return receipt
