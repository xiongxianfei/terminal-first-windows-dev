# Ubuntu Baseline Troubleshooting

## Purpose

Track Ubuntu-on-WSL baseline failures for WSL config, data mount, locale, sudo, and helper write safety.

## Safety notes

Do not keep broken sudoers or fstab changes in place. If validation fails, remove the project-owned change or restore the backup before continuing.

## WSL config changes do not apply

Confirm `/etc/wsl.conf` contains the intended entries:

```ini
[automount]
enabled=false
mountFsTab=true

[interop]
enabled=true
appendWindowsPath=false
```

After editing `/etc/wsl.conf`, restart WSL from Windows PowerShell:

```powershell
wsl --shutdown
```

If Ubuntu still sees unexpected Windows path behavior, review whether another local change has overwritten `/etc/wsl.conf`.

## Data mount fails

If `sudo mount -a` fails, do not proceed as if `/home/<user>/data` is ready.

Check:

- `D:\Data` exists on Windows, or the user intentionally chose create, skip, or choose another documented path.
- `/home/<user>/data` exists inside Ubuntu.
- `/etc/fstab` contains the project-owned `D:/Data` entry with the correct Ubuntu username.
- The installed WSL version supports direct DrvFs subdirectory mounting.

If direct subdirectory mounting is unreliable, remove the failing fstab entry and use the fallback symlink path documented in the Ubuntu baseline guide.

## Locale warnings appear

Run:

```bash
locale
locale charmap
```

Healthy output is UTF-8 and warning-free. `C.UTF-8` is the default healthy target, but user-selected UTF-8 locales are acceptable when they do not emit warnings.

## Sudoers validation fails

If `sudo visudo -cf /etc/sudoers.d/terminal-first-windows-dev` fails, remove the project-owned sudoers drop-in and do not treat passwordless sudo as enabled.

```bash
sudo rm -f /etc/sudoers.d/terminal-first-windows-dev
sudo visudo -c
```

Passwordless sudo is optional. Skipping it is a valid setup state and should be reported as `skipped` by future doctor checks.

## Helper write disclosure

Any future Ubuntu helper that writes files must show:

- target path;
- backup behavior;
- rollback behavior;
- whether the write is user-local or machine-wide.

Helpers must not silently edit `/etc/wsl.conf`, `/etc/fstab`, sudoers, proxy profile files, or shell startup files.
