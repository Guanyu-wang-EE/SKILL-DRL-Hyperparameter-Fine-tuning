---
name: drl-hyperparameter-tuning
description: Use when planning, implementing, auditing, or reporting hyperparameter optimization for deep reinforcement learning algorithms such as PPO, SAC, TD3, DDPG, DQN, A2C, recurrent RL, or multi-agent RL.
---

# DRL Hyperparameter Tuning

## Hard Gates

- Do not recommend a search space before identifying algorithm, environment, objective, budget, seed policy, and validation protocol.
- Do not claim an optimal hyperparameter set from a single lucky trial or from training metrics without validation/test evidence.
- Preserve reproducibility: fixed seeds, trial logs, search configuration, hardware/runtime notes, and failure records must be explicit when available.
- Do not add .git, .gitignore, README files, or __pycache__ to the live installed skill folder.

## Reference Routing

| Task | Load or run |
|---|---|
| Define DRL search space | references/search-space-taxonomy.md |
| Plan staged tuning | references/staging-protocol.md |
| Audit overfitting or validation risk | references/risk-and-cross-validation.md |
| Prepare figures or concise report | references/visualization-and-reporting.md |
| Final recommendation or readiness claim | references/final-quality-gates.md |
| Edit or install this skill | Run the commands under Verification |

## Verification

After editing this skill itself, run:

- python C:\Users\Admin\.codex\skills\.system\skill-creator\scripts\quick_validate.py <this skill folder>
- python C:\Users\Admin\.codex\skills\.system\skill-creator\scripts\audit_skill.py <this skill folder> --strict

## Overview

Use this skill to design scientifically defensible hyperparameter optimization (HPO) for deep reinforcement learning (DRL). The default objective is to maximize the user's stated reward or metric, while preventing noisy best-trial conclusions through staged search, seed checks, longruns, and visual evidence.

Do not bind the plan to any project-specific algorithm variant, pretraining method, reward shaping detail, or domain convention unless the user explicitly asks for it.

## Initial Diagnosis

Before proposing or changing an HPO setup, inspect the project and identify:

- Algorithm family: PPO, SAC, TD3, DDPG, DQN, A2C, recurrent RL, multi-agent RL, model-based RL, or hybrid.
- Objective: maximize mean reward, validation reward, success rate, risk-adjusted score, or a user-defined metric.
- Action and observation spaces: discrete, continuous, mixed, constrained, recurrent, partially observable.
- Existing baseline: original config, previous best config, seeds, validation split, training budget, and logs.
- Training interface: config source, train command, checkpointing, evaluation function, result files, and failure modes.
- Compute context: local CPU/GPU, multi-GPU workstation, cluster, cloud, wall-clock constraints, and allowed parallelism.

If source files are available, read them before assuming which parameters exist or matter.

## Tool Selection

Prefer the simplest tool that fits the compute setting:

| Setting | Preferred tools | Notes |
|---|---|---|
| Local or single workstation | Optuna + Optuna Dashboard | Best default for flexible Python projects and staged search. |
| Multi-GPU or cluster | Ray Tune + ASHA/PBT + optional Optuna searcher | Use when scheduling, resource allocation, and concurrent trials dominate. |
| Collaborative experiment tracking | Weights & Biases or MLflow | Use for shared dashboards, artifacts, and paper records. |
| Training curves only | TensorBoard | Useful companion, not a full HPO controller. |

Use SQLite for local Optuna studies unless concurrency requires a stronger backend. Use Ray storage or a robust database for distributed runs.

## Mandatory Workflow

1. Define the objective and baseline.
2. Build a tiered search space; freeze irrelevant or non-target mechanisms.
3. Run Stage 0 sanity checks before expensive tuning.
4. Run Stage 1 broad search to find multiple candidate basins.
5. Compare top trials by reward, parameter similarity, curve stability, and failure rate.
6. Run local refinement around representative top basins, not only the single best trial.
7. Re-run exact top configs with multiple seeds.
8. Promote only robust configs to longrun.
9. Expand validation scenarios before final claims.
10. Export web or HTML visualizations and a concise report.

