# MacBook Setup Best Practices Change Explanation

## Status

M1 implementation is ready for code-review.

## What changed

M1 established the separate macOS companion baseline in `../20260617-terminal-first-macos-dev`:

- Replaced the template README with `terminal-first-macos-dev` identity, scope, validation, and traceability.
- Added `docs/guides/README.md` as the guide index.
- Added `docs/guides/macbook-terminal-baseline.md` as the first-slice guide scaffold.
- Added `docs/verification/macbook-terminal-baseline.md` as the manual verification template.
- Added `tests/markdown/macbook-setup-best-practices.test.sh` as the static baseline proof.

The current Windows-first repository was updated only for lifecycle tracking: change metadata, plan index, and the active plan.

## Why it changed

The approved proposal, spec, test spec, and plan require MacBook setup guidance to live in a separate macOS companion surface rather than inside `terminal-first-windows-dev`.

M1 intentionally creates locations and checks before full setup guidance:

- Guide content belongs in the companion repo.
- Verification evidence has a durable path before any command-success or compatibility claims are made.
- Static validation can prove the companion boundary, traceability, and baseline file structure without executing setup commands.

## Requirements covered

- R29: the companion guide states that this first slice does not change the `terminal-first-windows-dev` vision or add macOS guides there by default.
- AC1: the companion baseline references the approved proposal/spec/test-spec/plan lineage.
- AC4: reader-facing macOS guide content is in the companion repository, not this Windows-first repository.
- AC5: M1 adds documentation and static proof only; it does not add setup automation, generated configuration, or hidden bootstrap behavior.

## Validation evidence

- First proof run before implementation failed as expected:
  - `cd /home/xiongxianfei/data/20260617-terminal-first-macos-dev && bash tests/markdown/macbook-setup-best-practices.test.sh`
  - Result: `FAIL: missing file: docs/guides/README.md`
- After implementation:
  - `cd /home/xiongxianfei/data/20260617-terminal-first-macos-dev && bash tests/markdown/macbook-setup-best-practices.test.sh`
  - Result: passed.
  - `cd /home/xiongxianfei/data/20260617-terminal-first-macos-dev && git diff --check`
  - Result: passed.
  - `cd /home/xiongxianfei/data/20260617-terminal-first-macos-dev && git diff --cached --check`
  - Result: passed before companion commit.

## Companion commit

- Branch: `macbook-setup-baseline`
- Commit: `f090d60 M1: establish macOS companion baseline`

## Remaining work

M1 is ready for code-review, not closed. M2 and M3 still need to author the full guide content and verification evidence surfaces. A real Apple silicon MacBook walkthrough is still required before verified command-success or compatibility claims can be published.
