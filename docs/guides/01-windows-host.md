# Windows Host Setup

## Purpose

Prepare the Windows 11 host layer for a terminal-first workflow. This guide owns Windows Terminal, PowerShell, Windows-side package tooling, and host verification.

## Command environment

- Windows PowerShell: host commands, package checks, Windows Terminal checks, and WSL availability checks.
- Manual verification: commands that depend on Windows 11, administrator rights, Store/App Installer availability, or enterprise policy.

## Safety notes

- Administrator-sensitive commands must be labeled before they are shown.
- Package-manager commands may prompt for elevation or be blocked by policy.
- This guide does not require changing PowerShell execution policy.
- Do not run all install commands from an elevated shell by default; use elevation only when a command or installer prompts for it.
- Enterprise policy may block WinGet, Microsoft Store/App Installer, package sources, WSL, or Windows Terminal settings.
- This project is not a one-command unattended installer.

## Install or update PowerShell

Use the latest stable PowerShell package available through a supported Windows package path. On unmanaged Windows 11 clients, the primary path is WinGet.

```powershell
winget install --id Microsoft.PowerShell --source winget
```

If PowerShell is already installed with WinGet, update it through the same package path:

```powershell
winget upgrade --id Microsoft.PowerShell --source winget
```

If `winget` is unavailable or blocked, use the policy-approved manual package path for the machine and record the source used in verification notes.

## Host verification

Run these from Windows PowerShell:

```powershell
pwsh --version
winget --version
wt --version
wsl --version
```

If `wsl --version` is unavailable, run:

```powershell
wsl --status
```

Record whether Windows Terminal, PowerShell, WinGet, and WSL are available. Mark blocked policy or missing package-source cases as `needs manual action` in the consolidated verification guide.

## PowerShell best practices

Use PowerShell as the Windows-side control shell for host setup, WSL commands, and Windows package checks.

Recommended posture:

- Use the latest stable `pwsh` for daily work.
- Keep Windows PowerShell available for compatibility, but prefer `pwsh` when both are available.
- Start normal shells without elevation; open an elevated shell only when a command needs administrator rights.
- Keep execution policy unchanged unless an organization-approved installer or script explicitly requires a temporary bypass.
- Keep local profile files small, readable, and reversible.
- Put machine-specific aliases, functions, and environment variables in the user profile, not in project docs or committed files.
- Do not store proxy credentials, tokens, private hostnames, or certificate material in a PowerShell profile.

Open the current user's PowerShell profile:

```powershell
notepad $PROFILE
```

Create it first if it does not exist:

```powershell
New-Item -ItemType File -Force $PROFILE
notepad $PROFILE
```

Useful profile checks:

```powershell
$PROFILE
Test-Path $PROFILE
Get-ExecutionPolicy -List
```

Use Emacs-style command-line editing through PSReadLine:

```powershell
Add-Content -Path $PROFILE -Value 'Set-PSReadLineOption -EditMode Emacs'
```

Open a new PowerShell session and verify the active edit mode:

```powershell
Get-PSReadLineOption | Select-Object -ExpandProperty EditMode
```

Expected result: `Emacs`.

Rollback: remove the `Set-PSReadLineOption -EditMode Emacs` line from `$PROFILE`, or replace `Emacs` with another PSReadLine edit mode such as `Windows` or `Vi`.

Keep profile changes easy to undo. When testing a profile change, open a new PowerShell session and verify that `pwsh --version`, `winget --version`, and `wsl --version` still work.

## Validation

- `pwsh --version` reports the installed PowerShell version.
- `winget --version` reports WinGet availability or identifies a policy/manual fallback.
- `wt --version` reports Windows Terminal availability.
- `wsl --version` or `wsl --status` reports WSL availability.
- Optional profile configuration can set PSReadLine to Emacs edit mode and verify it with `Get-PSReadLineOption`.

## Rollback

This guide does not change execution policy or Windows Terminal settings.

If PowerShell was installed through WinGet and must be removed, use the package path approved for the machine. Example:

```powershell
winget uninstall --id Microsoft.PowerShell --source winget
```

If a manual installer or enterprise-managed package path was used, use that same channel for rollback.