For detailed stage budgets, read `references/staging-protocol.md`.

## Search Space Rules

- Tune high-impact algorithm parameters first: learning rates, discount/advantage parameters, entropy/exploration, update ratios, batch/rollout sizes, target networks, replay settings, and recurrent structure.
- Use log scale for learning rates, entropy temperatures, noise magnitudes, and regularization strengths when orders of magnitude matter.
- Use categorical choices for architecture sizes, layer counts, batch regimes, horizon lengths, and discrete schedules.
- Encode parameter constraints explicitly, for example `minibatch <= rollout_batch`, warmup lengths within training budget, and end values not exceeding start values when schedules decay.
- Avoid tuning every possible parameter in one broad run. Group parameters by expected impact and interaction risk.

For algorithm-specific parameter taxonomies, read `references/search-space-taxonomy.md`.

## Risk And Cross-Validation Gate

Never treat a single high-scoring DRL trial as final. Before recommending a best config, check:

```text
[ ] Objective and optimization direction are explicit.
[ ] Baseline config is reproducible under the same budget.
[ ] Every trial saves config, result, seed, logs, and failure status.
[ ] Search space records ranges, units, scales, and categorical choices.
[ ] Broad search and local search are separated.
[ ] Top trials are compared by parameter similarity and curve stability.
[ ] Exact top configs are re-run with multiple seeds.
[ ] Longrun is performed for the strongest robust candidates.
[ ] Validation scenarios are expanded before final claims.
[ ] Dashboard or exported HTML plots are available.
```

For risk patterns, anti-patterns, and decision gates, read `references/risk-and-cross-validation.md`.

## Visualization Requirements

Every serious HPO run should provide process visibility:

- Live dashboard: Optuna Dashboard, Ray Dashboard, W&B, MLflow, or equivalent.
- Exported HTML plots: optimization history, parameter importance, parallel coordinate, slice plots, and contour/heatmap views for important parameter pairs.
- Artifact layout: stage plan, search space, trial configs, trial results, logs, checkpoints, database/storage URI, exported plots, and final summary.

For visualization and reporting templates, read `references/visualization-and-reporting.md`.

## Decision Rules

- If top 1 has not been re-run with seeds, call it `candidate best`, not final best.
- If top trials cluster in parameter space and multi-seed reward is stable, promote that basin to longrun.
- If top trials are scattered, split them into basins and re-run representative configs.
- If local search cannot beat broad search, keep the broad best and analyze whether the local range was too narrow.
- If longrun reverses rankings, trust longrun plus expanded validation over short-run HPO rank.
- If visualization is not accessible or exported, do not claim process visualization is complete.

## Concise Report Contract

Use this structure unless the user asks otherwise:

```markdown
## A. Direct Conclusion
- Best config:
- Best validated reward:
- Baseline comparison:
- Recommendation:

## B. Evidence
- Stage budgets:
- Search space:
- Top N trials:
- Multi-seed result:
- Longrun result:
- Visualization links:

## C. Risks And Next Actions
- Remaining risks:
- Next run:
- Claims not yet supported:
```

## PEFT / LLM-RL Extension

Use only when the policy, reward model, critic, world model, or assistant model is a pretrained Transformer or LLM.

Additional tunable parameters:
- LoRA rank: r
- LoRA alpha
- LoRA dropout
- target modules: q_proj, k_proj, v_proj, o_proj, mlp layers
- quantization: 4-bit, 8-bit, bf16
- adapter placement
- gradient checkpointing
- KL penalty / reference model settings for RLHF-style optimization

Validation requirements:
- Compare PEFT vs frozen baseline vs full fine-tuning when feasible.
- Run multi-seed checks because LoRA rank and RL reward noise can interact.
- Track adapter size, GPU memory, wall-clock time, reward, and downstream evaluation.
