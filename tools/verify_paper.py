#!/usr/bin/env python3
"""Check the English publication, GitHub math, numerical tables and source map."""
from pathlib import Path
from urllib.parse import unquote
import hashlib
import json
import re

ROOT = Path(__file__).resolve().parents[1]
PAPER = ROOT / "papers/manuscript.md"


def require(value, message):
    if not value:
        raise ValueError(message)


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def normalise(tex):
    # A literal pipe inside a GitHub table is written as the equivalent TeX macro.
    # GitHub currently rejects operatorname; upright function names preserve meaning.
    tex = re.sub(r"\\tag\{([^}]+)\}", lambda m: r"\qquad\text{(" + m[1] + ")}", tex)
    return re.sub(r"\s+", "", tex.replace(r"\vert ", "|").replace(r"\operatorname", r"\mathrm"))


def verify():
    text = PAPER.read_text(encoding="utf-8")
    provenance = json.loads((ROOT / "papers/provenance.json").read_text())
    expected = json.loads((ROOT / "papers/equations.json").read_text())
    require(provenance["primary_language"] == "en" and not provenance["chinese_manuscript_published"],
            "Only the English paper is authorised for this publication")
    require(sha(PAPER) == provenance["published_sha256"], "Paper differs from its publication provenance")
    require(expected["original_manuscript_sha256"] == provenance["original_sha256"], "Formula source identity changed")
    require(not re.search(r"\\[\[\]()]", text), "Legacy math delimiters remain")
    expressions = []
    pattern = re.compile(r"^```math\n(?P<display>.*?)\n```|\$`(?P<inline>.*?)`\$", re.M | re.S)
    for m in pattern.finditer(text):
        kind = m.lastgroup
        expressions.append({"kind": kind, "tex": normalise(m[kind])})
    expected_formulas = [{"kind": x["kind"], "tex": normalise(x["tex"])} for x in expected["formulas"]]
    require(expressions == expected_formulas, "Formula content or ordering changed during publication")
    require(r"\operatorname" not in text, "GitHub rejects the operatorname macro in this publication")
    require(len(expressions) == 370, "Unexpected paper formula count")
    for line in text.splitlines():
        if line.startswith("|"):
            for tex in re.findall(r"\$`(.*?)`\$", line):
                require("|" not in tex, "Unprotected pipe in a table formula")
    table_text = "\n".join(x for x in text.splitlines() if x.startswith("|"))
    table_text = re.sub(r"\[([^\]]+)\]\([^)]+\)", r"\1", table_text)
    numbers = re.findall(r"\d+(?:,\d{3})*(?:\.\d+)?", table_text)
    require(numbers == expected["table_numeric_tokens"], "A numerical table changed")
    require(r"\tag{" not in text, "Tagged MathML rows have an incompatible browser layout")
    require(re.findall(r"\\qquad\s*\\text\{\(([^)]+)\)\}", text) == expected["equation_tags"], "Equation labels changed")
    for state in re.findall(r"(?<!\d)[0-4]{34}(?!\d)", text):
        require(state in expected["physical_states"], "A physical state changed")
    sources = json.loads((ROOT / "papers/source-map.json").read_text())["sources"]
    for row in sources:
        if row["availability"] == "PUBLIC_COPY":
            path = (ROOT / row["published_path"]).resolve()
            require(path.is_relative_to(ROOT) and path.is_file(), f"Missing public source: {row['id']}")
            require(sha(path) == row["published_sha256"], f"Public evidence changed: {row['id']}")
            require(path.stat().st_size == row["published_bytes"], f"Public evidence size changed: {row['id']}")
    for path in (ROOT / "papers").rglob("*.md"):
        data = path.read_text(encoding="utf-8-sig")
        for url in re.findall(r"\]\(([^\s)]+)\)", data):
            if re.match(r"[a-zA-Z]+:", url) or url.startswith("#"):
                continue
            local = (path.parent / unquote(url.split("#", 1)[0])).resolve()
            require(local.is_relative_to(ROOT) and local.exists(), f"Broken paper link: {url}")
            if "#source-" in url:
                require("## " + url.split("#", 1)[1] in local.read_text(encoding="utf-8"), f"Missing evidence anchor: {url}")
    return {"status": "PASS", "formulas": len(expressions),
            "display_formulas": sum(x["kind"] == "display" for x in expressions),
            "inline_formulas": sum(x["kind"] == "inline" for x in expressions),
            "source_entries": len(sources), "primary_language": "en",
            "scope": "Publication integrity and GitHub math syntax; not a mathematical proof or browser rendering test"}


if __name__ == "__main__":
    print(json.dumps(verify()))
