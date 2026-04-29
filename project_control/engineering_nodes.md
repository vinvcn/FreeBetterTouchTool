# ChromeWheelRouter 工程化节点总览

## 控制原则

你不需要盯每一行实现。你只控制节点。

每个节点必须有：

- 明确输入
- Codex Cloud 任务
- PR 交付物
- 自动检查
- 人类检查点
- Go / No-Go 标准
- 下一节点触发条件

任何节点如果不满足 gate，不进入下一节点。

---

# P0. Project Definition / 项目定义

**状态：已完成**

## 已确定范围

- 产品：`ChromeWheelRouter`
- 平台：macOS
- 形态：菜单栏 App，后续可打包为 DMG
- MVP：Chrome 中 `Option + 水平滚轮` 控制页面 zoom
- 非目标：不做 BetterTouchTool 复刻，不做无影云电脑，不做全局鼠标系统
- 安全边界：不监听 keyDown/keyUp，不联网，不改 Chrome/Logi/macOS 配置

## Project Definition Done

- `ChromeWheelRouter/docs/specs/`
- `AGENTS.md`
- `agent_state_harness/`
- `ChromeWheelRouter/docs/qa/mvp_user_flow_harness/`
- 纯 routing core 初始测试

---

# Execution Nodes / 执行节点

这些节点由 Codex Cloud 执行，你控制 PR 是否通过。

## EXEC-01 — Baseline Hardening / 基线加固

**目标**：把 scaffold 变成一个可持续开发的工程基线。

**Codex 输入**：`ChromeWheelRouter/docs/development/codex_tasks/execution/EXEC-01-baseline-hardening.md`

**交付物**：

- CI 可跑 `swift test`
- safety smoke test 可跑
- `AGENTS.md` 与 safety constraints 对齐
- 每个 PR 必须包含 `ChromeWheelRouter/docs/development/node_reports/EXEC-01.md`

**自动 gate**：

- `swift test`
- `scripts/check_static_safety.sh`
- `agent_state_harness` validate
- `mvp_user_flow_harness` validate

**人类 gate**：

- 你确认 scope 没扩大
- 你确认禁止项没有被弱化

**通过后进入**：EXEC-02

---

## EXEC-02 — Routing Core Completion / 路由核心完成

**目标**：把纯逻辑规则做完整，并锁死 pass-through 约束。

**Codex 输入**：`ChromeWheelRouter/docs/development/codex_tasks/execution/EXEC-02-routing-core.md`

**交付物**：

- `ChromeWheelRouterCore` 完整 routing model
- 方向、modifier、Chrome bundle id、disabled mode 的单元测试
- 回归测试：`Chrome + no modifier + horizontal scroll = passThrough`

**自动 gate**：

- 单元测试覆盖所有 flow fixtures
- 无 macOS event tap 实现
- 无键盘监听代码

**人类 gate**：

- 你确认核心行为表正确

**通过后进入**：EXEC-03

---

## EXEC-03 — macOS Event Tap CLI Spike / macOS 事件监听 CLI 验证

**目标**：先用 CLI 验证 event tap 链路，不做 UI。

**Codex 输入**：`ChromeWheelRouter/docs/development/codex_tasks/execution/EXEC-03-event-tap-cli-spike.md`

**交付物**：

- `ChromeWheelRouterCLI`
- `--listen-only`
- `--dry-run`
- `--active`
- 只监听 `scrollWheel`
- 其他事件全部放行

**自动 gate**：

- event mask 静态检查：只包含 `scrollWheel`
- 不出现 `keyDown` / `keyUp`
- 不出现网络 API
- `swift test`

**人类 gate**：

- 你本机可运行 CLI
- `--dry-run` 下不会吞事件
- Chrome 裸水平滚轮仍由 Logi Options+ 处理

**通过后进入**：EXEC-04

---

## EXEC-04 — Chrome Zoom Injection / Chrome 缩放注入

**目标**：让匹配事件真实触发 Chrome 页面 zoom。

**Codex 输入**：`ChromeWheelRouter/docs/development/codex_tasks/execution/EXEC-04-chrome-zoom-injection.md`

**交付物**：

- `KeyboardInjector`
- zoom in: `Cmd + =`
- zoom out: `Cmd + -`
- 匹配事件 `return nil`
- 非匹配事件 `return original event`

**自动 gate**：

- routing tests 全通过
- static safety 全通过
- injection path 只包含 zoom 两个快捷键

**人类 gate**：

- Chrome + Option + 水平滚轮缩放
- Chrome + 裸水平滚轮仍按 Logi 原行为
- 非 Chrome 无影响

**通过后进入**：EXEC-05

---

## EXEC-05 — Menu Bar MVP / 菜单栏 App MVP

**目标**：把 CLI 能力包进可日常使用的菜单栏 App。

**Codex 输入**：`ChromeWheelRouter/docs/development/codex_tasks/execution/EXEC-05-menu-bar-mvp.md`

**交付物**：

- `ChromeWheelRouter.app`
- 菜单栏图标
- Enable / Disable
- Dry Run
- Open Logs
- Quit
- 状态显示

**自动 gate**：

- App 可 build
- core tests 通过
- static safety 通过

**人类 gate**：

- 菜单栏可见
- Enable / Disable 生效
- Quit 后进程消失

**通过后进入**：EXEC-06

---

## EXEC-06 — Permission UX and Fail-Closed / 权限 UX 与安全失败

**目标**：权限缺失时不乱跑，给用户明确指引。

**Codex 输入**：`ChromeWheelRouter/docs/development/codex_tasks/execution/EXEC-06-permission-ux.md`

