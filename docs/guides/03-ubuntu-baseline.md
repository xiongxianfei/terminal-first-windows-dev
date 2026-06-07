# Ubuntu Baseline Setup

## Purpose

Configure Ubuntu-on-WSL baseline behavior after the distro exists. This guide owns proxy posture, WSL config, shared data access, locale readiness, and the optional passwordless sudo convenience profile.

## Command environment

- Windows PowerShell: `%UserProfile%\.wslconfig` proxy mirroring setup and WSL restart commands.
- Ubuntu shell: package checks, locale checks, fstab validation, sudo validation, and Linux-side doctor checks.
- Manual verification: fstab, mount, sudoers, proxy, and locale behavior.

## Safety notes

- `%UserProfile%\.wslconfig` affects WSL behavior for the current Windows user.
- `/etc/wsl.conf`, `/etc/fstab`, and sudoers edits affect system behavior inside Ubuntu.
- Commands that write WSL config, fstab, sudoers, profile files, or proxy settings must be reviewed before running.
- Helpers that write files must disclose target path, backup behavior, rollback behavior, and user-local or machine-wide scope.
- Passwordless sudo is optional and is a personal-workstation convenience profile with a local security tradeoff.
- This project is not a one-command unattended installer.

## Proxy primary path

Use WSL automatic proxy mirroring as the primary proxy path when the installed WSL version supports it.

Warning: this writes the current Windows user's WSL global config file.

Target path: `%UserProfile%\.wslconfig`

Open the target file directly from Windows PowerShell:

```powershell
notepad $env:USERPROFILE\.wslconfig
```

Backup behavior: if the file already exists, save a copy before editing it.

Rollback behavior: remove the project-owned `autoProxy=true` entry or restore the backup, then restart WSL.

Scope: user-local WSL global configuration for the Windows account.

Add or verify this content from Windows PowerShell:

```ini
[wsl2]
autoProxy=true
```

Restart WSL after changing `.wslconfig`:

```powershell
wsl --shutdown
```

Launch Ubuntu again and test network access with policy-approved commands such as package index refresh or a request to an approved internal endpoint.

## Manual proxy fallback

If automatic proxy mirroring is unavailable or blocked by enterprise policy, use manual proxy environment variables as a fallback. Do not paste proxy credentials into shell history. Prefer a credential-free proxy URL, a policy-managed secret store, or an interactive prompt outside committed files.

Example shell-session-only fallback:

```bash
export http_proxy="http://proxy.example:8080"
export https_proxy="http://proxy.example:8080"
export no_proxy="localhost,127.0.0.1"
```

If a persistent fallback is required, put it in a user-local shell profile only after recording the target path, backup behavior, rollback behavior, and scope. Do not commit private proxy hostnames, usernames, passwords, tokens, or certificate material.

PAC files remain a known limitation for the first implementation slice. Corporate CA certificate installation is troubleshooting-only and manual; see `docs/troubleshooting/proxy.md` for the Windows-to-WSL certificate export path. This guide does not implement automatic PAC or corporate CA setup.

## WSL config

Warning: `/etc/wsl.conf` affects Ubuntu startup behavior. Back up the file before editing.

Target path: `/etc/wsl.conf`

Backup behavior:

```bash
sudo cp -a /etc/wsl.conf "/etc/wsl.conf.backup.$(date +%Y%m%d%H%M%S)" 2>/dev/null || true
```

Rollback behavior: restore the backup or remove the project-owned entries, then shut down and restart WSL from Windows PowerShell.

Scope: machine-wide inside the Ubuntu distro.

Recommended content:

```ini
[automount]
enabled=false
mountFsTab=true

[interop]
enabled=true
appendWindowsPath=false
```

Best-practice WSL configuration posture:

- Use `.wslconfig` for WSL 2 global settings owned by the Windows user.
- Use `/etc/wsl.conf` for Ubuntu-distro settings.
- Keep automatic Windows drive mounting disabled when this guide owns the shared-data path.
- Keep `appendWindowsPath=false` to avoid unexpected Windows command precedence inside Ubuntu.
- Restart WSL with `wsl --shutdown` after changing either file.

