"""Bound native CRT filenames before starting either proposer or checker."""
from pathlib import Path
import campaign_io as c

LIMIT=239
SUFFIXES=("", ".tmp", ".labels.bin", ".labels.bin.tmp")
POLICY=dict(schema="SHORT_NATIVE_OUTPUT_PATH_POLICY_V5",maximum_absolute_UTF16_units=LIMIT,
    native_output_relative_to_research_root=True,staging="t/16hex/w.json",rank_absent_from_native_filename=True)

def units(value):return len(str(value).encode("utf-16-le"))//2

def check(output):
    output=Path(output).resolve();relative=c.rel(output)
    for suffix in SUFFIXES:
        if units(str(output)+suffix)>LIMIT or units(relative+suffix)>LIMIT:
            raise InterruptedError("NATIVE_OUTPUT_PATH_EXCEEDS_SAFE_LIMIT before any GPU/native request: "+str(output)+suffix)
    return relative

def preflight(folder):return check(folder/"t"/("0"*16)/"w.json")

def attempt(folder,token):
    if len(token)!=32 or any(x not in "0123456789abcdef" for x in token):raise ValueError("Exact random attempt token required")
    directory=folder/"t"/token[:16];check(directory/"w.json")
    directory.mkdir(parents=True,exist_ok=False)
    return directory
