# ADR: Proxy Strategy

## Status

accepted

## Context

Proxy behavior often blocks package installation and varies by VPN, PAC, corporate CA, and Windows/WSL version.

## Decision

Use WSL automatic proxy mirroring as the primary path via `%UserProfile%\.wslconfig`:

```ini
[wsl2]
autoProxy=true
```

Document manual environment-variable fallback guidance. Defer PAC files and corporate CA certificates to troubleshooting notes and known limitations in the first slice.

## Alternatives Considered

- Manual environment variables only: more explicit, but duplicates configuration and is error-prone.
- Full PAC and corporate CA support: useful, but too organization-specific for first-slice scope.
- Ignore proxy setup: simpler, but package installation may fail without explanation.

## Consequences

- The guide must explain when WSL restart is needed for `.wslconfig` changes.
- Doctor checks should report proxy auto-mirroring or fallback state.
- Corporate environments remain partially supported through troubleshooting, not full setup.

## Follow-up

Define proxy doctor checks and troubleshooting notes in the test spec and guide implementation.
