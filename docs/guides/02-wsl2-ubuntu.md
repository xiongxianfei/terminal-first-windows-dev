# WSL2 Ubuntu Setup

## Purpose

Prepare WSL2 Ubuntu as the Linux development substrate while keeping WSL distro storage under `D:\Software\WSL\Ubuntu` and shared data under `D:\Data`.

## Command environment

- Windows PowerShell: WSL install, WSL migration, distro selection, and host-side verification.
- Ubuntu shell: Linux-side checks after the distro launches.
- Manual verification: storage-location checks and migration/import-in-place checks on a Windows 11 machine.

## Safety notes

- WSL migration can be destructive if backup/export verification is skipped.
- `wsl --unregister` must not appear as an action unless a successful backup or export gate is documented first.
- Unsupported WSL command options must stop the fresh custom-location path rather than silently installing elsewhere.
- Keep WSL distro storage under `D:\Software\WSL\Ubuntu`; keep shared Windows/Linux data under `D:\Data`.
- Prefer Linux-heavy project code inside the WSL filesystem, for example `~/src`.
- This project is not a one-command unattended installer.

## Storage policy

The first setup slice uses this storage model:

- WSL distro storage: `D:\Software\WSL\Ubuntu`
- Shared Windows/Linux data: `D:\Data`, later exposed in Ubuntu as `/home/<user>/data`
- Linux-heavy project code: WSL filesystem, for example `~/src`

Do not treat `D:\Data` as the default location for Linux-heavy project code unless you accept mounted-drive performance tradeoffs.

## Fresh install to D drive

Run these from Windows PowerShell.

Best-practice install posture:

- Use an explicit Ubuntu LTS distro from `wsl --list --online`.
- Prefer WSL 2 for new installs.
- Prefer `--location` for fresh custom-location installs when the local WSL command supports it.
- If Store/App Installer delivery is blocked or hangs, use the documented `--web-download` path.
- Keep distro storage, shared data, and Linux project code separate.
- Verify each layer before configuring the next one.

Record the current WSL version:

```powershell
wsl --version
```

Check that the local WSL command supports the required options:

```powershell
wsl --help
```

The fresh custom-location path requires `--install`, `--distribution`, and `--location`.

List installable distributions and choose an explicit Ubuntu LTS distro name from the output:

```powershell
wsl --list --online
```

Use `<UbuntuLtsDistroName>` as the selected explicit distro name from that output. Exact distro labels are examples only; do not rely only on a mutable `Ubuntu` label when a versioned LTS package is available.

Create or verify the parent directory:

```powershell
New-Item -ItemType Directory -Force "D:\Software\WSL"
```

The target install directory must be absent or intentionally empty before installation:

```powershell
Test-Path "D:\Software\WSL\Ubuntu"
Get-ChildItem "D:\Software\WSL\Ubuntu" -Force
```

Install with the explicit long-option form:

```powershell
wsl --install --distribution <UbuntuLtsDistroName> --location "D:\Software\WSL\Ubuntu"
```

Do not publish the ambiguous positional install-location form as the primary command.

If `wsl --help` does not list `--location`, try:

```powershell
wsl --update
wsl --shutdown
wsl --help
```

If `wsl --update` fails because Microsoft Store delivery is blocked or unreliable, use the web-download update path:

```powershell
wsl --update --web-download
wsl --shutdown
wsl --version
```

If `--location` is still missing, stop the fresh custom-location path and use the migration/import path. Unsupported systems must not silently install to the default location.

If distro install hangs at download time or Store delivery is blocked, retry with web download:

```powershell
wsl --install --web-download --distribution <UbuntuLtsDistroName> --location "D:\Software\WSL\Ubuntu"
```

## Fresh install verification

Run:

```powershell
wsl --list --verbose
wsl -d <UbuntuLtsDistroName>
```

Record:

- WSL version from `wsl --version`;
- selected Ubuntu LTS distro name from `wsl --list --online`;
- `wsl --list --verbose` output;
- the best available non-destructive storage-location check for the current WSL version.

## Migration/import path for an existing Ubuntu distro

Use this path only after backup or export preconditions are understood. The examples below use the distro name `Ubuntu`; adapt the distro name only when the guide or owner explicitly chooses that path.

Shut down WSL before export:

```powershell
wsl --shutdown
```

Create the target directory:

```powershell
New-Item -ItemType Directory -Force "D:\Software\WSL\Ubuntu"
```

Export the existing distro as a VHDX:

```powershell
wsl --export Ubuntu D:\Software\WSL\Ubuntu\ext4.vhdx --vhd
```

Stop if export fails. Do not unregister the existing distro until a successful backup or export exists and the export file is present.

Verify the export file:

```powershell
Test-Path "D:\Software\WSL\Ubuntu\ext4.vhdx"
Get-Item "D:\Software\WSL\Ubuntu\ext4.vhdx"
```

Destructive step: `wsl --unregister Ubuntu` removes the registered distro and can cause data loss if backup or import verification fails.

Run this only after the successful backup or export gate has passed:

```powershell
wsl --unregister Ubuntu
```

Import the VHDX in place:

```powershell
wsl --import-in-place Ubuntu D:\Software\WSL\Ubuntu\ext4.vhdx
```

Reset the default distro and launch Ubuntu:

```powershell
wsl --set-default Ubuntu
wsl -d Ubuntu
```

## Migration verification

Run:

```powershell
wsl --list --verbose
wsl -d Ubuntu
```

The migration is not complete until the imported distro appears in `wsl --list --verbose`, launches successfully, and the default distro is set as intended.

## Validation

- Fresh install docs include `wsl --version`, `wsl --help`, `wsl --list --online`, `--install`, `--distribution`, `--location`, and the exact primary command.
- The positional install-location form is not published as the primary command.
- Missing `--location` routes unsupported systems to the migration/import path.
- Migration requires `wsl --shutdown`, successful backup or export, unregister data-loss warning, `wsl --import-in-place`, default reset, launch verification, and `wsl --list --verbose`.
- WSL storage under `D:\Software\WSL\Ubuntu` remains distinct from shared data under `D:\Data` and Linux project code under `~/src`.

## Rollback

- If fresh install fails before a distro is registered, remove the incomplete `D:\Software\WSL\Ubuntu` directory only after confirming no wanted data is inside.
- If export fails, keep the existing registered distro and do not run unregister.
- If import-in-place fails, keep the exported VHDX as the recovery source and do not delete it.
- If the wrong default distro is selected, reset it with `wsl --set-default <DistroName>`.
- If a migrated distro fails to launch, preserve the VHDX and review WSL troubleshooting before attempting another unregister/import cycle.
