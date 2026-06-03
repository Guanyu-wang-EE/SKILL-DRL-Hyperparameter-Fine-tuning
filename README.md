# DRL Hyperparameter Tuning Skill

English | [Simplified Chinese](README.zh.md)

A compact Codex skill for planning and reviewing hyperparameter tuning in deep reinforcement learning (DRL).

It keeps HPO work practical: start with a baseline, search in stages, rerun top configs with multiple seeds, promote only robust candidates to long runs, and leave behind plots plus a short evidence trail.

## When To Use

Use this skill for HPO work around PPO, SAC, TD3, DDPG, DQN, A2C, recurrent RL, multi-agent RL, or LLM/PEFT-style RL setups.

It is useful for:

- designing a search space
- choosing Optuna, Ray Tune, W&B, MLflow, or TensorBoard
- setting staged trial budgets
- avoiding single-seed best-trial traps
- reviewing HPO evidence before reporting results
- writing a concise tuning report

## What It Emphasizes

- Clear objective and baseline
- Tiered search instead of tuning everything at once
- Stage 0 sanity checks before expensive runs
- Broad search, local refinement, seed reruns, and longrun validation
- Visual evidence through dashboards or exported HTML plots
- Honest language: candidate best until multi-seed and longrun evidence exist

## Layout

```text
SKILL.md
agents/openai.yaml
references/staging-protocol.md
references/search-space-taxonomy.md
references/risk-and-cross-validation.md
references/visualization-and-reporting.md
```

## Maintenance Note

Keep Git work in this standalone repository. Do not put `.git` inside the active Codex skills directory.
