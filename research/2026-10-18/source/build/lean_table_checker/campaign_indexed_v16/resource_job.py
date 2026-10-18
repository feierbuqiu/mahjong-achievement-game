"""One named OS Job for the launcher and all Windows descendants.

Child caps are inherited, not re-created: nested hard CPU percentages are
relative and can accidentally throttle a 5% subtree to a fraction of 5%.
"""
import ctypes,re
from ctypes import wintypes as W
import campaign_io as c
import invocation_budget as ib

class Basic(ctypes.Structure):
    _fields_=[("ProcessTime",ctypes.c_int64),("JobTime",ctypes.c_int64),("Flags",W.DWORD),("MinWS",ctypes.c_size_t),("MaxWS",ctypes.c_size_t),
        ("Active",W.DWORD),("Affinity",ctypes.c_size_t),("Priority",W.DWORD),("Scheduling",W.DWORD)]
class IO(ctypes.Structure):_fields_=[(x,ctypes.c_uint64) for x in ("ro","wo","oo","rb","wb","ob")]
class Extended(ctypes.Structure):
    _fields_=[("Basic",Basic),("IO",IO),("ProcessMemory",ctypes.c_size_t),("JobMemory",ctypes.c_size_t),("PeakProcessMemory",ctypes.c_size_t),("PeakJobMemory",ctypes.c_size_t)]
class CPU(ctypes.Structure):_fields_=[("Flags",W.DWORD),("Rate",W.DWORD)]

def kernel():
    k=ctypes.WinDLL("kernel32",use_last_error=True)
    k.CreateJobObjectW.argtypes=[ctypes.c_void_p,W.LPCWSTR];k.CreateJobObjectW.restype=W.HANDLE
    k.OpenJobObjectW.argtypes=[W.DWORD,W.BOOL,W.LPCWSTR];k.OpenJobObjectW.restype=W.HANDLE
    k.SetInformationJobObject.argtypes=[W.HANDLE,ctypes.c_int,ctypes.c_void_p,W.DWORD];k.SetInformationJobObject.restype=W.BOOL
    k.QueryInformationJobObject.argtypes=[W.HANDLE,ctypes.c_int,ctypes.c_void_p,W.DWORD,ctypes.c_void_p];k.QueryInformationJobObject.restype=W.BOOL
    k.AssignProcessToJobObject.argtypes=[W.HANDLE,W.HANDLE];k.AssignProcessToJobObject.restype=W.BOOL
    k.IsProcessInJob.argtypes=[W.HANDLE,W.HANDLE,ctypes.POINTER(W.BOOL)];k.IsProcessInJob.restype=W.BOOL
    k.GetCurrentProcess.restype=W.HANDLE;k.OpenProcess.argtypes=[W.DWORD,W.BOOL,W.DWORD];k.OpenProcess.restype=W.HANDLE
    k.CloseHandle.argtypes=[W.HANDLE];k.CloseHandle.restype=W.BOOL
    return k

def name(token):
    if not isinstance(token,str) or not re.fullmatch("[0-9a-f]{32}",token):raise ValueError("Unique reservation token required for Windows Job")
    return "Local\\MahjongLeanV12_"+token

class NamedJob:
    def __init__(self,memory,cpu,token):
        if type(memory) is not int or memory<=0 or type(cpu) is not int or not 1<=cpu<=80:raise ValueError("Invalid Windows subtree resource policy")
        self.k=kernel();self.name=name(token);self.handle=self.k.CreateJobObjectW(None,self.name)
        if not self.handle:raise ctypes.WinError(ctypes.get_last_error())
        if ctypes.get_last_error()==183:self.k.CloseHandle(self.handle);raise ValueError("Refuse an existing named Windows Job")
        extended=Extended();extended.Basic.Flags=0x2200;extended.JobMemory=memory
        rate=CPU(5,cpu*100)
        for cls,value in ((9,extended),(15,rate)):
            if not self.k.SetInformationJobObject(self.handle,cls,ctypes.byref(value),ctypes.sizeof(value)):raise ctypes.WinError(ctypes.get_last_error())
        if not self.k.AssignProcessToJobObject(self.handle,self.k.GetCurrentProcess()):raise ctypes.WinError(ctypes.get_last_error())
        self.memory,self.cpu=memory,cpu
        self.descriptor=dict(schema="EXACT_NAMED_INHERITED_WINDOWS_SUBTREE_JOB_V12",name=self.name,memory_bytes=memory,cpu_percent=cpu,
            kernel_memory_limit_bytes=memory//4096*4096,breakaway_allowed=False,KILL_ON_JOB_CLOSE=True)

def bind_ticket(ticket,job):
    state=c.read(ib.state_path(ticket.folder))
    if state.get("reservation")!=ticket.ticket:raise ValueError("Cannot bind a Job to a changed reservation")
    ticket.ticket=dict(ticket.ticket,Windows_job=job.descriptor);state["reservation"]=ticket.ticket;c.atomic(ib.state_path(ticket.folder),state)

def verify_child(ticket,manifest):
    descriptor=ticket["Windows_job"]
    wanted=dict(schema="EXACT_NAMED_INHERITED_WINDOWS_SUBTREE_JOB_V12",name=name(ticket["token"]),memory_bytes=manifest["memory_hard_cap_bytes"],
        kernel_memory_limit_bytes=manifest["memory_hard_cap_bytes"]//4096*4096,cpu_percent=manifest["cpu_cap_percent"],breakaway_allowed=False,KILL_ON_JOB_CLOSE=True)
    if descriptor!=wanted:raise ValueError("Delegated exact Windows Job policy differs from the manifest")
    k=kernel();handle=k.OpenJobObjectW(4,False,descriptor["name"])
    if not handle:raise ctypes.WinError(ctypes.get_last_error())
    parent=None
    try:
        extended=Extended();rate=CPU()
        for cls,value in ((9,extended),(15,rate)):
            if not k.QueryInformationJobObject(handle,cls,ctypes.byref(value),ctypes.sizeof(value),None):raise ctypes.WinError(ctypes.get_last_error())
        if extended.JobMemory!=wanted["kernel_memory_limit_bytes"] or extended.Basic.Flags&0x2200!=0x2200 or extended.Basic.Flags&0x1800 or (rate.Flags,rate.Rate)!=(5,wanted["cpu_percent"]*100):
            raise ValueError("Actual named Windows Job limits are relaxed or allow breakaway")
        parent=k.OpenProcess(0x1000,False,ticket["owner_pid"])
        if not parent:raise ctypes.WinError(ctypes.get_last_error())
        for process in (k.GetCurrentProcess(),parent):
            belongs=W.BOOL()
            if not k.IsProcessInJob(process,handle,ctypes.byref(belongs)):raise ctypes.WinError(ctypes.get_last_error())
            if not belongs.value:raise ValueError("Child and reserving parent do not share the exact named resource Job")
        return dict(descriptor,child_and_exact_parent_membership_confirmed_by_OS=True)
    finally:
        if parent:k.CloseHandle(parent)
        k.CloseHandle(handle)
