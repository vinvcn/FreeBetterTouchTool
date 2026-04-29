# 节点依赖图

```text
P0 Project Definition [DONE]
   |
   v
EXEC-01 Baseline Hardening
   |
   v
EXEC-02 Routing Core Completion
   |
   v
EXEC-03 Event Tap CLI Spike
   |
   v
EXEC-04 Chrome Zoom Injection
   |
   v
EXEC-05 Menu Bar MVP
   |
   v
EXEC-06 Permission UX / Fail Closed
   |
   v
EXEC-07 Runtime Safety Controls
   |
   v
EXEC-08 Dev Install / Uninstall
   |
   v
EXEC-09 RC Packaging
   |
   v
ACCEPT-01 Acceptance Bundle Review
   |
   v
ACCEPT-02 Local Installation
   |
   v
ACCEPT-03 Human Functional QA
   |
   v
ACCEPT-04 Human Signoff or Defect Loop
   |
   v
REL-01 Release Strategy
   |
   v
REL-02 Signing / Notarization
   |
   v
REL-03 Public Release Automation
```

## 缺陷回流规则

```text
验收发现 routing 逻辑错误       -> 回 EXEC-02
验收发现 event tap 不稳定       -> 回 EXEC-03 / EXEC-04
验收发现菜单栏控制问题          -> 回 EXEC-05
验收发现权限或安全失败问题      -> 回 EXEC-06 / EXEC-07
验收发现安装卸载问题            -> 回 EXEC-08
验收发现 DMG 或文档问题         -> 回 EXEC-09
```

## 不允许跳过的节点

- EXEC-02：否则 pass-through 约束没有测试基础。
- EXEC-03：否则直接上菜单栏 App，调试成本太高。
- EXEC-07：否则没有 kill switch / fail-safe。
- ACCEPT-03：否则没有人类确认版本。
