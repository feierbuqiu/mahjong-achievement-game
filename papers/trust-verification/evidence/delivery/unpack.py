"""Safely unpack our regular-file tar.zst archives, without importing project code."""
import argparse
import json
import subprocess
import tarfile
from pathlib import Path


def main():
    p=argparse.ArgumentParser();p.add_argument('archive');p.add_argument('--output',required=True);a=p.parse_args()
    output=Path(a.output).resolve();output.mkdir(parents=True,exist_ok=True)
    process=None
    try:
        try:
            from compression import zstd
            stream=zstd.ZstdFile(a.archive,'r')
        except ImportError:
            try:
                import zstandard
                raw=open(a.archive,'rb');stream=zstandard.ZstdDecompressor().stream_reader(raw)
            except ImportError:
                process=subprocess.Popen(['zstd','-dc','--',a.archive],stdout=subprocess.PIPE)
                stream=process.stdout
        count=0
        with stream,tarfile.open(fileobj=stream,mode='r|') as archive:
            for member in archive:
                target=(output/member.name).resolve()
                if not target.is_relative_to(output) or not member.isfile():raise ValueError('Unsafe/nonregular archive member')
                target.parent.mkdir(parents=True,exist_ok=True)
                with archive.extractfile(member) as source,target.open('wb') as dest:
                    while chunk:=source.read(8*1024*1024):dest.write(chunk)
                target.chmod(member.mode & 0o777);count+=1
        if process is not None and process.wait()!=0:raise RuntimeError('zstd decoder failed')
        print(json.dumps(dict(status='UNPACKED_REGULAR_FILES',files=count,output=str(output))))
    finally:
        if process is not None and process.poll() is None:process.kill();process.wait()


if __name__=='__main__':main()
