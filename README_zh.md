# DRL Hyperparameter Tuning 技能

<p align="right"><a href="README.md">English</a> | <strong>简体中文</strong></p>

一个面向深度强化学习研究的分阶段超参数优化技能，强调随机种子检查、验证门与报告纪律。

本仓库是该技能的 Git 源镜像。仓库文档保留在这里；安装后的运行副本应保持精简，只包含执行所需文件。

## 功能范围

- 为 PPO、SAC、TD3、DDPG、DQN、A2C、循环 RL 与多智能体 RL 设计有边界的搜索空间。
- 区分广泛搜索、局部细化、多随机种子复跑、长训练与验证场景。
- 通过稳定性与证据检查，避免把单个幸运 trial 当作最终结论。

## 使用场景

当任务与 SKILL.md 中的描述匹配时使用该技能。先阅读 SKILL.md，再按照其中的路由表打开 references、scripts、assets 或索引资源。

典型使用场景：

- 识别算法、目标、预算、随机种子、基线和训练接口。
- 按需路由到搜索空间、分阶段协议、风险、可视化或最终质量门参考文件。
- 只提升由复跑和验证证据支持的稳健配置。

## 仓库内容

- `references/`
- `SKILL.md`

## 运行契约

- 在算法与目标明确前，不推荐参数范围。
- 不能只凭训练奖励就称某配置为最佳。
- 明确记录缺失验证、失败 trial 与随机种子敏感性。

## 验证与复查

- 修改技能发现元数据前，先检查 SKILL.md frontmatter。
- 保持 Hard Gates、Reference Routing 与 Verification 和仓库实际文件一致。
- 如果存在 references/final-quality-gates.md，在任何最终、就绪、发布、提交或完成声明前使用它。
- 如果存在技能专用审计脚本，修改路由文件或确定性辅助程序后运行它。

## 维护说明

- 保持 SKILL.md 作为入口和路由器。
- 如果技能包含参考文件，将详细领域材料保存在 references/ 中。
- 将确定性辅助程序放在 scripts/ 或 tools/ 中，并在修改后验证。
- 同步更新 README.md 与 README_zh.md，确保两种语言描述相同的范围与质量门。
- 不要把仅属于仓库的文档移动到安装后的运行副本。

## 语言一致性

README.md 是本文档的英文对应版本。任一 README 变更时，应在同一个提交中同步更新另一种语言版本。
