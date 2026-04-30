# HARNESS-05 Summary

Added machine-checkable node report evidence for PR gates.

New node reports should include a fenced `json node-report` block whose fields
match `templates/node_report.schema.json`. The validator
`scripts/check_node_report.py` checks required fields, required command evidence,
safety invariant coverage, changed-file coverage, scope/state explanations, and
manual-validation heuristics.

The Autopilot Gate now validates changed node reports on pull requests with:

```bash
python3 scripts/check_node_report.py --base "origin/${{ github.base_ref }}" --head HEAD
```

Legacy node reports are not retroactively converted by this node. New or changed
reports must use the structured evidence block.
