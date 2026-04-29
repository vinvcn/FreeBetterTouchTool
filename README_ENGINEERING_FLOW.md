# ChromeWheelRouter 工程化节点流

这个包是对现有 `ChromeWheelRouter` Codex Cloud scaffold 的工程化增强。它的目的不是重新定义产品，而是把项目切成可执行、可验收、可发布的节点。

你作为项目 owner 只需要控制这些节点：

1. 打开对应节点 issue。
2. 让 Codex Cloud 执行。
3. 看 PR 中的 `node_report`、CI 结果和交付物。
4. 通过或驳回。
5. 到验收节点时，在你的 Mac 上安装 RC 包，按用例确认是否可用。

核心边界不变：

- 只做 Chrome。
- 只处理 `Chrome + Option-only + 水平滚轮`。
- 其他全部 pass-through。
- 不破坏 Logi Options+ 的裸水平滚轮行为。
- 不监听键盘事件。
- 不联网。
- 不做后台黑盒 daemon。

## 如何合入现有 repo

在你的 repo 根目录执行：

```bash
unzip ChromeWheelRouter-engineering-flow.zip
cp -R ChromeWheelRouter-engineering-flow/* .
git add .
git commit -m "docs: add engineering execution and acceptance flow"
git push
```

然后按 `project_control/engineering_nodes.md` 逐个开 issue。

## 主要文件

```text
project_control/engineering_nodes.md        # 节点总览，人类控制面板
project_control/node_dependency_graph.md    # 节点依赖关系
project_control/go_no_go_policy.md          # 每个节点怎么判定通过/不通过
ChromeWheelRouter/docs/development/codex_tasks/execution/*.md                  # Codex 执行节点 prompts
ChromeWheelRouter/docs/development/codex_tasks/acceptance/*.md                 # 验收节点 prompts 和人工确认协议
ChromeWheelRouter/docs/development/codex_tasks/release/*.md                    # 发布阶段规划 prompts
scripts/create_github_issues.sh             # 用 gh 批量创建节点 issue
templates/node_report.md                    # 每个 PR 必须填写的节点报告模板
templates/human_acceptance_report.md        # 你本机验收确认模板
gate_checklists/*.md                        # 节点 gate checklist
```
