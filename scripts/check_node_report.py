#!/usr/bin/env python3
"""Validate structured node report evidence blocks.

New node reports should include a fenced JSON block with an info string that
contains "node-report". The block is validated against the repository schema and
against PR-specific changed-file heuristics.
"""

from __future__ import annotations

import argparse
import json
from pathlib import Path
import re
import subprocess
import sys
from typing import Any


ROOT = Path(__file__).resolve().parents[1]
NODE_REPORT_DIR = ROOT / "ChromeWheelRouter" / "docs" / "development" / "node_reports"
SCHEMA_PATH = ROOT / "templates" / "node_report.schema.json"
NODE_REPORT_PREFIX = "ChromeWheelRouter/docs/development/node_reports/"

REQUIRED_COMMANDS = (
    "python3 scripts/run_gate.py fast",
    "./scripts/check_all.sh",
)

REQUIRED_INVARIANTS = {
    "no_key_down_key_up_listeners",
    "no_network_or_telemetry",
    "no_chrome_or_logi_config_access",
    "no_root_privileged_helper_or_system_daemon",
    "unmatched_events_pass_through",
}

MANUAL_VALIDATION_PATHS = (
    "Sources/ChromeWheelRouterApp/",
    "Sources/ChromeWheelRouterCLI/",
    "Sources/ChromeWheelRouterMac/",
    "scripts/install_dev.sh",
    "scripts/uninstall_dev.sh",
    "scripts/package_rc.sh",
    "ChromeWheelRouter/docs/acceptance/",
    "ChromeWheelRouter/docs/product/",
)

SCOPE_CHANGE_PATHS = (
    "ChromeWheelRouter/docs/specs/scope.md",
    "ChromeWheelRouter/docs/specs/product_scope.md",
    "ChromeWheelRouter/docs/specs/product_decisions.md",
)


class ValidationError(Exception):
    pass


def fail(message: str) -> None:
    print(f"node report check failed: {message}", file=sys.stderr)
    sys.exit(1)


def run_git(args: list[str]) -> list[str]:
    completed = subprocess.run(
        ["git", *args],
        cwd=ROOT,
        text=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        check=False,
    )
    if completed.returncode != 0:
        raise ValidationError(completed.stderr.strip() or f"git {' '.join(args)} failed")
    return [line for line in completed.stdout.splitlines() if line]


def changed_files(base: str | None, head: str) -> list[str]:
    if base:
        return run_git(["diff", "--name-only", f"{base}...{head}"])
    return run_git(["diff", "--name-only", "HEAD"])


def node_reports_from_changed_files(files: list[str]) -> list[Path]:
    reports: list[Path] = []
    for path in files:
        if path.startswith(NODE_REPORT_PREFIX) and path.endswith(".md"):
            reports.append(ROOT / path)
    return sorted(set(reports))


def structured_reports() -> list[Path]:
    reports: list[Path] = []
    for path in sorted(NODE_REPORT_DIR.glob("*.md")):
        if "node-report" in path.read_text(encoding="utf-8"):
            reports.append(path)
    return reports


def extract_evidence(path: Path) -> dict[str, Any]:
    text = path.read_text(encoding="utf-8")
    pattern = re.compile(r"```(?P<info>[^\n`]*)\n(?P<body>.*?)\n```", re.DOTALL)
    for match in pattern.finditer(text):
        info = match.group("info").strip().lower()
        if "node-report" not in info:
            continue
        try:
            evidence = json.loads(match.group("body"))
        except json.JSONDecodeError as exc:
            raise ValidationError(f"{path}: node-report JSON is malformed: {exc}") from exc
        if not isinstance(evidence, dict):
            raise ValidationError(f"{path}: node-report block must be a JSON object")
        return evidence
    raise ValidationError(f"{path}: missing fenced JSON node-report evidence block")


