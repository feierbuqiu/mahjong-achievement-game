"""The original Windows read-lock calls with one shared API wrapper.

Every original file handle is still independently acquired and retained. This
does not deduplicate paths, shorten custody, cache a verification result, or
change any access/share flag. Only Python wrapper allocation is shared.
Importing the module neither loads kernel32 nor opens a file.
"""
import ctypes
from ctypes import wintypes as W
import threading

_api = None
_api_lock = threading.Lock()


def _kernel32():
    global _api
    with _api_lock:
        if _api is None:
            candidate = ctypes.WinDLL("kernel32", use_last_error=True)
            candidate.CreateFileW.argtypes = [
                W.LPCWSTR, W.DWORD, W.DWORD, ctypes.c_void_p,
                W.DWORD, W.DWORD, W.HANDLE,
            ]
            candidate.CreateFileW.restype = W.HANDLE
            candidate.CloseHandle.argtypes = [W.HANDLE]
            _api = candidate
        return _api


class ReadLocks:
    """Deny writes/deletes until close, using exactly the original calls."""
    __slots__ = ("k", "handles")

    def __init__(self, paths):
        self.k = _kernel32()
        self.handles = []
        try:
            for path in paths:
                handle = self.k.CreateFileW(
                    str(path), 0x80000000, 1, None, 3, 0x80, None)
                if handle == ctypes.c_void_p(-1).value:
                    raise ctypes.WinError(ctypes.get_last_error())
                self.handles.append(handle)
        except Exception:
            self.close()
            raise

    def close(self):
        for handle in self.handles:
            self.k.CloseHandle(handle)
        self.handles = []
