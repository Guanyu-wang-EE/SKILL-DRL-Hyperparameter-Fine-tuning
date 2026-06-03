# Visualization And Reporting

Visualization is part of HPO evidence, not decoration.

## Live Dashboards

| Tool | Use |
|---|---|
| Optuna Dashboard | Local or workstation HPO with SQLite/RDB storage. |
| Ray Dashboard | Distributed trial scheduling and resource monitoring. |
| Weights & Biases | Collaborative experiment tracking and online plots. |
| MLflow | Structured experiment registry and artifact tracking. |
| TensorBoard | Training curves, losses, gradients, and scalar diagnostics. |

If a dashboard is promised, verify it returns an accessible URL or export equivalent HTML plots.

## Required Plots

For Optuna-like workflows, export when available:

- Optimization history.
- Parameter importance.
- Parallel coordinate plot.
- Slice plots for high-impact parameters.
- Contour or heatmap plots for important parameter pairs.
- Intermediate values or learning curves when trials report them.

For Ray/W&B/MLflow workflows, ensure equivalent views exist or export static summaries.

## Artifact Layout

A serious HPO run should preserve:

```text
experiment_root/
  stage_plan.json or stage_plan.md
  search_space.json
  optuna.db or external_storage_uri.txt
  dashboard_url.txt
  plots/
    optimization_history.html
    parameter_importance.html
    parallel_coordinate.html
    contour_*.html
  trials/
    trial_0000/
      trial_config.json
      trial_result.json
      train.log
      eval.log
      checkpoints/
  summaries/
    top_trials.csv
    seed_reruns.csv
    final_report.md
```

Use the project's existing artifact conventions when they are already clean and complete.

## Concise Final Report

Use this structure:

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

## What To Say When Evidence Is Incomplete

Use precise labels:

- `candidate best`: best observed trial, not seed-validated.
- `robust candidate`: survives multi-seed reruns.
- `longrun winner`: survives longer training.
- `validated best`: survives expanded validation against baseline.

Do not call a result final if the required gate has not been passed.

