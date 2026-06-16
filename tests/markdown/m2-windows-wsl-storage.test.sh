#!/usr/bin/env bash
set -euo pipefail

wsl_guide=docs/guides/02-wsl2-ubuntu.md
host_guide=docs/guides/01-windows-host.md
verification=docs/guides/99-verification.md
troubleshooting=docs/troubleshooting/wsl.md

for path in "$host_guide" "$wsl_guide" "$verification" "$troubleshooting"; do
  test -f "$path" || {
    echo "missing required file: $path" >&2
    exit 1
  }
done

grep -q 'winget install --id Microsoft.PowerShell --source winget' "$host_guide"
grep -q 'winget upgrade --id Microsoft.PowerShell --source winget' "$host_guide"
grep -q 'pwsh --version' "$host_guide"
grep -q 'winget --version' "$host_guide"
grep -q 'wt --version' "$host_guide"
grep -q 'wsl --version' "$host_guide"
grep -q 'Windows-side shell posture' "$host_guide"
grep -q 'notepad $PROFILE' "$host_guide"
grep -q 'Get-ExecutionPolicy -List' "$host_guide"
grep -q 'Set-PSReadLineOption -EditMode Emacs' "$host_guide"
grep -q 'Get-PSReadLineOption' "$host_guide"
grep -q 'administrator' "$host_guide"
grep -q 'enterprise policy' "$host_guide"

grep -q 'wsl --version' "$wsl_guide"
grep -q 'wsl --help' "$wsl_guide"
grep -q -- '--install' "$wsl_guide"
grep -q -- '--distribution' "$wsl_guide"
grep -q -- '--location' "$wsl_guide"
grep -q 'wsl --list --online' "$wsl_guide"
grep -q 'D:\\Software\\WSL' "$wsl_guide"
grep -q 'D:\\Software\\WSL\\Ubuntu' "$wsl_guide"
grep -q 'wsl --install --distribution <UbuntuLtsDistroName> --location "D:\\Software\\WSL\\Ubuntu"' "$wsl_guide"

if grep -q 'wsl --install Ubuntu --location' "$wsl_guide"; then
  echo "positional WSL install-location command must not be published in the guide" >&2
  exit 1
fi

grep -q 'wsl --update' "$wsl_guide"
grep -q 'wsl --update --web-download' "$wsl_guide"
grep -q 'wsl --install --web-download --distribution <UbuntuLtsDistroName> --location "D:\\Software\\WSL\\Ubuntu"' "$wsl_guide"
grep -q 'wsl --shutdown' "$wsl_guide"
grep -q 'migration/import path' "$wsl_guide"

grep -q 'wsl --export Ubuntu D:\\Software\\WSL\\Ubuntu\\ext4.vhdx --vhd' "$wsl_guide"
grep -q 'wsl --unregister Ubuntu' "$wsl_guide"
grep -q 'wsl --import-in-place Ubuntu D:\\Software\\WSL\\Ubuntu\\ext4.vhdx' "$wsl_guide"
grep -q 'wsl --set-default Ubuntu' "$wsl_guide"
grep -q 'wsl -d Ubuntu' "$wsl_guide"
grep -q 'successful backup or export' "$wsl_guide"
grep -q 'data loss' "$wsl_guide"

grep -q 'wsl --list --verbose' "$wsl_guide"
grep -q 'wsl --list --verbose' "$verification"
grep -q 'wsl --version' "$verification"
grep -q 'wsl --list --online' "$verification"

grep -q 'D:\\Software\\WSL\\Ubuntu' "$wsl_guide"
grep -q 'D:\\Data' "$wsl_guide"
grep -q '/home/<user>/data' "$wsl_guide"
grep -q '~/src' "$wsl_guide"

grep -q 'unsupported systems' "$troubleshooting"
grep -q 'wsl --update --web-download' "$troubleshooting"
grep -q 'Wsl/UpdatePackage/0x80190193' "$troubleshooting"
grep -q 'netsh winhttp show proxy' "$troubleshooting"
grep -q 'netsh winhttp reset proxy' "$troubleshooting"
grep -q 'Start-Process ms-settings:network-proxy' "$troubleshooting"
grep -q 'netsh winhttp set proxy' "$troubleshooting"
grep -q 'wsl --install --web-download --distribution <UbuntuLtsDistroName>' "$troubleshooting"
grep -q 'import-in-place' "$troubleshooting"
grep -q 'storage path' "$troubleshooting"
