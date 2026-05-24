# Proxy Troubleshooting

## Purpose

Track proxy behavior that can affect Windows, WSL, Ubuntu package installation, Neovim plugins, and terminal tools.

## Current scope

M3 documents WSL automatic proxy mirroring as the primary path, manual environment-variable fallback, and first-slice limits for PAC files and corporate CA certificates.

## Safety notes

Do not paste proxy credentials into shell history when a secure alternative exists.

## Automatic proxy mirroring does not work

Check `%UserProfile%\.wslconfig` on Windows:

```ini
[wsl2]
autoProxy=true
```

After editing the file, restart WSL:

```powershell
wsl --shutdown
```

If enterprise policy, VPN behavior, or the installed WSL version blocks automatic proxy mirroring, use the manual proxy fallback in `docs/guides/03-ubuntu-baseline.md`.

## Manual proxy fallback cautions

Manual proxy variables such as `http_proxy`, `https_proxy`, and `no_proxy` can unblock Ubuntu package installation and terminal tools, but they can also leak proxy credentials if copied into shell history, logs, or committed files.

Use credential-free examples in public docs. Keep private proxy hostnames, usernames, passwords, tokens, and certificate material out of the repository.

## Known limitations

PAC file handling and corporate CA certificate installation are a known limitation in the first implementation slice. This repository may document symptoms and policy questions, but it does not install PAC handling or corporate trust roots yet.