After editing, restart WSL from Windows PowerShell:

```powershell
wsl --shutdown
```

## APT source configuration

Ubuntu package sources may be slow, blocked, or redirected by enterprise policy. Configure APT only when the default source is unsuitable.

Warning: APT source changes affect package installation inside Ubuntu. Back up source files first and do not commit private mirror hostnames.

Inspect current sources:

```bash
grep -RhvE '^\s*(#|$)' /etc/apt/sources.list /etc/apt/sources.list.d/*.list /etc/apt/sources.list.d/*.sources 2>/dev/null || true
```

Back up the current source configuration:

```bash
sudo mkdir -p /etc/apt/backup-terminal-first
sudo cp -a /etc/apt/sources.list /etc/apt/sources.list.d /etc/apt/backup-terminal-first/ 2>/dev/null || true
```

On Ubuntu 24.04, prefer editing Deb822 source files under `/etc/apt/sources.list.d/` when they exist. Open the Ubuntu source file:

```bash
sudoedit /etc/apt/sources.list.d/ubuntu.sources
```

Change only the `URIs:` value to the policy-approved mirror. Example:

```text
URIs: https://archive.ubuntu.com/ubuntu/
```

Then validate:

```bash
sudo apt update
apt-cache policy
```

Rollback by restoring the backup or reverting the `URIs:` value, then rerun `sudo apt update`.

## Shared data mount

The documented shared data path is `D:\Data` on Windows and `/home/<user>/data` inside Ubuntu. Keep Linux-heavy project code in the WSL filesystem, for example `~/src`; treat `/home/<user>/data` as shared Windows/Linux data unless you accept mounted-drive performance tradeoffs.

If `D:\Data` does not exist, create, skip, or choose one of these paths before configuring fstab: create it on Windows, skip shared data setup, or choose a manually documented replacement path for this machine.

Warning: `/etc/fstab` mistakes can affect mount behavior. Back up the file before editing and validate with `sudo mount -a`.

Target path: `/etc/fstab`

Backup behavior:

```bash
sudo cp -a /etc/fstab "/etc/fstab.backup.$(date +%Y%m%d%H%M%S)"
```

Rollback behavior: remove the project-owned `D:/Data` entry or restore the backup, then run `sudo mount -a` again.

Scope: machine-wide inside the Ubuntu distro.

Create the Linux mount point:

```bash
mkdir -p "$HOME/data"
```

Preferred fstab entry:

```fstab
D:/Data /home/<user>/data drvfs metadata,uid=1000,gid=1000,umask=022,fmask=011,case=off 0 0
```

Replace `<user>` with the Ubuntu username before writing the entry.

Validate the mount:

```bash
sudo mount -a
findmnt "$HOME/data"
```

If direct DrvFs subdirectory mounting is unreliable on the installed WSL version, use the fallback symlink path:

1. Mount `D:` through fstab at a documented mount point such as `/mnt/d`.
2. Verify `D:\Data` appears as `/mnt/d/Data`.
3. Create a fallback symlink:

```bash
ln -sfn /mnt/d/Data "$HOME/data"
```

## Locale readiness

`C.UTF-8` is the healthy default locale for deterministic UTF-8 behavior. User-selected UTF-8 locales are also healthy when locale output is UTF-8 and warning-free.

Check locale state:

```bash
locale
locale charmap
```

Expected result:

- `locale charmap` reports `UTF-8`.
- `locale` output has no warnings.
- `LANG` or `LC_*` values are either `C.UTF-8` or another warning-free UTF-8 locale selected by the user.

If a repair is needed, prefer `C.UTF-8` unless the user intentionally chooses a regional UTF-8 locale.

Repair to the default `C.UTF-8` locale:

```bash
sudo update-locale LANG=C.UTF-8 LC_ALL=
exec "$SHELL" -l
locale
locale charmap
```

