# Explain Change: Two-Speed How-To Guide Structure

## Status

M1 explanation recorded for code-review handoff.

## Source artifacts

- Proposal: `docs/proposals/2026-06-07-guides-two-speed-how-to-structure.md`
- Proposal review: `docs/proposals/2026-06-07-guides-two-speed-how-to-structure.review.md`
- Spec: `specs/guides-two-speed-how-to-structure.md`
- Spec review: `specs/guides-two-speed-how-to-structure.review.md`
- Test spec: `specs/guides-two-speed-how-to-structure.test.md`
- Plan: `docs/changes/2026-06-07-guides-two-speed-how-to-structure/plan.md`

## M1 change rationale

| File | Why it changed |
| --- | --- |
| `docs/guides/README.md` | Adds the reader-intent router required by M1. It keeps the current numbered setup sequence discoverable while naming the planned task-scoped guides and routing failure recovery to troubleshooting docs. |
| `docs/templates/how-to-guide.md` | Adds the contributor-facing how-to template outside `docs/guides/` so reader-facing guides are not mixed with meta content. The template encodes metadata, fast path, walkthrough, verification, rollback, troubleshooting links, and review checks. |
| `docs/changes/2026-06-07-guides-two-speed-how-to-structure/plan.md` | Records M1 progress, validation evidence, and review-requested handoff state. |
| `docs/changes/2026-06-07-guides-two-speed-how-to-structure/change.yaml` | Records compact lifecycle state for the active change. |
| `docs/plan.md` | Updates the project plan index so the next stage is code-review for M1. |

## Validation evidence

- Baseline proof before edits confirmed `docs/templates/how-to-guide.md` and `docs/guides/README.md` were missing.
- `test -f docs/templates/how-to-guide.md` passed after implementation.
- `test -f docs/guides/README.md` passed after implementation.
- `rg -n "Fast path|Walkthrough|Prerequisites|Outcome|Verify" docs/templates/how-to-guide.md` passed after implementation.
- `rg -n "01-windows-host|02-wsl2-ubuntu|03-ubuntu-baseline|04-neovim|05-tmux|99-verification" docs/guides/README.md` passed after implementation.
- `test ! -f docs/guides/_template.md && test ! -f docs/guides/how-to-guide.md` passed after implementation.
- `git diff --check -- docs/guides/README.md docs/templates/how-to-guide.md docs/changes/2026-06-07-guides-two-speed-how-to-structure/plan.md docs/changes/2026-06-07-guides-two-speed-how-to-structure/change.yaml` passed after implementation.

## Remaining workflow

- Run code-review for M1.
- Implement and review M2 proxy pilot after M1 closes.
- Implement and review M3 lightweight validation after M2 closes.
- Run final verify and PR handoff only after all implementation milestones and reviews are closed.
