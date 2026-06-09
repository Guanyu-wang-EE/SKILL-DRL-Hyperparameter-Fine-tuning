# Windows Codex Patch Prompt

English-only operational prompt for Codex agents on Windows. Read this only when you need to apply manual patches, diagnose `apply_patch` failures, or handle PowerShell/UTF-8/Markdown patch edge cases.

`AGENTS.md` owns general repository behavior: scope control, evidence, UTF-8 reading, verification, and final reporting. Do not duplicate those rules here. This file only covers Windows patch transport and parser failure modes.

## Core Decision

Never assume the `apply_patch` found on `PATH` is safe on Windows. Prefer the project-local PowerShell wrapper.

Wrapper locations:

```text
This skill repo: agents/apply_patch_windows.ps1
This skill repo: agents/apply_patch.bat
Typical target repo copy: tools/apply_patch_windows.ps1
Typical target repo copy: tools/apply_patch.bat
```

Decision table:

| Situation | Use | Avoid |
|---|---|---|
| Multi-line patch | `apply_patch_windows.ps1 -PatchFile patch.diff` | `.bat` inline args |
| Markdown patch with fences/checklists | `-PatchFile` | pipeline into `.bat` |
| Patch contains non-ASCII text | `-PatchFile` with explicit UTF-8 file | implicit shell encoding |
| Tiny ASCII-only patch | `apply_patch_windows.ps1 -PatchText $patch` | global shim unless inspected |
| Need a `.bat` entry point | `.bat -PatchFile patch.diff` only | `.bat -PatchText`, pasted multiline args |
| Error mentions 740/elevation/UAC | Treat as permission boundary | patch syntax debugging loops |

## Stable Recipes

Use the wrapper path that exists in the current repository.

Preferred patch-file transport:

```powershell
.\agents\apply_patch_windows.ps1 -PatchFile .\patch.diff
```

If wrappers were copied to `tools/` in a target repo:

```powershell
.\tools\apply_patch_windows.ps1 -PatchFile .\patch.diff
```

Batch launcher, only for patch files:

```powershell
.\agents\apply_patch.bat -PatchFile .\patch.diff
```

Small inline patch through PowerShell wrapper:

```powershell
$nl = [string][char]10
$patch = [string]::Join($nl, @(
  '*** Begin Patch',
  '*** Update File: README.md',
  '@@',
  '-old text',
  '+new text',
  '*** End Patch',
  ''
))
.\agents\apply_patch_windows.ps1 -PatchText $patch
```

The final empty string is deliberate. It creates a trailing newline after `*** End Patch`.

Pipeline transport is second choice, not first choice:

```powershell
$patch | .\agents\apply_patch_windows.ps1
```

Use pipeline transport only when `$patch` is already one complete UTF-8 string and the patch does not depend on fragile shell quoting.

## Failure Classifier

Use this classifier before retrying. Retrying the same transport usually repeats the same failure.

### `--codex-run-as-apply-patch requires a UTF-8 PATCH argument`

Likely cause: PowerShell-to-batch forwarding damaged a multi-line patch before Codex received it.

Action: switch from global `apply_patch` or `.bat` inline transport to `apply_patch_windows.ps1 -PatchFile`.

### `Patch text must end with *** End Patch`

Likely cause: missing trailing newline, truncated stdin, or shell parsing removed the final line.

Action: rebuild the patch as one string with a final empty line, or use a UTF-8 patch file.

### Markdown line rejected near a code fence

Likely cause: unchanged Markdown fence line was not prefixed with the patch context space.

Action: ensure unchanged fence/context lines start with one leading space in the diff body.

### Checklist deletion behaves strangely

Likely cause: Markdown checklist lines begin with `-`, so deletion needs two leading minus signs.

Original line:

```markdown
- [ ] run test
```

Deletion line in patch:

```diff
-- [ ] run test
```

### `CreateProcessAsUserW failed: 740`, `elevation`, or `UAC`

Likely cause: Windows permission boundary or Codex sandbox boundary. This is not a diff-format error.

Action: do not edit temporary shims, do not use `Start-Process -Verb RunAs`, and do not claim a wrapper bypasses UAC. Use the current runtime's approved elevation path if one is available. If it is unavailable, report the blocker.

## Windows-Specific Causes

`Get-Command apply_patch` may resolve to a temporary Codex `apply_patch.bat` shim. That shim usually forwards `%*` to `codex.exe --codex-run-as-apply-patch`.

This path is fragile because there are multiple parsers in sequence:

```text
PowerShell parser -> cmd.exe/batch parser -> Codex shim -> patch parser
```

Each layer can alter newlines, quotes, backticks, percent signs, Markdown fences, checklist lines, bracket syntax, or non-ASCII content. A project-local PowerShell wrapper reduces those transformations by passing one normalized patch string to Codex.

Do not make a permanent system `PATH` change to hide this problem. If short commands matter for one session, only prepend the wrapper directory to the current PowerShell process:

```powershell
$env:PATH = "D:\BaiduSyncdisk\wgy\MATD3_4agent_new\tools;$env:PATH"
```

## Markdown Patch Rules Worth Remembering

Patch body line prefixes are semantic:

```text
space = unchanged context
+     = added line
-     = removed line
@@    = hunk marker
```

Therefore:

```diff
 ```powershell
```

means an unchanged Markdown fence line. Without the leading context space, the fence can be parsed as invalid patch structure.

For unchanged text that begins with diff-like characters, still add the context space:

```diff
 @@ this is literal Markdown text, not a hunk marker
 +this is literal Markdown text, not an added line
 -this is literal Markdown text, not a removed line
 ```
```

## Wrapper Smoke Test

Run this only when wrapper scripts changed or when a patch failure suggests the wrapper itself is broken.

```powershell
$nl = [string][char]10
$patch = [string]::Join($nl, @(
  '*** Begin Patch',
  '*** Add File: .codex-wrapper-smoke-test.txt',
  '+created by wrapper smoke test',
  '*** End Patch',
  ''
))
.\agents\apply_patch_windows.ps1 -PatchText $patch

$patch = [string]::Join($nl, @(
  '*** Begin Patch',
  '*** Delete File: .codex-wrapper-smoke-test.txt',
  '*** End Patch',
  ''
))
.\agents\apply_patch_windows.ps1 -PatchText $patch
```

The repository should not keep smoke-test files after the check.

## Mental Model

The patch content is the payload. The shell is only transport. On Windows, most failures are transport failures, not edit-intent failures. Change the transport first; change the patch content only after you have ruled out encoding, quoting, newline, and sandbox boundaries.
