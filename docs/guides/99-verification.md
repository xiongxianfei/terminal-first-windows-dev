# Verification

## Purpose

Collect the checks that prove each setup layer is working. Verification is the user-facing proof surface for this project.

## Command environment

- Windows PowerShell: Windows host, WSL, Windows Neovim, and Windows Terminal checks.
- Ubuntu shell: Ubuntu baseline, proxy, data mount, locale, sudo, Ubuntu Neovim, and tmux checks.
- Neovim command: editor health checks.
- tmux command: tmux session and config checks.
- Manual verification: Windows-only and machine-changing paths that cannot be proven safely from static repository checks.

## Safety notes

- Doctor checks should report state before making changes.
- Any helper that writes files must disclose target path, backup behavior, rollback behavior, and scope.
- Verification output must not include secrets, proxy credentials, tokens, private hostnames, or private machine paths beyond documented examples.
- This project is not a one-command unattended installer.

## Result vocabulary

Doctor checks report `pass`, `fail`, `skipped`, or `needs manual action`.

In plain text, every doctor result is one of: pass, fail, skipped, or needs manual action.

## Verification matrix

| Layer | Environment | Required observation | Result states |
| --- | --- | --- | --- |
| Windows host | Windows PowerShell | `pwsh`, `winget`, `wt`, and WSL availability commands report versions or status | `pass`, `fail`, `skipped`, `needs manual action` |
| WSL storage | Windows PowerShell | fresh install or migration uses `D:\Software\WSL\Ubuntu` and verifies the distro with `wsl --list --verbose` | `pass`, `fail`, `skipped`, `needs manual action` |
| WSL config | Ubuntu shell and Windows PowerShell | `/etc/wsl.conf` contains the documented automount and interop posture after WSL restart | `pass`, `fail`, `skipped`, `needs manual action` |
| Ubuntu baseline | Ubuntu shell | baseline checks can run without locale, mount, or sudoers warnings | `pass`, `fail`, `skipped`, `needs manual action` |
| proxy | Windows PowerShell and Ubuntu shell | automatic proxy mirroring or manual proxy fallback supports package/network access | `pass`, `fail`, `skipped`, `needs manual action` |
| data mount | Ubuntu shell | `/home/<user>/data` reaches `D:\Data` through fstab or fallback symlink | `pass`, `fail`, `skipped`, `needs manual action` |
| locale | Ubuntu shell | `locale` is warning-free and `locale charmap` reports `UTF-8` | `pass`, `fail`, `skipped`, `needs manual action` |
| sudo | Ubuntu shell | optional passwordless sudo is either skipped or passes `visudo` and non-interactive sudo checks | `pass`, `fail`, `skipped`, `needs manual action` |
| Neovim Windows | Windows PowerShell and Neovim command | Windows Neovim reports version, starts cleanly, and has reviewed plugin and health status | `pass`, `fail`, `skipped`, `needs manual action` |
| Neovim Ubuntu | Ubuntu shell and Neovim command | Ubuntu Neovim reports version, starts cleanly, and has reviewed plugin and health status | `pass`, `fail`, `skipped`, `needs manual action` |
| tmux Ubuntu | Ubuntu shell and tmux command | tmux reports version and loads the project config in a clean session | `pass`, `fail`, `skipped`, `needs manual action` |

## Windows host checks

Run from Windows PowerShell:

```powershell
pwsh --version
winget --version
wt --version
wsl --version
```

If `wsl --version` is unavailable, capture:

```powershell
wsl --status
```

Expected result: each available tool reports a version or status. Missing or policy-blocked tools are `needs manual action`.

## WSL fresh install verification

Before install, record:

```powershell
wsl --version
wsl --help
wsl --list --online
```

After install, record:

```powershell
wsl --list --verbose
wsl -d <UbuntuLtsDistroName>
```

Expected result: the selected explicit Ubuntu LTS distro appears in verbose output and launches.

## WSL migration verification

After import-in-place, record:

```powershell
wsl --list --verbose
wsl -d Ubuntu
```

Expected result: the imported distro appears, launches, and is the intended default after `wsl --set-default Ubuntu`.

## Ubuntu baseline checks

Run WSL config and proxy checks after Ubuntu has restarted from Windows PowerShell:

```powershell
wsl --shutdown
```

Then run Ubuntu-side checks from the Ubuntu shell.

Check WSL config:

```bash
test -f /etc/wsl.conf
grep -n 'mountFsTab=true' /etc/wsl.conf
```

Expected result: WSL config is `pass` when `/etc/wsl.conf` includes the documented automount and interop posture. Missing or intentionally deferred config is `needs manual action` or `skipped`, depending on the user's choice.

Check proxy state:

```bash
env | grep -Ei '^(http_proxy|https_proxy|no_proxy)=' || true
```

Expected result: proxy is `pass` when automatic proxy mirroring or manual proxy fallback supports package/network access. Environments that require PAC or corporate CA setup beyond the first slice are `needs manual action`.

Check data mount:

```bash
sudo mount -a
findmnt "$HOME/data"
```

Expected result: data mount is `pass` when `/home/<user>/data` reaches `D:\Data` through fstab or the documented fallback symlink. Missing `D:\Data` may be `skipped` when the user intentionally skips shared data setup.