**交付物**：

- Accessibility 检查
- Input Monitoring 状态指引
- Open System Settings 菜单项
- 权限缺失时 fail closed，不创建 active event tap
- 文档更新

**自动 gate**：

- 权限缺失状态不会 crash
- 无额外权限需求
- tests 通过

**人类 gate**：

- 首次启动能明确提示权限
- 授权后能启用
- 未授权状态不会影响系统

**通过后进入**：EXEC-07

---

## EXEC-07 — Runtime Safety Controls / 运行时安全控制

**目标**：让程序可控、可停、可恢复。

**Codex 输入**：`ChromeWheelRouter/docs/development/codex_tasks/execution/EXEC-07-runtime-safety.md`

**交付物**：

- Disable 状态下完全 pass-through
- Kill switch 文件支持
- SIGTERM / SIGINT 干净退出
- 轻量日志
- callback 内无 IO / no blocking
- tap timeout 处理

**自动 gate**：

- static safety 通过
- 禁止 callback IO 的静态检查
- tests 通过

**人类 gate**：

- Disable 后所有行为恢复
- Quit 后无后台进程
- 杀进程后鼠标恢复原样

**通过后进入**：EXEC-08

---

## EXEC-08 — Dev Install / Uninstall / 开发安装卸载

**目标**：先做到本地可安装、可卸载，不碰系统级目录。

**Codex 输入**：`ChromeWheelRouter/docs/development/codex_tasks/execution/EXEC-08-dev-install-uninstall.md`

**交付物**：

- `scripts/install_dev.sh`
- `scripts/uninstall_dev.sh`
- 安装到 `~/Applications` 或 `/Applications` 的明确模式
- 删除 app/config/logs
- 不使用 sudo
- 不写 LaunchDaemons

**自动 gate**：

- 安装脚本静态检查：无 sudo、无 `/Library/LaunchDaemons`
- 卸载脚本幂等
- docs 更新

**人类 gate**：

- 本机 install 成功
- uninstall 后文件清理干净
- 权限撤销步骤清楚

**通过后进入**：EXEC-09

---

## EXEC-09 — RC Packaging / 可验收包构建

**目标**：生成给你安装验收的 RC 包。

**Codex 输入**：`ChromeWheelRouter/docs/development/codex_tasks/execution/EXEC-09-rc-packaging.md`

**交付物**：

- `dist/ChromeWheelRouter-v0.1.0-rc1.dmg`
- `dist/SHA256SUMS`
- `dist/build_manifest.json`
- `ChromeWheelRouter/docs/product/INSTALL.md`
- `ChromeWheelRouter/docs/product/UNINSTALL.md`
- `SECURITY.md`
- `ChromeWheelRouter/docs/product/TROUBLESHOOTING.md`

**自动 gate**：

- DMG 构建成功
- checksum 生成
- CI artifact 上传
- static safety 通过
- test report 生成

**人类 gate**：

- 你拿到 DMG
- 文档足够你安装、启用、卸载

**通过后进入**：ACCEPT-01

---

# Acceptance Nodes / 验收节点

这些节点不是 Codex 自己说“好了”就算好。最终必须由你在你的 Mac 上确认。

## ACCEPT-01 — Acceptance Bundle Review / 验收包审查

**目标**：确认 RC 包和测试证据完整。

**输入**：EXEC-09 产物

**你需要看到**：

- DMG
- checksum
- build manifest
- automated test report
- safety report
- install/uninstall 文档
- manual QA checklist

**通过后进入**：ACCEPT-02

---

## ACCEPT-02 — Local Installation / 本机安装验收

**目标**：你在自己的 Mac 上安装。

**输入**：RC DMG

**你执行**：

- 安装 App
- 打开 App
- 授权必要权限
- Enable
- 确认菜单栏状态

**通过标准**：

- 可以安装
- 可以启动
- 权限引导清楚
- 不 crash
- 不影响其他 App

**通过后进入**：ACCEPT-03

---

## ACCEPT-03 — Human Functional QA / 人类功能验收

**目标**：确认它在你的真实设备上可用。

**你执行**：`templates/human_acceptance_report.md`

**核心用例**：

- Chrome 裸水平滚轮：仍由 Logi Options+ 处理
- Chrome + Option + 水平滚轮：页面 zoom
- 非 Chrome：无影响
- Disable：全部恢复 pass-through
- Quit：全部恢复原状
- Uninstall：文件清理干净

**通过标准**：

- 你填写 `human_acceptance_report.md`
- 所有 P0/P1 用例通过
- 你明确写下：`Human accepted on my Mac: yes`

**通过后进入**：ACCEPT-04

---

## ACCEPT-04 — Defect Loop or Acceptance Signoff / 缺陷循环或验收签字

**如果失败**：

- 记录 defect
- 分类到对应 Execution Node
- 让 Codex 修复
- 重新出 RC
- 重新验收

**如果通过**：

- 打 tag：`v0.1.0-rc1-human-accepted`
- 冻结 MVP scope
- 进入 Release Planning

---

# Release Nodes / 发布节点

发布阶段下一步再做，但流程先留好。

## REL-01 — Release Strategy

决定：

- 只发 DMG，还是 DMG + PKG
- 是否公开 GitHub Release
- 是否需要 Developer ID 签名
- 是否需要 notarization

## REL-02 — Signing and Notarization

决定：

- 是否有 Apple Developer ID
- GitHub Actions secrets 如何管理
- unsigned dev build 和 signed release build 如何区分

## REL-03 — Public Release Automation

决定：

- 版本号策略
- changelog
- release notes
- checksums
- rollback

