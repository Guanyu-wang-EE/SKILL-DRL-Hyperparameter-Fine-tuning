# DRL Hyperparameter Tuning Skill

A staged hyperparameter optimization skill for deep reinforcement learning studies, with seed checks, validation gates, and reporting discipline.

This repository is the Git-backed source mirror for the skill. Repository documentation belongs here; installed runtime copies should stay lean and contain only files needed for execution.

## What It Does

- Designs bounded search spaces for PPO, SAC, TD3, DDPG, DQN, A2C, recurrent RL, and multi-agent RL.
- Separates broad search, local refinement, multi-seed reruns, long runs, and validation scenarios.
- Prevents single lucky trial conclusions by requiring stability and evidence checks.

## When To Use

Use this skill when the task matches the description in `SKILL.md`. Read `SKILL.md` first, then follow its routing table before opening references, scripts, assets, or indexed resources.

Typical use cases:

- Identify algorithm, objective, budget, seeds, baseline, and training interface.
- Route to the search-space, staging, risk, visualization, or final-gates reference as needed.
- Promote only robust configurations supported by reruns and validation evidence.

## Repository Contents

- `references/`
- `SKILL.md`

## Operating Contract

- Do not recommend ranges before the algorithm and objective are known.
- Do not call a configuration best from training reward alone.
- Record missing validation, failed trials, and seed sensitivity explicitly.

## Validation And Review

- Check `SKILL.md` frontmatter before changing skill discovery metadata.
- Keep `## Hard Gates`, `## Reference Routing`, and `## Verification` aligned with the actual files in this repository.
- If a `references/final-quality-gates.md` file exists, use it before any final, ready, published, submitted, or complete claim.
- If a skill-specific audit script exists, run it after changing routed files or deterministic helpers.

## Maintenance Notes

- Keep `SKILL.md` as the entry point and router.
- Keep detailed domain material in `references/` when the skill has reference files.
- Keep deterministic helpers in `scripts/` or `tools/` and validate them after edits.
- Update `README.md` and `README_zh.md` together so both languages describe the same scope and gates.
- Do not move repository-only documentation into installed runtime copies.

## Language Parity

`README_zh.md` is the Simplified Chinese counterpart of this file. When one README changes, update the other in the same commit.
