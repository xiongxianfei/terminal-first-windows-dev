# Enterprise Policy Troubleshooting

## Purpose

Track setup areas that may be blocked or changed by managed Windows policy.

## Current scope

M1 records this placeholder so the guide has a stable destination for policy caveats. Later milestones will add concrete notes for WinGet, App Installer, Store access, WSL feature availability, package sources, proxy behavior, corporate certificate trust, and elevation prompts.

## Safety notes

Do not work around organization policy without approval from the device owner or administrator.

If WSL HTTPS fails because Ubuntu does not trust a corporate root certificate, use the manual certificate export/import path in `docs/troubleshooting/proxy.md` only when the device owner or administrator allows copying Windows-managed trust roots into WSL.
