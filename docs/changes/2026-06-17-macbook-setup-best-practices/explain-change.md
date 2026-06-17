# MacBook Setup Best Practices Change Explanation

## Status

M3 implementation is ready for code-review.

## What changed

M1 established the separate macOS companion baseline in `../20260617-terminal-first-macos-dev`:

- Replaced the template README with `terminal-first-macos-dev` identity, scope, validation, and traceability.
- Added `docs/guides/README.md` as the guide index.
- Added `docs/guides/macbook-terminal-baseline.md` as the first-slice guide scaffold.
- Added `docs/verification/macbook-terminal-baseline.md` as the manual verification template.
- Added `tests/markdown/macbook-setup-best-practices.test.sh` as the static baseline proof.

M2 added the personal MacBook terminal-baseline guide content and expanded the static proof:

- Updated `docs/guides/macbook-terminal-baseline.md` with prerequisites, outcome, safety gates, ownership routing, hardware and compatibility guidance, backup and Apple-owned system setup, Apple developer tooling, Homebrew boundaries, shell/Git/SSH/editor baseline, and follow-up routing.
- Updated `tests/markdown/macbook-setup-best-practices.test.sh` to check required sections, safety-gate ordering, managed-Mac routing, Apple silicon and Intel non-claim language, Homebrew boundaries, shell/Git/SSH coverage, persistent-state auditability, and non-goal guardrails.
- Updated companion README and guide index status text from scaffold to guide content.
- Resolved CR-M2-001 by adding official Apple/Homebrew source links and static proof assertions for those links.
- M3 added the manual verification evidence package and expanded proof checks for required evidence fields, status labels, transcript scrubbing, and claim boundaries.

The current Windows-first repository was updated only for lifecycle tracking: change metadata, plan index, and the active plan.

## Why it changed

The approved proposal, spec, test spec, and plan require MacBook setup guidance to live in a separate macOS companion surface rather than inside `terminal-first-windows-dev`.

M1 intentionally created locations and checks before full setup guidance:

- Guide content belongs in the companion repo.
- Verification evidence has a durable path before any command-success or compatibility claims are made.
- Static validation can prove the companion boundary, traceability, and baseline file structure without executing setup commands.

M2 intentionally keeps the guide evidence-bound:

- Commands are presented as guide contracts for later manual verification, not as verified transcripts.
- Managed/corporate Macs route out of the default path before state-changing setup.
- Homebrew is scoped to third-party developer CLI tooling and separated from Apple-owned system setup.
- Role-specific stacks and full editor configuration remain deferred.
- Source references are explicit for Apple Software Update, Apple Command Line Tools, Homebrew installation documentation, and the Homebrew install/uninstall script repository.

M3 intentionally does not mark commands verified:

- The manual walkthrough template requires a real Apple silicon MacBook running the latest stable macOS offered by Software Update.
- The guide and template keep command-success, setup-completion, and compatibility language unverified until evidence is recorded.
- Verification statuses distinguish `verified`, `manually checked`, `skipped`, `blocked`, and `policy-dependent`.

## Requirements covered

- R29: the companion guide states that this first slice does not change the `terminal-first-windows-dev` vision or add macOS guides there by default.
- AC1: the companion baseline references the approved proposal/spec/test-spec/plan lineage.
- AC4: reader-facing macOS guide content is in the companion repository, not this Windows-first repository.
- AC5: M1 adds documentation and static proof only; it does not add setup automation, generated configuration, or hidden bootstrap behavior.
- R1-R23, R27-R29: M2 covers the personal developer MacBook terminal-baseline guide requirements.
- AC2-AC5, AC7: M2 extends requirement coverage, keeps reader-facing macOS content in the companion repo, avoids hidden automation, and routes managed/corporate Macs out of the default path.
- R24-R26, R4-R6, R7, R18, R21, R25, AC6, AC8: M3 adds the verification evidence template, claim boundary, and proof assertions while preserving unverified status until real walkthrough evidence exists.

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
- M2 first proof run before guide implementation failed as expected:
  - `cd /home/xiongxianfei/data/20260617-terminal-first-macos-dev && bash tests/markdown/macbook-setup-best-practices.test.sh`
  - Result: `FAIL: docs/guides/macbook-terminal-baseline.md missing Prerequisites section`
- After M2 implementation:
  - `cd /home/xiongxianfei/data/20260617-terminal-first-macos-dev && bash tests/markdown/macbook-setup-best-practices.test.sh`
  - Result: passed.
  - `cd /home/xiongxianfei/data/20260617-terminal-first-macos-dev && git diff --check`
  - Result: passed.
  - `cd /home/xiongxianfei/data/20260617-terminal-first-macos-dev && git diff --cached --check`
  - Result: passed before companion commit.
- CR-M2-001 resolution:
  - `cd /home/xiongxianfei/data/20260617-terminal-first-macos-dev && bash tests/markdown/macbook-setup-best-practices.test.sh`
  - Expected pre-fix result: `FAIL: docs/guides/macbook-terminal-baseline.md missing official Apple Software Update source link`
  - Post-fix result: passed.
  - `cd /home/xiongxianfei/data/20260617-terminal-first-macos-dev && git diff --check`
  - Result: passed.
- M3 first proof run before verification-template implementation failed as expected:
  - `cd /home/xiongxianfei/data/20260617-terminal-first-macos-dev && bash tests/markdown/macbook-setup-best-practices.test.sh`
  - Result: `FAIL: docs/verification/macbook-terminal-baseline.md missing manual walkthrough record section`
- After M3 implementation:
  - `cd /home/xiongxianfei/data/20260617-terminal-first-macos-dev && bash tests/markdown/macbook-setup-best-practices.test.sh`
  - Result: passed.
  - `cd /home/xiongxianfei/data/20260617-terminal-first-macos-dev && git diff --check`
  - Result: passed.
  - `cd /home/xiongxianfei/data/20260617-terminal-first-macos-dev && git diff --cached --check`
  - Result: passed before companion commit.

## Companion commit

- Branch: `macbook-setup-baseline`
- Commit: `f090d60 M1: establish macOS companion baseline`
- Commit: `2a503a8 M2: add MacBook terminal baseline guide`
- Commit: `271f260 M2: add source reference checks`
- Commit: `1fe76fd M3: add MacBook setup verification evidence`

## Remaining work

M1 and M2 are closed. M3 is ready for code-review, not closed. A real Apple silicon MacBook walkthrough is still required before verified command-success or compatibility claims can be published.