If the output still shows warnings after starting a new shell, clear conflicting user-level locale exports before setting the system default again:

```bash
grep -nE '^(export )?(LANG|LC_[A-Z_]+)=' ~/.profile ~/.bashrc ~/.zshrc 2>/dev/null || true
```

Remove or comment stale `LANG` or `LC_*` lines that point to unavailable locales, then rerun:

```bash
sudo update-locale LANG=C.UTF-8 LC_ALL=
exec "$SHELL" -l
```

If the user intentionally wants a regional UTF-8 locale, generate and select it explicitly:

```bash
sudo apt update
sudo apt install -y locales
sudo locale-gen en_US.UTF-8
sudo update-locale LANG=en_US.UTF-8 LC_ALL=
exec "$SHELL" -l
```

Replace `en_US.UTF-8` with the user's chosen UTF-8 locale. Do not set `LC_ALL` permanently unless a specific tool requires it; `LC_ALL` should normally stay empty so category-specific locale settings can work.

## Optional passwordless sudo

Passwordless sudo is optional. Skip this section if you do not want the personal-workstation convenience profile.

Warning: passwordless sudo weakens local safety because commands can elevate without an interactive password prompt.

Target path: `/etc/sudoers.d/terminal-first-windows-dev`

Backup behavior: the setup creates a project-owned sudoers drop-in instead of editing `/etc/sudoers` directly. If the drop-in already exists, back it up before replacing it.

Rollback behavior: remove `/etc/sudoers.d/terminal-first-windows-dev`, validate with `visudo`, and verify that `sudo -n true` no longer succeeds unless another policy allows it.

Scope: machine-wide inside the Ubuntu distro for the named Ubuntu user.

Create the project-owned sudoers drop-in:

```bash
printf '%s\n' "$USER ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/terminal-first-windows-dev >/dev/null
sudo chmod 0440 /etc/sudoers.d/terminal-first-windows-dev
sudo visudo -cf /etc/sudoers.d/terminal-first-windows-dev
```

Verify non-interactive sudo behavior:

```bash
sudo -n true
```

If `visudo` validation fails, remove the drop-in and do not consider the profile applied.

## Doctor status expectations

Future doctor checks for this layer report only `pass`, `fail`, `skipped`, or `needs manual action`.

Expected layer names include WSL config, proxy, data mount, locale, and sudo.

Doctor checks are primarily verification and should avoid broad writes. Any future helper that writes files must show the target path, backup behavior, rollback behavior, and scope before writing.

## Validation

- Proxy docs include `%UserProfile%\.wslconfig`, `[wsl2]`, `autoProxy=true`, manual proxy fallback, and PAC/corporate CA known limitations.
- WSL config docs include `/etc/wsl.conf`, `enabled=false`, `mountFsTab=true`, and `appendWindowsPath=false`.
- Data mount docs expose `D:\Data` at `/home/<user>/data`, validate with `sudo mount -a`, and document the fallback symlink path.
- Locale docs define `C.UTF-8` as healthy and accept warning-free user-selected UTF-8 locales.
- Passwordless sudo docs are optional, use a project-owned sudoers drop-in, validate with `visudo`, verify with `sudo -n true`, and document rollback.

## Rollback

- `.wslconfig`: remove the project-owned `autoProxy=true` entry or restore the backup, then run `wsl --shutdown` from Windows PowerShell.
- `/etc/wsl.conf`: restore the backup or remove project-owned entries, then restart WSL.
- `/etc/fstab`: remove the project-owned `D:/Data` entry or restore the backup, then run `sudo mount -a`.
- Data mount fallback: remove the fallback symlink at `/home/<user>/data` if it was created.
- Proxy fallback: unset shell-session variables or remove project-owned lines from the user-local profile where they were added.
- Sudoers: remove `/etc/sudoers.d/terminal-first-windows-dev`, run `sudo visudo -c`, and verify expected sudo behavior.
