#!/usr/bin/env python3
"""Check that quality gate wiring stays consistent across repo entry points."""

from __future__ import annotations

from pathlib import Path
import sys

from run_gate import MANIFEST, load_manifest, preflight_command


ROOT = Path(__file__).resolve().parents[1]


def read(path: str) -> str:
    full_path = ROOT / path
    if not full_path.exists():
        raise AssertionError(f"missing required file: {path}")
    return full_path.read_text(encoding="utf-8")


def require_contains(path: str, needle: str) -> None:
    content = read(path)
    if needle not in content:
        raise AssertionError(f"{path} must contain {needle!r}")


def main() -> int:
    try:
        manifest_text = read("harness/quality_gates.yml")
        manifest = load_manifest(MANIFEST)
        for gate in ("fast", "integration", "release"):
            if gate not in manifest["gates"]:
                raise AssertionError(f"harness/quality_gates.yml missing gate: {gate}")
        if "manual:" not in manifest_text or not manifest["manual"].get("required"):
            raise AssertionError("harness/quality_gates.yml missing manual required gate entries")
        for gate_name, gate in manifest["gates"].items():
            commands = gate.get("commands", [])
            if not commands:
                raise AssertionError(f"harness/quality_gates.yml gate has no commands: {gate_name}")
            for command in commands:
                preflight_command(command)

        require_contains("scripts/check_all.sh", "python3 scripts/run_gate.py fast")
        require_contains(".github/workflows/ci.yml", "python3 scripts/run_gate.py integration")
        require_contains(".github/workflows/autopilot-gate.yml", "python3 scripts/run_gate.py integration")
    except AssertionError as exc:
        print(f"harness consistency check failed: {exc}", file=sys.stderr)
        return 1

    print("harness consistency checks: OK")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
