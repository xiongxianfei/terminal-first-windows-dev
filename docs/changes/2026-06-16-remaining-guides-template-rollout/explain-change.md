# Explain Change: Remaining Guides Template Rollout

## Purpose

This change applies the approved how-to guide template to the remaining first-slice guide set in risk-tiered milestones. It keeps the repository documentation-first, preserves setup command semantics, and records the compatibility boundaries needed before final filename migration.

## Converted guides:

- `docs/guides/05-tmux.md`
- `docs/guides/04-neovim.md`
- `docs/guides/06-uv.md`
- `docs/guides/01-windows-host.md`
- `docs/guides/wsl-ubuntu-install.md`
- `docs/guides/wsl-ubuntu-migration.md`
- `docs/guides/99-verification.md`

## Compatibility paths:

- `docs/guides/02-wsl2-ubuntu.md` remains as a command-free compatibility path that routes by starting state to the WSL install or migration guide.
- `docs/guides/03-ubuntu-baseline.md` remains an existing unconverted guide and is recorded as an unresolved verification follow-up.
- Numbered paths outside the WSL safety split remain in place during body conformance.

## Why the changes were made

M1 converted the smaller tool guides first so the template could be exercised on lower-risk documentation before Windows host and WSL migration work.

M2 converted the Windows host guide as one unified guide, preserving policy and elevation guidance near the relevant commands.

M3 split WSL fresh install from WSL migration because those paths have different starting states and different destructive-risk profiles. The old numbered WSL path became a command-free compatibility stub to preserve old links without duplicating commands.

M4 converted verification only after active referenced guide paths existed or unresolved targets were inventoried. The verification target inventory records which paths are active references and which targets remain follow-ups.

M5 records lifecycle evidence for review, final verification, and PR handoff. It does not change setup commands or claim downstream gates have passed.

## Checks run:

- `bash tests/markdown/remaining-guides-template-rollout.test.sh`
- `bash tests/markdown/how-to-guide-template-best-practices.test.sh`
- `bash tests/markdown/guides-two-speed-how-to-structure.test.sh`
- `bash tests/markdown/m1-project-entrypoint.test.sh`
- `bash tests/markdown/m2-windows-wsl-storage.test.sh`
- `bash tests/markdown/m3-ubuntu-baseline.test.sh`
- `bash tests/markdown/m4-neovim-tmux.test.sh`
- `bash tests/markdown/m5-release-readiness.test.sh`
- `git diff --check`

## Checks intentionally not run:

Command execution: not executed.

This rollout intentionally does not execute PowerShell, WSL, Ubuntu setup, package-manager, mount, sudoers, Neovim, tmux, uv, proxy, or workstation verification command blocks from the guides. The approved validation model for this change is static and review-based.

## Review state

M1-M4 code reviews: clean-with-notes.

Remaining required gate: M5 code-review.

Final verification: not claimed.

Branch readiness: not claimed.

PR readiness: not claimed.

## Follow-ups

- M5 code-review must close the final implementation milestone before final closeout can begin.
- Final closeout still needs `explain-change`, `verify`, and `pr` stage work after M5 code-review closes.
- Broad final filename migration remains deferred to a later compatibility slice.
