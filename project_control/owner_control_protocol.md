# Owner Control Protocol

你作为 owner 不需要管理实现细节，只管理节点。

## 每个节点你的动作

1. 从 `codex_tasks/` 复制对应 prompt。
2. 在 GitHub 开 issue。
3. 指派 Codex Cloud 执行。
4. 等 Codex 提 PR。
5. 看 CI。
6. 看 `node_reports/EXEC-XX.md`。
7. 对照 gate checklist。
8. 决定 GO / NO-GO。

## Codex 每个节点必须做的动作

1. 读 `AGENTS.md`。
2. 读 `ai_context/`。
3. 读当前节点 prompt。
4. 不扩大 scope。
5. 修改代码/文档。
6. 运行检查。
7. 更新 `agent_state_harness/current_state.json`。
8. 新增 `node_reports/EXEC-XX.md`。
9. 提 PR。

## 你只看四类材料

```text
1. PR diff
2. CI check result
3. node report
4. human gate checklist
```

## PR 评价模板

```text
GO / NO-GO: 
Reason:
Required fixes:
Next node:
```

## 不要让 Codex 一次做多节点

每个 issue 只允许一个工程节点。多个节点混在一个 PR 里会让验收失焦。
