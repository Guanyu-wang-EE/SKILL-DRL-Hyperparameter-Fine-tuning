# Risk And Cross-Validation

DRL HPO is high variance. A best trial is evidence, not a conclusion.

## Risk Register

| Risk | Symptom | Response |
|---|---|---|
| Noisy best trial | One trial is much better than neighbors | Re-run top N exact configs with seeds. |
| Seed overfitting | Config wins only on one seed | Require 3-10 seed statistics. |
| Validation leakage | Repeated tuning against the same validation slice | Keep final holdout scenarios. |
| Short-run illusion | Early high reward collapses later | Promote candidates to longrun. |
| Pruner bias | Slow starters are pruned too early | Use conservative pruning in early DRL stages. |
| Search-space bias | Ranges only confirm prior guesses | Keep Stage 1 broad enough to challenge baseline. |
| Metric mismatch | Reward rises but behavior is unusable | Track auxiliary diagnostics without changing objective unless requested. |
| Compute waste | Many trials before pipeline proof | Use Stage 0 and staged allocation. |
| Hidden method change | Tuning includes non-target mechanisms | Freeze or exclude non-target mechanisms and document them. |
| Artifact disorder | Missing configs or logs | Enforce trial artifact layout before long runs. |

## Cross-Validation Gates

| Gate | Minimum standard |
|---|---|
| Seed validation | Top configs rerun with at least 3 seeds; final claims often need 5-10. |
| Scenario validation | Evaluate on additional days, maps, tasks, regimes, or initial states. |
| Time-budget validation | Short-run winners must survive medium-run or longrun. |
| Basin validation | Top trials should be compared by parameter distance and curve shape. |
| Baseline validation | Tuned configs must be compared against original config under matched budget. |
| Holdout validation | Final holdout scenarios should be used sparingly for final claims. |

## Basin Similarity

For top trials, compare:

- Normalized numeric parameter distance.
- Categorical match rate.
- Reward mean, median, variance, and failure rate.
- Learning-curve stability and collapse events.
- Sensitivity to seeds and validation scenarios.

If top trials cluster, refine that basin. If they scatter, run separate local searches or exact seed reruns per basin.

## Decision Rules

- Top 1 without seed reruns is only a candidate best.
- Top N with similar parameters and stable seed statistics can move to longrun.
- A worse mean with lower variance may be preferable when the user values reliability.
- If the user only wants maximum reward, report reliability risks but optimize the stated reward.
- Do not add composite scores unless the user requests them.
- Do not claim final superiority without baseline, seed, and validation evidence.

## Anti-Patterns

Avoid:

- Running thousands of tiny trials with no seed confirmation.
- Tuning all parameters at once without grouping or constraints.
- Using an aggressive pruner before knowing learning-curve shapes.
- Reporting only the best trial number and reward.
- Losing trial configs, seeds, or failed-run logs.
- Mixing algorithm changes with hyperparameter tuning without labeling the comparison.

