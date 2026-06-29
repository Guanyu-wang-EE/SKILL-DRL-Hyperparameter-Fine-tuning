# Staging Protocol

Use staged allocation. Do not spend the full budget before the training loop, logging, objective, and validation protocol are proven.

## Stage 0: Sanity And Baseline

Purpose: prove the pipeline is runnable and the objective is measured correctly.

Minimum actions:

- Run the original config or a known baseline under a short budget.
- Run one dry-run or tiny trial that writes config, result, logs, and checkpoint paths.
- Confirm objective direction: maximize or minimize.
- Confirm failed trials are recorded, not silently ignored.
- Start or export at least one visualization target.

Typical budget:

| Compute | Trials | Training length |
|---|---:|---:|
| Laptop/CPU | 1-3 | tiny |
| Single GPU | 3-5 | short |
| Cluster | 5-10 | short |

## Stage 1: Broad Search

Purpose: find promising regions, not final winners.

Typical trial count:

| Compute | Trials |
|---|---:|
| Single GPU/workstation | 30-100 |
| Multi-GPU workstation | 100-300 |
| Small cluster | 300-1000 |
| Large cluster | 1000-5000 |

Rules:

- Keep ranges broad enough to challenge the baseline.
- Use shorter training than final confirmation.
- Prefer moderate pruning; aggressive pruning can kill slow-starting DRL configs.
- Track top N, not only top 1.

## Stage 1A/B/C: Basin Local Search

Purpose: refine representative top basins.

Procedure:

- Group top trials by parameter similarity and learning-curve behavior.
- Pick representative anchors from the strongest distinct basins.
- Run local search around each anchor with narrower ranges.
- Allocate the main budget to the strongest basin, but keep small challenger searches if top basins are close.

Do not run local search only around top 1 when top trials are noisy or scattered.

## Stage 2: Exact Config Multi-Seed

Purpose: test whether apparent winners survive randomness.

Default:

- Top 3-10 configs.
- 3-5 seeds for medium confidence.
- 5-10 seeds for final claims or high-variance tasks.

Report mean, median, standard deviation, min, max, and failure rate. Prefer median and lower-quantile behavior when reward has outliers.

## Stage 3: Longrun

Purpose: test whether short-run winners remain good under longer training.

Default:

- Promote top 1-3 robust configs.
- Increase training length substantially.
- Keep evaluation protocol unchanged at first.
- Compare against the original baseline under the same longrun budget when feasible.

If ranking reverses, trust longrun plus expanded validation over short-run HPO rank.

## Stage 4: Validation Expansion

Purpose: reduce overfitting to a small validation slice.

Expand one or more axes:

- Seeds.
- Days, maps, tasks, or scenarios.
- Demand profiles, market regimes, weather regimes, or domain-specific exogenous conditions.
- Initial states and stochastic environment settings.

Keep a final holdout set for limited-use confirmation when publication-quality claims matter.

## Stage N: Final Confirmation

Purpose: produce defensible evidence.

Required artifacts:

- Baseline vs tuned comparison.
- Top N table with seed statistics.
- Longrun curves.
- Expanded validation results.
- Search space and stage budgets.
- Visualization links or exported HTML.
- Clear statement of unsupported claims.

