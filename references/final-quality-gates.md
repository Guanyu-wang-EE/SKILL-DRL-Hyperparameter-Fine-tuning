# Final Quality Gates

Use before declaring a DRL hyperparameter study, recommendation, or report complete.

- Problem, algorithm, environment, reward/objective, constraints, budget, seeds, and hardware/runtime assumptions are explicit.
- Search space and staging decisions are traceable to search-space-taxonomy.md and staging-protocol.md.
- Best-trial claims include validation or test evidence, not only training reward.
- Overfitting, seed sensitivity, early stopping, and failed trials are reported or explicitly unavailable.
- Figures/tables follow visualization-and-reporting.md and include units, axes, trial counts, and uncertainty where available.
- Final answer states unchecked gates instead of presenting an incomplete study as tuned.
