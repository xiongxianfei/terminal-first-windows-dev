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

## Validation

- `pwsh --version` reports the installed PowerShell version.
- `winget --version` reports WinGet availability or identifies a policy/manual fallback.
- `wt --version` reports Windows Terminal availability.
- `wsl --version` or `wsl --status` reports WSL availability.

## Rollback

This guide does not change execution policy or Windows Terminal settings.

If PowerShell was installed through WinGet and must be removed, use the package path approved for the machine. Example:

```powershell
winget uninstall --id Microsoft.PowerShell --source winget
```

If a manual installer or enterprise-managed package path was used, use that same channel for rollback.