def validate_type(path: Path, value: Any, schema: dict[str, Any], location: str = "node_report") -> None:
    expected_type = schema.get("type")
    if expected_type == "object":
        if not isinstance(value, dict):
            raise ValidationError(f"{path}: {location} must be an object")
        for key in schema.get("required", []):
            if key not in value:
                raise ValidationError(f"{path}: missing required field {location}.{key}")
        properties = schema.get("properties", {})
        for key, child in properties.items():
            if key in value:
                validate_type(path, value[key], child, f"{location}.{key}")
    elif expected_type == "array":
        if not isinstance(value, list):
            raise ValidationError(f"{path}: {location} must be an array")
        min_items = schema.get("minItems")
        if min_items is not None and len(value) < min_items:
            raise ValidationError(f"{path}: {location} must contain at least {min_items} item(s)")
        item_schema = schema.get("items")
        if item_schema:
            for index, item in enumerate(value):
                validate_type(path, item, item_schema, f"{location}[{index}]")
    elif expected_type == "string":
        if not isinstance(value, str):
            raise ValidationError(f"{path}: {location} must be a string")
        if schema.get("minLength", 0) > 0 and not value.strip():
            raise ValidationError(f"{path}: {location} must not be empty")
    elif expected_type == "boolean":
        if not isinstance(value, bool):
            raise ValidationError(f"{path}: {location} must be a boolean")


def validate_semantics(path: Path, evidence: dict[str, Any], changed: list[str] | None) -> None:
    node_id = evidence["node_id"]
    if path.stem != node_id:
        raise ValidationError(f"{path}: node_id must match filename stem {path.stem!r}")

    commands = {item["command"]: item for item in evidence["commands_run"]}
    for command in REQUIRED_COMMANDS:
        if command not in commands:
            raise ValidationError(f"{path}: missing required command evidence: {command}")
        if commands[command]["result"].strip().lower() in {"", "missing", "not run"}:
            raise ValidationError(f"{path}: command {command!r} must include a concrete result")

    invariants = {item["invariant"]: item for item in evidence["safety_invariants_checked"]}
    missing_invariants = REQUIRED_INVARIANTS - set(invariants)
    if missing_invariants:
        raise ValidationError(f"{path}: missing safety invariants: {', '.join(sorted(missing_invariants))}")
    unchecked = [name for name in REQUIRED_INVARIANTS if not invariants[name]["checked"]]
    if unchecked:
        raise ValidationError(f"{path}: safety invariants are not checked: {', '.join(sorted(unchecked))}")

    if changed is not None:
        changed_set = set(changed)
        report_files = set(evidence["changed_files"])
        missing_files = sorted(
            item
            for item in changed_set
            if item != str(path.relative_to(ROOT)) and item not in report_files
        )
        if missing_files:
            raise ValidationError(f"{path}: changed_files omits PR changes: {', '.join(missing_files)}")

        manual_required = any(item.startswith(MANUAL_VALIDATION_PATHS) for item in changed_set)
        if manual_required and not evidence["manual_validation_required"]["required"]:
            raise ValidationError(f"{path}: changed files require manual validation, but report says none required")

        current_state_changed = "agent_state_harness/current_state.json" in changed_set
        if current_state_changed != evidence["state_updates"]["current_state_json_changed"]:
            raise ValidationError(f"{path}: current_state.json change status is not accurately reported")

        scope_paths_changed = any(item in changed_set for item in SCOPE_CHANGE_PATHS)
        if scope_paths_changed and not evidence["scope_change"]["changed"]:
            raise ValidationError(f"{path}: scope/source-of-truth changed without scope_change statement")

    if not evidence["artifacts"]:
        raise ValidationError(f"{path}: artifacts must include at least the node report path or changed evidence")


def validate_reports(reports: list[Path], changed: list[str] | None) -> None:
    schema = json.loads(SCHEMA_PATH.read_text(encoding="utf-8"))
    for report in reports:
        if not report.exists():
            raise ValidationError(f"missing node report: {report}")
        evidence = extract_evidence(report)
        validate_type(report, evidence, schema)
        validate_semantics(report, evidence, changed)


def main() -> int:
    parser = argparse.ArgumentParser(description="Validate structured node report evidence.")
    parser.add_argument("--base", help="Base ref for PR changed-file validation.")
    parser.add_argument("--head", default="HEAD", help="Head ref for PR changed-file validation.")
    parser.add_argument("--all", action="store_true", help="Validate all structured node reports.")
    args = parser.parse_args()

    try:
        if args.base:
            changed = changed_files(args.base, args.head)
            reports = node_reports_from_changed_files(changed)
            if not reports:
                raise ValidationError(
                    f"PR changes must include a node report under {NODE_REPORT_PREFIX}"
                )
            validate_reports(reports, changed)
        else:
            reports = structured_reports()
            if not reports:
                raise ValidationError("no structured node reports found")
            validate_reports(reports, None if args.all else changed_files(None, args.head))
    except ValidationError as exc:
        fail(str(exc))

    print(f"node report checks: OK ({len(reports)} report(s))")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