Check locale:

```bash
locale
locale charmap
```

Expected result: locale is `pass` when output is warning-free and `locale charmap` reports `UTF-8`. `C.UTF-8` is the healthy default; user-selected UTF-8 locales are also acceptable when warning-free.

Check optional sudo profile:

```bash
sudo visudo -cf /etc/sudoers.d/terminal-first-windows-dev
sudo -n true
```

Expected result: sudo is `pass` only when passwordless sudo was intentionally enabled and both checks pass. If the user skipped the personal-workstation convenience profile, report sudo as `skipped`, not failed.

## Neovim checks

Check Neovim Windows separately from Neovim Ubuntu. Do not treat one environment as proof for the other.

Run in Windows PowerShell:

```powershell
nvim --version
```

Run in Ubuntu:

```bash
nvim --version
nvim --clean +'quit'
```

After deploying the project config, open Neovim and run:

```vim
:checkhealth
```

If Lazy is used as the plugin manager, check plugin manager status with:

```vim
:Lazy
```

Expected result: Neovim Windows and Neovim Ubuntu each report `pass` only when the local binary works, startup has no config errors, plugin manager status is understood, and `:checkhealth` is reviewed. Missing optional JavaScript/TypeScript or Python tools should not fail the core editor profile.

## tmux Ubuntu checks

Run inside Ubuntu:

```bash
tmux -V
tmux -f config/tmux/tmux.conf new-session -d -s terminal-first-check
tmux kill-session -t terminal-first-check
```

Expected result: tmux Ubuntu is `pass` when `tmux -V` works and the config loads in a clean session. Native Windows tmux is `skipped` because it is outside the first slice.

## Publication gate

Before publishing a release or treating the guide as final, maintainers must record tested versions in `docs/release-notes/2026-05-24-tested-versions.md` or a newer release note.

The version policy is latest stable at setup time, not preview or nightly. Pin only where reproducibility matters, such as Neovim plugin lockfiles.

The WSL install-location command contract must include:

- official Microsoft Learn evidence for `wsl --install`, `--distribution`, `--location`, `wsl --list --online`, `wsl --help`, and `wsl --list --verbose`;
- a local or release-captured `wsl --help` excerpt showing the required options;
- the primary command `wsl --install --distribution <UbuntuLtsDistroName> --location "D:\Software\WSL\Ubuntu"`;
- a negative check that `wsl --install Ubuntu --location ...` is not published as the primary command.

Reference: Microsoft Learn, Basic commands for WSL, `https://learn.microsoft.com/en-us/windows/wsl/basic-commands`.

Manual Windows checks that cannot run from this Linux workspace must be marked `unrun` or `needs manual action`; do not treat them as passed.

## Static checks

Run the milestone static checks before review:

```bash
bash tests/markdown/m1-project-entrypoint.test.sh
bash tests/markdown/m2-windows-wsl-storage.test.sh
bash tests/markdown/m3-ubuntu-baseline.test.sh
bash tests/markdown/m4-neovim-tmux.test.sh
bash tests/markdown/m5-release-readiness.test.sh
```

Run config smoke checks where tools are available:

```bash
nvim --headless --cmd 'set runtimepath^=config/nvim' -u config/nvim/init.lua +'lua require("terminal_first")' +qa
tmux -f config/tmux/tmux.conf new-session -d -s terminal-first-check
tmux kill-session -t terminal-first-check
```

## Whitespace validation

Required staged milestone gate:

```bash
git diff --cached --name-only
git diff --cached --check
```

Stage only files intentionally changed for the current milestone before running the gate. Review the staged file list as part of validation.

For local editing prechecks, a path-scoped working-tree check is acceptable:

```bash
git diff --check -- <milestone-file-or-directory> [<more-paths>...]
```

The repository-wide `git diff --check` is advisory while known unrelated baseline drift exists.

## Rollback coverage

Rollback paths must exist for:

- WSL relocation: preserve the VHDX/export and reset the default distro only after verification.
- `.wslconfig`: remove project-owned `autoProxy=true` or restore the backup, then run `wsl --shutdown`.
- `/etc/wsl.conf`: restore the backup or remove project-owned entries, then restart WSL.
- `/etc/fstab`: remove project-owned data mount entries or restore the backup, then run `sudo mount -a`.
- sudoers: remove `/etc/sudoers.d/terminal-first-windows-dev`, then run `sudo visudo -c`.
- proxy fallback: unset shell variables or remove project-owned profile lines.
- Neovim config: restore backed-up `%LocalAppData%\nvim` or `~/.config/nvim`.
- tmux config: restore backed-up `~/.tmux.conf` or remove the project-owned tmux config.

## Validation

M1 validates the project entry point and guide skeleton. M2 validates Windows host and WSL storage checks. M3 validates Ubuntu baseline, proxy, data mount, locale, and sudo checks. M4 validates Neovim Windows, Neovim Ubuntu, and tmux Ubuntu checks. M5 validates the consolidated verification matrix, publication gate, version record, rollback coverage, README final orientation, and staged whitespace policy.

## Rollback

This guide is documentation and verification guidance. Roll back M5 by reverting the release-readiness docs and static checks. Do not remove user-local setup files as part of reverting repository docs.
