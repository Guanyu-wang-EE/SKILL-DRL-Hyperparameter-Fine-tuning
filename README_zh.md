# DRL Hyperparameter Tuning 技能

<p align="right"><a href="README.md">English</a> | <strong>简体中文</strong></p>

一个面向深度强化学习研究的分阶段超参数优化技能，强调随机种子检查、验证门与报告纪律。

本仓库是该技能的 Git 源镜像。仓库文档保留在这里；精简的安装运行副本只应包含技能本身执行所需文件。

## 目录

- [用途](#用途)
- [仓库地图](#仓库地图)
- [如何使用](#如何使用)
- [核心契约](#核心契约)
- [资源索引](#资源索引)
- [验证命令](#验证命令)
- [维护说明](#维护说明)
- [语言一致性](#语言一致性)

## 用途

当任务与 [`SKILL.md`](SKILL.md) 中的描述匹配时使用该技能。先阅读 `SKILL.md`，再按照其中路由打开 references、scripts 或 assets。

主要能力：

- 为 PPO、SAC、TD3、DDPG、DQN、A2C、循环 RL 与多智能体 RL 设计有边界的搜索空间。
- 区分广泛搜索、局部细化、多随机种子复跑、长训练与验证场景。
- 通过稳定性与证据检查，避免把单个幸运 trial 当作最终结论。

## 仓库地图

| 路径 | 作用 |
|---|---|
| [`SKILL.md`](SKILL.md) | 入口、硬门、路由与验证说明 |
| [`references/`](references/) | 通过 `SKILL.md` 路由加载的任务参考文件 |
| [`README.md`](README.md) | 英文仓库导航 |
| [`README_zh.md`](README_zh.md) | 简体中文仓库导航 |

## 如何使用

1. 打开 [`SKILL.md`](SKILL.md)。
2. 按其中 reference routing 表只加载与任务相关的文件。
3. 对当前产物运行匹配的确定性辅助脚本或验证命令。
4. 在任何最终、就绪、发布、提交或完成声明前，若技能提供 final gates，必须先检查。

## 核心契约

- 在算法与目标明确前，不推荐参数范围。
- 不能只凭训练奖励就称某配置为最佳。
- 明确记录缺失验证、失败 trial 与随机种子敏感性。

## 资源索引

### 参考文件

| 文件 | 作用 |
|---|---|
| [`final-quality-gates.md`](references/final-quality-gates.md) | 查看该文件中的任务约束与行为规则 |
| [`risk-and-cross-validation.md`](references/risk-and-cross-validation.md) | 查看该文件中的任务约束与行为规则 |
| [`search-space-taxonomy.md`](references/search-space-taxonomy.md) | 查看该文件中的任务约束与行为规则 |
| [`staging-protocol.md`](references/staging-protocol.md) | 查看该文件中的任务约束与行为规则 |
| [`visualization-and-reporting.md`](references/visualization-and-reporting.md) | 查看该文件中的任务约束与行为规则 |

## 验证命令

根据变更文件运行匹配检查：

```bash
python path/to/quick_validate.py .
```

## 维护说明

- 保持 [`SKILL.md`](SKILL.md) 精简；如果技能包含 references，把细节路由到 references。
- 当 hard gates、references、scripts 或预期产物发生变化时，同步更新 README。
- 仅把仓库文档保留在该 Git 镜像中，不放入精简安装运行副本。
- 在同一提交中同步更新 [`README.md`](README.md) 与 [`README_zh.md`](README_zh.md)。

## 语言一致性

[`README.md`](README.md) 是本文档的英文对应版本。两份 README 应拥有相同章节、声明、质量门、命令与维护预期。

