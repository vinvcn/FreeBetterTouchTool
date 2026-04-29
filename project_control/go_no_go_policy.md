# Go / No-Go Policy

## 基本规则

每个节点只有两个结果：

- **GO**：满足自动 gate 和人类 gate，进入下一节点。
- **NO-GO**：不合格，留在当前节点或回退。

不要用“差不多能用”进入下一节点。这个项目是输入事件工具，模糊验收会把风险放大。

## 自动 gate 必须通过

任何节点只要以下任一项失败，自动 NO-GO：

- `swift test` 失败
- static safety 失败
- 出现 `keyDown` / `keyUp` 监听
- 出现网络 API
- 出现 telemetry
- 安装脚本需要 `sudo`
- 写入 `/Library/LaunchDaemons`、`/System`、`/Library/PrivilegedHelperTools`
- 非匹配事件没有原样 pass-through

## 人类 gate 必须通过

以下情况自动 NO-GO：

- Chrome 裸水平滚轮不再按 Logi Options+ 原行为工作
- Disable 后仍影响鼠标行为
- Quit 后仍有进程或输入影响
- 卸载后残留启动项
- 权限文档不清楚
- 你无法在本机复现安装和使用流程

## PR 合并规则

每个 Codex PR 必须包含：

- 对应 node report：`ChromeWheelRouter/docs/development/node_reports/EXEC-XX.md`
- 测试结果摘要
- 改动范围摘要
- 安全约束确认
- 人类验证步骤

没有 node report，不合并。

## Scope Creep 拦截

以下改动一律拒绝，除非另开 Project Definition 变更节点：

- 支持其他 App
- 支持任意快捷键配置
- 支持全局鼠标手势
- 支持无影云电脑
- 支持 Action Ring
- 支持网络同步配置
- 支持 telemetry / analytics
- 监听键盘事件
- 自动修改 Logi Options+ 配置
