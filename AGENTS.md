# AGENTS.md

## Purpose And Scope

This repository contains research code for DRL-based power-system optimization.
Before editing, inspect the relevant source files, configs, and tests.

Follow this file unless the user's explicit chat instruction overrides it. If nested
`AGENTS.md` files exist, the nearest `AGENTS.md` to the edited file has priority for
local rules, while this root file remains the default repository contract.

Use UTF-8 for all Markdown, Python, YAML, JSON, and CSV files containing Chinese text.
On Windows PowerShell, read Markdown with explicit UTF-8 encoding, about command, please read `agents/windows-codex-agent-prompt.md` for reference.

```powershell
Get-Content -LiteralPath "AGENTS.md" -Encoding UTF8
```

## Agent Operating Principles

- Inspect relevant files before making claims or edits.
- Prefer evidence from code, configs, tests, logs, and command output over assumptions.
- Do not invent file names, module names, APIs, config keys, datasets, metrics, plots, tables, or numerical results.
- Distinguish facts, assumptions, inferences, and recommendations when reporting technical conclusions.
- Keep changes scoped to the user's request and the relevant module boundary.
- Preserve existing user changes. Never revert unrelated work unless explicitly requested.
- Do not silently skip failed checks. Report the command, failure summary, and residual risk.
- Do not claim completion until relevant verification has been attempted, or explain why it could not be run.

## Repository Map

Update this section when the repository structure becomes clear.

- `src/`: source code, if present.
- `tests/`: unit, integration, regression, and smoke tests, if present.
- `configs/`: experiment and runtime configuration files, if present.
- `scripts/`: executable workflows such as training, evaluation, plotting, and data preparation, if present.
- `outputs/`, `runs/`, `logs/`, `checkpoints/`: generated artifacts. Do not edit or delete unless explicitly requested.
- `docs/`: documentation, algorithm specs, design notes, and reproduction records, if present.

Before creating a new file named in a task or spec, first check whether an equivalent
module, helper, config, or test already exists.

## General Workflow

For implementation tasks:

1. Read the relevant source files, tests, configs, and recent errors before editing.
2. Identify existing patterns and follow them.
3. State any necessary assumption before relying on it.
4. Edit only the necessary files.
5. Add or update tests when behavior changes.
6. Run the narrowest relevant verification first, then broader checks if needed.
7. Report changed files, commands run, pass/fail status, and remaining risks.

For debugging tasks:

1. Reproduce or localize the failure first.
2. Identify the smallest failing case that explains the symptom.
3. Inspect stack traces, tensor shapes, logs, configs, and recent changes.
4. Fix the root cause, not only the visible symptom.
5. Add a regression test when practical.
6. Re-run the failing command and report the evidence.

For research and experiment tasks:

1. Do not change experiment definitions, random seeds, reward formulas, benchmark settings, or case-study assumptions unless explicitly requested.
2. Do not fabricate numerical results, convergence claims, plots, tables, or paper statements.
3. Keep generated artifacts traceable to commands, configs, seeds, and code versions.
4. For DRL training changes, run a smoke test when feasible or explain why it was not run.

## Stop And Ask Before

- Deleting datasets, logs, checkpoints, trained models, result CSVs, or generated plots.
- Running long training jobs or expensive sweeps.
- Changing reward definitions, benchmark settings, random seeds, or paper reproduction assumptions.
- Adding major dependencies or replacing established libraries.
- Rewriting large parts of the architecture.
- Making irreversible filesystem or git changes.

## Verification Commands

Use commands that match the actual repository. Prefer targeted checks first.

Common Python checks:

```powershell
python -m compileall src scripts
pytest -q
```

Targeted Python checks:

```powershell
pytest tests/test_<name>.py -q
```

DRL smoke checks, if matching scripts exist:

```powershell
python scripts/train.py --config configs/smoke.yaml --max-steps 1000
python scripts/evaluate.py --checkpoint <path> --episodes 2
```

If a command does not exist in this repository, do not invent success. Report that the
command is unavailable and use the closest real check.

## Definition Of Done

A task is complete only when:

- The requested behavior is implemented or the requested analysis is delivered.
- Relevant files were inspected rather than guessed.
- Relevant tests or checks passed, or failures are clearly reported.
- No unrelated files were modified.
- The final response lists changed files, verification commands, results, and residual risks.
- Any unverified claim is explicitly marked as unverified.



