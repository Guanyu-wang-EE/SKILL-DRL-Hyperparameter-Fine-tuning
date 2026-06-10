# DRL 超参数调优 Skill

[English](README.md) | 简体中文

Codex skill，用于规划和审查深度强化学习（Deep Reinforcement Learning, DRL）的超参数优化（Hyperparameter Optimization, HPO）。

它的目标很直接：先有 baseline，再分阶段搜索；top config 必须多 seed 复跑；只有稳健候选才进入 longrun；最后留下图、日志和简短证据链。

## 什么时候用

适用于 PPO、SAC、TD3、DDPG、DQN、A2C、recurrent RL、多智能体 RL，以及 LLM/PEFT 风格 RL 的超参数调优。

常见用途：

- 设计 search space
- 选择 Optuna、Ray Tune、W&B、MLflow 或 TensorBoard
- 规划分阶段 trial budget
- 避免单 seed best-trial 误判
- 汇报前审查 HPO 证据
- 写 tuning report

## 核心关注点

- 明确 objective 和 baseline
- 分层搜索，不一次性调所有参数
- 昂贵训练前先做 Stage 0 sanity check
- broad search、local refinement、seed rerun、longrun validation 分开做
- 用 dashboard 或 HTML plots 保留过程证据
- 表述要诚实：没有多 seed 和 longrun 前，只能叫 candidate best

## 结构

```text
SKILL.md
agents/openai.yaml
references/staging-protocol.md
references/search-space-taxonomy.md
references/risk-and-cross-validation.md
references/visualization-and-reporting.md
```

## 维护说明

Git 版本管理放在这个独立仓库里。不要把 `.git` 放进 Codex 正在读取的 skills 安装目录。
