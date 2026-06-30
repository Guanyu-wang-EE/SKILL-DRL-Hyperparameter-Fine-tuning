# DRL Hyperparameter Tuning Skill

<p align="right"><strong>English</strong> | <a href="README_zh.md">简体中文</a></p>

A staged hyperparameter optimization skill for deep reinforcement learning studies, with seed checks, validation gates, and reporting discipline.

This repository is the Git-backed source mirror for the skill. Repository documentation belongs here; lean installed runtime copies should contain only files needed by the skill itself.

## Table Of Contents

- [Purpose](#purpose)
- [Repository Map](#repository-map)
- [How To Use](#how-to-use)
- [Core Contracts](#core-contracts)
- [Resource Index](#resource-index)
- [Validation Commands](#validation-commands)
- [Maintenance Notes](#maintenance-notes)
- [Language Parity](#language-parity)

## Purpose

Use this skill when the task matches the description in [`SKILL.md`](SKILL.md). Read `SKILL.md` first, then follow its routing before opening references, scripts, or assets.

Primary capabilities:

- Designs bounded search spaces for PPO, SAC, TD3, DDPG, DQN, A2C, recurrent RL, and multi-agent RL.
- Separates broad search, local refinement, multi-seed reruns, long runs, and validation scenarios.
- Prevents single lucky trial conclusions by requiring stability and evidence checks.

## Repository Map

| Path | Role |
|---|---|
| [`SKILL.md`](SKILL.md) | Entry point, hard gates, routing, and verification guidance |
| [`references/`](references/) | Task-specific reference files loaded through `SKILL.md` routing |
| [`README.md`](README.md) | English repository navigation |
| [`README_zh.md`](README_zh.md) | Simplified Chinese repository navigation |

## How To Use

1. Open [`SKILL.md`](SKILL.md).
2. Use its reference routing table to load only the task-relevant files.
3. Run the deterministic helper or validation command that matches the artifact under review.
4. Before any final, ready, published, submitted, or complete claim, check final gates when the skill provides them.

## Core Contracts

- Do not recommend ranges before the algorithm and objective are known.
- Do not call a configuration best from training reward alone.
- Record missing validation, failed trials, and seed sensitivity explicitly.

## Resource Index

### References

| File | Role |
|---|---|
| [`final-quality-gates.md`](references/final-quality-gates.md) | See file for task-specific behavior and constraints |
| [`risk-and-cross-validation.md`](references/risk-and-cross-validation.md) | See file for task-specific behavior and constraints |
| [`search-space-taxonomy.md`](references/search-space-taxonomy.md) | See file for task-specific behavior and constraints |
| [`staging-protocol.md`](references/staging-protocol.md) | See file for task-specific behavior and constraints |
| [`visualization-and-reporting.md`](references/visualization-and-reporting.md) | See file for task-specific behavior and constraints |

## Validation Commands

Run checks that match the files changed:

```bash
python path/to/quick_validate.py .
```

## Maintenance Notes

- Keep [`SKILL.md`](SKILL.md) short and route details to references when the skill has them.
- Update README files when hard gates, references, scripts, or expected outputs change.
- Keep repository-only documentation in this Git mirror, not in lean installed runtime copies.
- Update [`README.md`](README.md) and [`README_zh.md`](README_zh.md) in the same commit.

## Language Parity

[`README_zh.md`](README_zh.md) is the Simplified Chinese counterpart of this file. The two READMEs should have the same sections, claims, gates, commands, and maintenance expectations.

