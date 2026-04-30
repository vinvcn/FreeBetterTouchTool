#!/usr/bin/env python3
"""Run a quality gate from harness/quality_gates.yml."""

from __future__ import annotations

import argparse
import os
from pathlib import Path
import shlex
import shutil
import subprocess
import sys


ROOT = Path(__file__).resolve().parents[1]
MANIFEST = ROOT / "harness" / "quality_gates.yml"


def _unquote(value: str) -> str:
    value = value.strip()
    if len(value) >= 2 and value[0] == value[-1] and value[0] in {"'", '"'}:
        return value[1:-1]
    return value


def load_manifest(path: Path) -> dict:
    if not path.exists():
        raise ValueError(f"quality gate manifest not found: {path}")

    manifest: dict = {"gates": {}, "manual": {"required": []}}
    current_section: str | None = None
    current_gate: str | None = None
    current_key: str | None = None

    for line_number, raw_line in enumerate(path.read_text(encoding="utf-8").splitlines(), 1):
        stripped = raw_line.strip()
        if not stripped or stripped.startswith("#"):
            continue

        indent = len(raw_line) - len(raw_line.lstrip(" "))
        if indent % 2 != 0:
            raise ValueError(f"{path}:{line_number}: indentation must use two-space levels")

        if indent == 0:
            if stripped == "gates:":
                current_section = "gates"
                current_gate = None
                current_key = None
            elif stripped == "manual:":
                current_section = "manual"
                current_gate = None
                current_key = None
            elif stripped.startswith("version:"):
                manifest["version"] = int(stripped.split(":", 1)[1].strip())
            else:
                raise ValueError(f"{path}:{line_number}: unsupported top-level entry: {stripped}")
            continue

        if current_section == "gates":
            if indent == 2 and stripped.endswith(":"):
                current_gate = stripped[:-1]
                manifest["gates"][current_gate] = {}
                current_key = None
            elif indent == 4 and current_gate:
                key, separator, value = stripped.partition(":")
                if not separator:
                    raise ValueError(f"{path}:{line_number}: expected gate key")
                current_key = key
                if value.strip():
                    manifest["gates"][current_gate][key] = _unquote(value.strip())
                else:
                    manifest["gates"][current_gate][key] = []
            elif indent == 6 and current_gate and current_key and stripped.startswith("- "):
                value = _unquote(stripped[2:])
                target = manifest["gates"][current_gate].setdefault(current_key, [])
                if not isinstance(target, list):
                    raise ValueError(f"{path}:{line_number}: cannot append list item to scalar key")
                target.append(value)
            else:
                raise ValueError(f"{path}:{line_number}: unsupported gate manifest entry")
            continue

        if current_section == "manual":
            if indent == 2 and stripped == "required:":
                current_key = "required"
            elif indent == 4 and current_key == "required" and stripped.startswith("- "):
                manifest["manual"]["required"].append(_unquote(stripped[2:]))
            else:
                raise ValueError(f"{path}:{line_number}: unsupported manual gate entry")
            continue

        raise ValueError(f"{path}:{line_number}: entry is outside a supported section")

    if manifest.get("version") != 1:
        raise ValueError(f"unsupported quality gate manifest version: {manifest.get('version')!r}")
    return manifest


def command_executable(command: str) -> str:
    try:
        tokens = shlex.split(command)
    except ValueError as exc:
        raise ValueError(f"invalid command syntax {command!r}: {exc}") from exc

    while tokens and "=" in tokens[0] and not tokens[0].startswith("="):
        name, _, _ = tokens[0].partition("=")
        if not name or any(ch in name for ch in "/."):
            break
        tokens.pop(0)

    if not tokens:
        raise ValueError(f"missing executable in command: {command!r}")
    return tokens[0]


def preflight_command(command: str) -> None:
    executable = command_executable(command)
    if executable.startswith("./") or executable.startswith("../") or "/" in executable:
        path = (ROOT / executable).resolve() if not executable.startswith("/") else Path(executable)
        if not path.exists():
            raise ValueError(f"missing command executable for {command!r}: {path}")
        if not os.access(path, os.X_OK):
            raise ValueError(f"command is not executable for {command!r}: {path}")
    elif shutil.which(executable) is None:
        raise ValueError(f"missing command executable for {command!r}: {executable}")


def run_gate(name: str, manifest: dict) -> int:
    if name == "manual":
        return run_manual_gate(manifest)

    gates = manifest["gates"]
    if name not in gates:
        available = ", ".join(sorted([*gates, "manual"]))
        print(f"unknown quality gate: {name}", file=sys.stderr)
        print(f"available gates: {available}", file=sys.stderr)
        return 2

    gate = gates[name]
    commands = gate.get("commands", [])
    if not isinstance(commands, list) or not commands:
        print(f"quality gate {name!r} has no commands", file=sys.stderr)
        return 2

    try:
        for command in commands:
            preflight_command(command)
    except ValueError as exc:
        print(f"quality gate manifest error: {exc}", file=sys.stderr)
        return 2

    print(f"quality gate: {name}")
    purpose = gate.get("purpose")
    if purpose:
        print(f"purpose: {purpose}")

    for command in commands:
        print(f"+ {command}", flush=True)
        completed = subprocess.run(command, cwd=ROOT, shell=True)
        if completed.returncode != 0:
            print(f"quality gate {name!r} failed on command: {command}", file=sys.stderr)
            return completed.returncode

    artifacts = gate.get("required_artifacts", [])
    missing = [artifact for artifact in artifacts if not (ROOT / artifact).exists()]
    if missing:
        for artifact in missing:
            print(f"missing required artifact: {artifact}", file=sys.stderr)
        return 1

    print(f"quality gate {name}: OK")
    return 0


def run_manual_gate(manifest: dict) -> int:
    required = manifest.get("manual", {}).get("required", [])
    if not isinstance(required, list) or not required:
        print("quality gate manifest error: manual gate has no required checks", file=sys.stderr)
        return 2

    print("quality gate: manual")
    print("required human validation:")
    for item in required:
        print(f"- {item}")
    print("quality gate manual: listed")
    return 0


def main() -> int:
    parser = argparse.ArgumentParser(description="Run a ChromeWheelRouter quality gate.")
    parser.add_argument("gate", help="Gate name from harness/quality_gates.yml")
    args = parser.parse_args()

    try:
        manifest = load_manifest(MANIFEST)
    except ValueError as exc:
        print(f"quality gate manifest error: {exc}", file=sys.stderr)
        return 2

    return run_gate(args.gate, manifest)


if __name__ == "__main__":
    raise SystemExit(main())
