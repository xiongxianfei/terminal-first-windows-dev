# Configure WSL automatic proxy mirroring

**Prerequisites:** WSL2 Ubuntu is installed; Windows proxy or VPN policy is already configured; you can edit `%UserProfile%\.wslconfig` for the current Windows user.
**Time:** ~10 minutes.
**Outcome:** Ubuntu uses WSL automatic proxy mirroring, or you have a targeted fallback path when local policy blocks it.
**Verify:** `curl -I https://github.com` or a policy-approved HTTPS endpoint succeeds from Ubuntu.

## Fast path

1. Enable automatic proxy mirroring in `%UserProfile%\.wslconfig`.

   Warning: this changes WSL global configuration for the current Windows user.

   Backup: if `%UserProfile%\.wslconfig` already exists, save a copy before editing it.

   ```ini
   [wsl2]
   autoProxy=true
   ```

   Expected result: `%UserProfile%\.wslconfig` contains `[wsl2]` and `autoProxy=true`.

   If automatic mirroring is blocked by WSL version, VPN, or enterprise policy, use [automatic proxy mirroring does not work](../troubleshooting/proxy.md#automatic-proxy-mirroring-does-not-work).

2. Restart WSL from Windows PowerShell.

   ```powershell
   wsl --shutdown
   ```

   Expected result: WSL shuts down without an error. Open Ubuntu again after the command returns.

3. Verify HTTPS access from Ubuntu.

   ```bash
   curl -I https://github.com
   ```

   Expected result: HTTP response headers print without a proxy, DNS, timeout, or certificate error.

   If your environment blocks GitHub, use an approved HTTPS endpoint instead. If HTTPS fails with a certificate or issuer error, use [WSL SSL certificate trust fails](../troubleshooting/proxy.md#wsl-ssl-certificate-trust-fails). If proxy credentials would be required in environment variables, read [manual proxy fallback cautions](../troubleshooting/proxy.md#manual-proxy-fallback-cautions) before entering anything in a shell.

## Walkthrough

### 1. Enable automatic proxy mirroring

WSL automatic proxy mirroring lets Ubuntu use the Windows proxy configuration instead of keeping a separate Linux proxy setup. This is the primary path for this project when the installed WSL version and local policy support it.

Warning: `%UserProfile%\.wslconfig` affects WSL behavior for the current Windows user. Save a copy before editing an existing file.

Target path: `%UserProfile%\.wslconfig`

Backup behavior: if the file already exists, save a copy before editing it.

Rollback: remove the project-owned `autoProxy=true` entry or restore the backup, then restart WSL.

Scope: user-local WSL global configuration for the Windows account.

Open the file from Windows PowerShell:

```powershell
notepad $env:USERPROFILE\.wslconfig
```

Add or verify:

```ini
[wsl2]
autoProxy=true
```

Expected result: `%UserProfile%\.wslconfig` contains `[wsl2]` and `autoProxy=true`.

If automatic mirroring is blocked by WSL version, VPN, or enterprise policy, use [automatic proxy mirroring does not work](../troubleshooting/proxy.md#automatic-proxy-mirroring-does-not-work). PAC files remain a first-slice limitation; keep PAC handling in troubleshooting and local policy documentation.

### 2. Restart WSL

WSL reads `.wslconfig` when the WSL VM starts. Restart WSL after changing the file.

Run from Windows PowerShell:

```powershell
wsl --shutdown
```

Then open Ubuntu again from Windows Terminal.

Expected result: WSL shuts down without an error and Ubuntu starts normally.

Rollback: restore the previous `.wslconfig` or remove the project-owned proxy entry, then run `wsl --shutdown` again.

### 3. Verify HTTPS access

Run from Ubuntu:

```bash
curl -I https://github.com
```

Expected result: HTTP response headers print without a proxy, DNS, timeout, or certificate error.

If your organization blocks GitHub, use a policy-approved HTTPS endpoint that should be reachable through the Windows proxy.

If HTTPS fails with a certificate or issuer error, use [WSL SSL certificate trust fails](../troubleshooting/proxy.md#wsl-ssl-certificate-trust-fails). If the environment requires manual `http_proxy`, `https_proxy`, or `no_proxy` values, read [manual proxy fallback cautions](../troubleshooting/proxy.md#manual-proxy-fallback-cautions) before entering anything in a shell.

## Rollback

Remove the project-owned `autoProxy=true` entry from `%UserProfile%\.wslconfig` or restore the backup copy, then restart WSL from Windows PowerShell:

```powershell
wsl --shutdown
```

Manual fallback variables are shell-session-only unless you persist them yourself. Unset session variables with:

```bash
unset http_proxy https_proxy no_proxy
```

## Troubleshooting

Use the targeted troubleshooting entry that matches the symptom:

- Automatic mirroring blocked or unavailable: [automatic proxy mirroring does not work](../troubleshooting/proxy.md#automatic-proxy-mirroring-does-not-work)
- Proxy credentials, private hostnames, or shell-history risk: [manual proxy fallback cautions](../troubleshooting/proxy.md#manual-proxy-fallback-cautions)
- HTTPS certificate or issuer errors: [WSL SSL certificate trust fails](../troubleshooting/proxy.md#wsl-ssl-certificate-trust-fails)
