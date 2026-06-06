# WSL Troubleshooting

## Purpose

Track WSL command-version drift, unsupported options, storage-location checks, and migration recovery notes.

## Current scope

M2 records the first WSL troubleshooting notes for fresh install-location support, migration/import-in-place, and storage path verification.

## Safety notes

Do not run destructive WSL commands against a production distro unless backup or export verification has already passed.

## Unsupported fresh install-location command

If `wsl --help` does not list `--location`, run:

```powershell
wsl --update
wsl --shutdown
wsl --help
```

If `--location` is still unavailable, stop the fresh custom-location path. These unsupported systems must use the migration/import path or another documented fallback instead of silently installing to the default storage location.

## WSL update fails through Microsoft Store

If `wsl --update` fails because Microsoft Store delivery is blocked, stale, or unavailable, use the web-download path from Windows PowerShell:

```powershell
wsl --update --web-download
wsl --shutdown
wsl --version
```

If `--web-download` is not supported, record the WSL version and Windows build, then use the policy-approved WSL installer or update path for the machine.

## WSL install download hangs

If distro installation hangs at `0.0%` or Store delivery is blocked, retry with web download:

```powershell
wsl --install --web-download --distribution <UbuntuLtsDistroName>
```

For this project's custom storage path, use `--location` only when the local `wsl --help` confirms support:

```powershell
wsl --install --web-download --distribution <UbuntuLtsDistroName> --location "D:\Software\WSL\Ubuntu"
```

## Migration/import-in-place recovery

The migration/import path depends on a successful export or backup before unregister.

If export fails:

- keep the existing registered distro;
- do not run `wsl --unregister`;
- check disk space and whether the distro is still running.

If import-in-place fails:

- preserve `D:\Software\WSL\Ubuntu\ext4.vhdx`;
- do not delete the export;
- review the distro name and WSL version;
- retry only after the failure is understood.

## Storage path checks

The intended WSL storage path is `D:\Software\WSL\Ubuntu`. The intended shared data path is `D:\Data`, which later maps to `/home/<user>/data`.

Use the best available non-destructive check for the current WSL version to confirm the registered distro storage path. If a direct location query is unavailable, record the VHDX path used for fresh install or import-in-place and verify the distro launches with `wsl -d Ubuntu` or the selected explicit Ubuntu LTS distro name.
