@echo off
setlocal

rem Project-local launcher for the Windows apply_patch wrapper.
rem Intended use: tools\apply_patch.bat -PatchFile patch.diff
rem For multi-line inline patches, call apply_patch_windows.ps1 -PatchText instead.

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0apply_patch_windows.ps1" %*
exit /b %ERRORLEVEL%
