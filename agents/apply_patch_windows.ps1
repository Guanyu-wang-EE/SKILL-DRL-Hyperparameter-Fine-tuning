# ============================================================================
# Purpose: Stable Windows wrapper for Codex apply_patch invocation.
# Environment: Windows PowerShell 5+; Codex desktop/CLI with codex.exe installed.
# Inputs: -PatchFile, -PatchText, remaining argument text, or UTF-8 stdin.
# Outputs: Delegates to codex.exe --codex-run-as-apply-patch.
# Reproducibility: Normalizes line endings and avoids temporary apply_patch.bat.
# Assumptions: This wrapper does not bypass UAC/sandbox elevation barriers.
# ============================================================================

[CmdletBinding()]
param(
    [Parameter(Mandatory = $false)]
    [string]$PatchFile,

    [Parameter(Mandatory = $false)]
    [string]$PatchText,

    [Parameter(Mandatory = $false, ValueFromPipeline = $true)]
    [AllowNull()]
    [string]$PipelineInput,

    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$RemainingArguments
)

$ErrorActionPreference = 'Stop'

$utf8NoBom = [System.Text.UTF8Encoding]::new($false)
$OutputEncoding = $utf8NoBom
[Console]::InputEncoding = $utf8NoBom
[Console]::OutputEncoding = $utf8NoBom

$pipelineItems = @($input)
$pipelineText = $null
if ($pipelineItems.Count -gt 0) {
    $pipelineText = [string]::Join([string][char]10, @($pipelineItems | ForEach-Object { [string]$_ }))
}

function Resolve-CodexExecutable {
    if ($env:CODEX_EXE -and (Test-Path -LiteralPath $env:CODEX_EXE)) {
        return (Resolve-Path -LiteralPath $env:CODEX_EXE).Path
    }

    $candidate = Join-Path $env:LOCALAPPDATA 'Programs\Codex-patched\resources\codex.exe'
    if (Test-Path -LiteralPath $candidate) {
        return (Resolve-Path -LiteralPath $candidate).Path
    }

    $cmd = Get-Command codex.exe -ErrorAction SilentlyContinue
    if ($cmd -and $cmd.Source) {
        return $cmd.Source
    }

    throw 'Cannot locate codex.exe. Set CODEX_EXE to the full codex.exe path.'
}

function Read-PatchText {
    param([AllowNull()][string]$PipelineText)

    if ($PatchFile) {
        $resolved = (Resolve-Path -LiteralPath $PatchFile).Path
        return [System.IO.File]::ReadAllText($resolved, $utf8NoBom)
    }

    if ($PatchText) {
        return $PatchText
    }

    if ($RemainingArguments -and $RemainingArguments.Count -gt 0) {
        return [string]::Join(' ', $RemainingArguments)
    }

    if (-not [string]::IsNullOrEmpty($PipelineText)) {
        return $PipelineText
    }

    return [Console]::In.ReadToEnd()
}

$patch = Read-PatchText -PipelineText $pipelineText
if ([string]::IsNullOrWhiteSpace($patch)) {
    throw 'No patch text was provided. Use -PatchFile, -PatchText, or pipe UTF-8 stdin.'
}

$patch = $patch.Replace([string][char]13 + [string][char]10, [string][char]10)
$patch = $patch.Replace([string][char]13, [string][char]10)
$patch = $patch.TrimEnd()

if (-not $patch.Contains('*** Begin Patch')) {
    throw 'Patch text is missing *** Begin Patch.'
}

if (-not $patch.EndsWith('*** End Patch')) {
    throw 'Patch text must end with *** End Patch after trailing whitespace is removed.'
}

$codexExe = Resolve-CodexExecutable

function ConvertTo-WindowsArgument {
    param([AllowNull()][string]$Argument)

    $quote = [char]34
    $slash = [char]92

    if ($null -eq $Argument) {
        return [string]$quote + [string]$quote
    }

    if ($Argument.Length -eq 0) {
        return [string]$quote + [string]$quote
    }

    $needsQuotes = $false
    foreach ($ch in $Argument.ToCharArray()) {
        if ([char]::IsWhiteSpace($ch) -or $ch -eq $quote) {
            $needsQuotes = $true
            break
        }
    }

    if (-not $needsQuotes) {
        return $Argument
    }

    $sb = [System.Text.StringBuilder]::new()
    [void]$sb.Append($quote)
    $backslashes = 0

    foreach ($ch in $Argument.ToCharArray()) {
        if ($ch -eq $slash) {
            $backslashes += 1
        }
        elseif ($ch -eq $quote) {
            if ($backslashes -gt 0) {
                [void]$sb.Append(([string]$slash) * ($backslashes * 2))
            }
            [void]$sb.Append($slash)
            [void]$sb.Append($quote)
            $backslashes = 0
        }
        else {
            if ($backslashes -gt 0) {
                [void]$sb.Append(([string]$slash) * $backslashes)
                $backslashes = 0
            }
            [void]$sb.Append($ch)
        }
    }

    if ($backslashes -gt 0) {
        [void]$sb.Append(([string]$slash) * ($backslashes * 2))
    }

    [void]$sb.Append($quote)
    return $sb.ToString()
}

function Invoke-CodexApplyPatch {
    param(
        [Parameter(Mandatory = $true)]
        [string]$CodexExe,

        [Parameter(Mandatory = $true)]
        [string]$PatchText
    )

    $psi = [System.Diagnostics.ProcessStartInfo]::new()
    $psi.FileName = $CodexExe
    $psi.UseShellExecute = $false
    $psi.RedirectStandardOutput = $true
    $psi.RedirectStandardError = $true
    $psi.Arguments = [string]::Join(' ', @(
        (ConvertTo-WindowsArgument '--codex-run-as-apply-patch'),
        (ConvertTo-WindowsArgument $PatchText)
    ))

    $process = [System.Diagnostics.Process]::Start($psi)
    $stdout = $process.StandardOutput.ReadToEnd()
    $stderr = $process.StandardError.ReadToEnd()
    $process.WaitForExit()

    if ($stdout) {
        [Console]::Out.Write($stdout)
    }

    if ($stderr) {
        [Console]::Error.Write($stderr)
    }

    return $process.ExitCode
}

try {
    $exitCode = Invoke-CodexApplyPatch -CodexExe $codexExe -PatchText $patch
    exit $exitCode
}
catch {
    if ($_.Exception.Message -match '740|elevation|UAC') {
        Write-Error 'Windows elevation/sandbox boundary detected. Do not retry blindly; rerun through Codex shell_command with sandbox_permissions=require_escalated, or use an elevated terminal outside Codex when appropriate.'
    }
    throw
}
