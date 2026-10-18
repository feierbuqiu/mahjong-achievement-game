"""Temporary per-thread sleep inhibition; no display or persistent power edit."""
import ctypes

POLICY="TEMPORARY_SYSTEM_REQUIRED_UNTIL_INVOCATION_EXIT_NO_DISPLAY_REQUEST"

class SystemAwake:
    def __init__(self,api=None):self.api=api;self.active=False
    def __enter__(self):
        if self.api is None:
            self.api=ctypes.WinDLL("kernel32",use_last_error=True).SetThreadExecutionState
            self.api.argtypes=[ctypes.c_ulong];self.api.restype=ctypes.c_ulong
        if not self.api(0x80000001):raise OSError("Temporary SYSTEM_REQUIRED request failed")
        self.active=True;return self
    def __exit__(self,*args):
        if self.active:
            self.active=False
            if not self.api(0x80000000):raise OSError("Temporary system sleep request could not be explicitly released")

