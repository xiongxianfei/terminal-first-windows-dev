# MacBook Setup Best Practices Plan

## Status

- Plan lifecycle state: active
- Terminal disposition: not-terminal

## Purpose / big picture

Sequence the approved MacBook setup best-practices spec into reviewable implementation slices for a separate macOS companion surface, recommended as `terminal-first-macos-dev`.

The work remains documentation-first and terminal-first. The first slice must produce a personal developer MacBook terminal-baseline guide with explicit safety gates, package-source trust assumptions, shell boundaries, Git/SSH readiness, and manual verification evidence. It must not add macOS setup guide content to `terminal-first-windows-dev` unless a separate vision-revision proposal changes this repository's scope.

## Source artifacts

- Proposal: `docs/proposals/2026-06-17-macbook-setup-best-practices.md`
- Proposal review: `docs/changes/2026-06-17-macbook-setup-best-practices/reviews/proposal-review-r2.md`
- Spec: `specs/macbook-setup-best-practices.md`
- Spec review: `docs/changes/2026-06-17-macbook-setup-best-practices/reviews/spec-review-r1.md`
- Architecture: not required for the first slice because the approved spec excludes Brewfiles, scripts, generated shell configuration, hidden dotfile bootstrap, and setup automation
- Test spec: `specs/macbook-setup-best-practices.test.md`
- Workflow guide: `docs/workflows.md`
- Constitution: `CONSTITUTION.md`

## Context and orientation

The accepted direction is a macOS companion surface, not a cross-platform rewrite of this repository. The plan therefore records the implementation sequence and evidence expectations here, while the eventual reader-facing guide files should be created in the owner-created companion repository at `../20260617-terminal-first-macos-dev`.

The approved spec defines a first-slice personal developer Apple silicon MacBook path. Corporate-managed Macs, Intel compatibility, Mac App Store automation, GUI app bundles, language runtimes, containers, cloud tooling, and full editor configuration are out of the default first slice unless later proposals or verification evidence add them.

Architecture is not needed before this plan because no machine-changing automation is in scope. If implementation introduces Brewfiles, scripts, generated shell configuration, dotfile bootstrap, or setup automation, stop and author architecture before continuing.

## Non-goals

- Adding macOS setup guide content to `terminal-first-windows-dev` by default.
- Revising `VISION.md` to make this repository cross-platform.
- Creating Brewfiles, generated dotfiles, helper scripts, one-command bootstrap, or hidden automation.
- Claiming command success or compatibility without recorded manual verification on a real Mac.
- Covering managed/corporate Mac setup as the default path.
- Covering web development, Python, containers, cloud CLIs, GUI app bundles, Mac App Store automation, or full editor configuration in the first slice.
- Claiming Intel support without separate Intel verification evidence.

## Requirements covered

| Requirements | Plan coverage |
|---|---|
| R1-R3, R28 | M2 handles ownership context and managed/corporate Mac routing. |
| R4-R6 | M2 handles hardware, architecture, Apple silicon default, and Intel non-claim language. |
| R7-R12 | M2 handles backup, Software Update, FileVault, Apple Account, administrator-account, and Privacy & Security sections. |
| R13-R18 | M2 handles Command Line Tools and Homebrew boundaries, trust, prefix, update, and rollback notes. |
| R19-R23, R27 | M2 handles shell boundaries, Git/SSH, minimal editor availability, auditability, and follow-up routing. |
| R24-R26 | M3 handles verification checklist, evidence template, and command-success claim guards. |
| R29 | M1 and M2 keep the companion-surface boundary visible. |
| AC1-AC8 | M1-M3 collectively create traceability, requirement coverage, companion-surface boundaries, verification evidence, and managed-Mac routing. |

## Current Handoff Summary

- Current milestone: M1
- Current milestone state: review-requested
- Last reviewed milestone: none
- Review status: M1 implementation complete; code-review pending
- Remaining in-scope implementation milestones: M1, M2, M3
- Next stage: code-review
- Final closeout readiness: not-ready
- Reason final closeout is or is not ready: M1 implementation is ready for code-review, but M1 is not reviewed or closed and downstream M2, M3, explanation, verification, and PR handoff remain open.

## Milestones

### M1. Companion surface and validation baseline

- Milestone state: review-requested
- Goal: Establish or connect the macOS companion surface and its first-slice validation baseline before writing guide content.
- Requirements: R29, AC1, AC4, AC5
- Files/components likely touched:
  - `../20260617-terminal-first-macos-dev/README.md`
  - `../20260617-terminal-first-macos-dev/docs/guides/`
  - `../20260617-terminal-first-macos-dev/docs/verification/`
  - `../20260617-terminal-first-macos-dev/tests/markdown/`
  - `docs/plans/2026-06-17-macbook-setup-best-practices.md`
- Dependencies:
  - Owner-created companion repository exists at `../20260617-terminal-first-macos-dev`.
  - Plan review approval.
  - Test specification that maps R1-R29 to static checks, command review, and manual walkthrough evidence.
- Tests to add/update:
  - Static check for required first-slice guide sections.
  - Static check that the companion guide states it is a macOS companion surface and does not modify `terminal-first-windows-dev` scope.
  - Link check for local guide and verification links once companion paths exist.
- Implementation steps:
  - Use `../20260617-terminal-first-macos-dev` as the companion repository workdir.
  - Create minimal guide, verification, and test directories in the companion surface.
  - Add or adapt a lightweight Markdown validation script for the first-slice guide structure.
  - Add traceability references back to the approved proposal and spec without copying Windows-specific scope into the companion guide.
- Validation commands:
  - `cd /home/xiongxianfei/data/20260524-terminal-dev && git diff --check -- docs/plans/2026-06-17-macbook-setup-best-practices.md docs/changes/2026-06-17-macbook-setup-best-practices/review-log.md docs/changes/2026-06-17-macbook-setup-best-practices/review-resolution.md`
  - `cd /home/xiongxianfei/data/20260617-terminal-first-macos-dev && git diff --check`
  - `cd /home/xiongxianfei/data/20260617-terminal-first-macos-dev && bash tests/markdown/macbook-setup-best-practices.test.sh`
- Expected observable result: A companion surface exists with guide, verification, and validation locations ready for first-slice content.
- Implementation evidence:
  - Companion branch: `macbook-setup-baseline`
  - Companion commit: `f090d60 M1: establish macOS companion baseline`
  - Proof added first: `../20260617-terminal-first-macos-dev/tests/markdown/macbook-setup-best-practices.test.sh`
  - Expected failing proof before implementation: `bash tests/markdown/macbook-setup-best-practices.test.sh` failed with `FAIL: missing file: docs/guides/README.md`.
  - Implemented surfaces: `README.md`, `docs/guides/README.md`, `docs/guides/macbook-terminal-baseline.md`, `docs/verification/macbook-terminal-baseline.md`, and `tests/markdown/macbook-setup-best-practices.test.sh` in the companion repository.
- Commit message: `M1: establish macOS companion baseline`
- Milestone closeout:
  - validation passed
  - progress updated
  - decision log updated if needed
  - validation notes updated
  - milestone committed
- Risks:
  - Companion repo default files may need alignment with the approved first-slice scope.
  - Validation becomes too specific before guide content exists.
  - Windows repo scope leaks into companion guide language.
- Rollback/recovery:
  - Revert companion-surface scaffolding and keep this plan active until the companion repo baseline is usable.

### M2. Personal MacBook terminal-baseline guide

- Milestone state: planned
- Goal: Author the first-slice guide content for a personal developer Apple silicon MacBook terminal baseline.
- Requirements: R1-R23, R27-R29, AC2-AC5, AC7
- Files/components likely touched:
  - `../20260617-terminal-first-macos-dev/docs/guides/macbook-terminal-baseline.md`
  - `../20260617-terminal-first-macos-dev/docs/guides/README.md`
  - `../20260617-terminal-first-macos-dev/tests/markdown/macbook-setup-best-practices.test.sh`
- Dependencies:
  - M1 closed.
  - Test spec approved.
  - No Brewfile, script, generated config, or hidden automation added; otherwise architecture becomes mandatory before implementation continues.
- Tests to add/update:
  - Static checks for ownership context before state-changing sections.
  - Static checks for Apple silicon default and Intel non-claim language.
  - Static checks for backup, Software Update, FileVault, Privacy & Security, Command Line Tools, Homebrew, shell boundaries, Git/SSH, minimal editor, and managed-Mac routing sections.
  - Link checks for Apple and Homebrew source references.
- Implementation steps:
  - Write the guide's prerequisites, scope, outcome, safety, and verification overview.
  - Add ownership and managed-Mac stop conditions before setup guidance.
  - Add hardware and CPU architecture inspection guidance without claiming unverified compatibility.
  - Add backup, Software Update, FileVault, Apple Account, administrator-account, and Privacy & Security sections.
  - Add Apple Command Line Tools and Homebrew sections with source-trust, prefix, update, and rollback notes.
  - Add conservative shell boundary, Git identity, SSH key handling, credential expectation, and minimal editor availability sections.
  - Add follow-up routing for role-specific stacks and managed/corporate Macs.
- Validation commands:
  - `cd /home/xiongxianfei/data/20260617-terminal-first-macos-dev && bash tests/markdown/macbook-setup-best-practices.test.sh`
  - `cd /home/xiongxianfei/data/20260617-terminal-first-macos-dev && git diff --check`
  - `cd /home/xiongxianfei/data/20260524-terminal-dev && git diff --check -- docs/plans/2026-06-17-macbook-setup-best-practices.md docs/changes/2026-06-17-macbook-setup-best-practices/review-log.md docs/changes/2026-06-17-macbook-setup-best-practices/review-resolution.md`
- Expected observable result: The companion guide covers the approved first-slice terminal baseline without automation, role-stack sprawl, managed-Mac defaults, Intel claims, or unverified command-success claims.
- Commit message: `M2: add MacBook terminal baseline guide`
- Milestone closeout:
  - validation passed
  - progress updated
  - decision log updated if needed
  - validation notes updated
  - milestone committed
- Risks:
  - The guide becomes a broad macOS app checklist.
  - Homebrew is presented as an Apple-owned system setup tool.
  - Managed-Mac users receive unsafe generic instructions.
  - Shell or credential guidance changes persistent state without visible rollback.
- Rollback/recovery:
  - Revert the guide body and tests for M2 while preserving M1 companion scaffolding.

### M3. Verification evidence and manual walkthrough package

- Milestone state: planned
- Goal: Add the verification template and manual walkthrough evidence path required before command success or compatibility is claimed.
- Requirements: R24-R26, R4-R6, R7, R18, R21, R25, AC6, AC8
- Files/components likely touched:
  - `../20260617-terminal-first-macos-dev/docs/verification/macbook-terminal-baseline.md`
  - `../20260617-terminal-first-macos-dev/docs/guides/macbook-terminal-baseline.md`
  - `../20260617-terminal-first-macos-dev/tests/markdown/macbook-setup-best-practices.test.sh`
- Dependencies:
  - M2 closed.
  - Access to a real Apple silicon MacBook for manual verification before any success claims are published.
- Tests to add/update:
  - Static check that verification evidence fields include `sw_vers`, hardware model, CPU architecture, Command Line Tools state, Homebrew prefix, Homebrew health, Git availability, SSH readiness, minimal editor launch, verification date, and verifier context.
  - Static check that the guide labels compatibility or command success as unverified until evidence is recorded.
  - Manual walkthrough checklist on a real Apple silicon MacBook.
- Implementation steps:
  - Add a verification evidence template with required fields from R25.
  - Add guide text that distinguishes verified, manually checked, skipped, blocked, and policy-dependent steps.
  - Run or schedule the manual walkthrough on a real Apple silicon MacBook.
  - Record exact verification evidence before changing any compatibility or command-success language from unverified to verified.
  - Add transcript-scrubbing instructions for private data, keys, usernames, paths, and organization identifiers.
- Validation commands:
  - `cd /home/xiongxianfei/data/20260617-terminal-first-macos-dev && bash tests/markdown/macbook-setup-best-practices.test.sh`
  - `cd /home/xiongxianfei/data/20260617-terminal-first-macos-dev && git diff --check`
  - `cd /home/xiongxianfei/data/20260524-terminal-dev && git diff --check -- docs/plans/2026-06-17-macbook-setup-best-practices.md docs/changes/2026-06-17-macbook-setup-best-practices/review-log.md docs/changes/2026-06-17-macbook-setup-best-practices/review-resolution.md`
  - Manual: complete the verification checklist on a real Apple silicon MacBook and record exact `sw_vers`, hardware model, CPU architecture, Command Line Tools state, Homebrew prefix, verification date, and verifier context.
- Expected observable result: The companion guide has a durable verification evidence path and does not claim success or compatibility beyond recorded evidence.
- Commit message: `M3: add MacBook setup verification evidence`
- Milestone closeout:
  - validation passed
  - manual verification evidence recorded or claims remain explicitly unverified
  - progress updated
  - decision log updated if needed
  - validation notes updated
  - milestone committed
- Risks:
  - No Apple silicon MacBook is available for manual verification.
  - Verification transcript leaks private data.
  - The guide overstates compatibility based on incomplete evidence.
- Rollback/recovery:
  - Revert verification-claim changes and leave the guide marked unverified until real evidence is available.

## Validation plan

- From `/home/xiongxianfei/data/20260524-terminal-dev`, use `git diff --check` for plan metadata and lifecycle-record edits in this repository.
- From `/home/xiongxianfei/data/20260617-terminal-first-macos-dev`, use `git diff --check` for companion-repo guide, verification, and test edits.
- From `/home/xiongxianfei/data/20260617-terminal-first-macos-dev`, use `bash tests/markdown/macbook-setup-best-practices.test.sh` to validate first-slice guide structure, required sections, companion-surface boundary, managed-Mac routing, compatibility claims, and verification evidence fields.
- Manual command review: confirm that setup commands and expected results match the documented execution context before publication.
- Manual walkthrough on one real Apple silicon MacBook: record the R25 evidence fields before any command-success or compatibility claims are marked verified.
- Link check command: to be selected in the companion repo before implementation; plan-review should challenge this if the companion repo already has a preferred link checker.

## Risks and recovery

- Risk: The companion repository baseline does not match the approved first-slice scope.
  - Recovery: Keep M1 planned and adjust only companion-repo scaffolding after plan-review and test-spec.
- Risk: The work drifts into a broad macOS productivity or role-stack guide.
  - Recovery: Revert out-of-scope sections and route role-specific content to separate follow-up modules.
- Risk: Setup guidance includes automation despite the spec excluding it.
  - Recovery: Stop implementation and author architecture before continuing, or remove the automation.
- Risk: Managed/corporate Mac users receive unsafe default guidance.
  - Recovery: Move managed-Mac details behind policy-dependent routing and keep the personal Mac path explicit.
- Risk: Verification evidence cannot be collected.
  - Recovery: Keep command-success and compatibility language explicitly unverified.

## Dependencies

- Owner-created companion repository exists at `../20260617-terminal-first-macos-dev`.
- Spec review is approved with no open findings.
- Plan review R2 approved this plan.
- Test spec is approved at `specs/macbook-setup-best-practices.test.md`.
- A real Apple silicon MacBook is required before verified command-success or compatibility claims can be published.
- Architecture is required only if future work introduces Brewfiles, scripts, generated shell configuration, hidden dotfile bootstrap, setup automation, or other machine-changing automation.

## Progress

- 2026-06-17: Created plan from accepted proposal and approved spec-review evidence.
- 2026-06-17: Recorded owner-created companion repository workdir `../20260617-terminal-first-macos-dev` as the implementation surface.
- 2026-06-17: Revised validation commands to name the current repository and companion repository workdirs, addressing plan-review PR-001 pending second-pass plan-review.
- 2026-06-17: Authored `specs/macbook-setup-best-practices.test.md`; next stage is M1 implementation.
- 2026-06-17: Implemented M1 companion baseline in `../20260617-terminal-first-macos-dev` on branch `macbook-setup-baseline` with commit `f090d60`.

## Decision log

| Date | Decision | Reason | Alternatives rejected |
| --- | --- | --- | --- |
| 2026-06-17 | Plan implementation for a separate macOS companion surface, not this Windows repository. | The accepted proposal and approved spec keep `terminal-first-windows-dev` Windows-first. | Adding macOS guide content to this repository by default. |
| 2026-06-17 | Use `../20260617-terminal-first-macos-dev` as the companion repository workdir. | The owner created the GitHub repository and local workdir for the macOS companion surface. | Continuing to leave the companion path unresolved. |
| 2026-06-17 | Require explicit repository workdirs in validation commands. | The plan spans this Windows repo for lifecycle artifacts and the sibling macOS repo for implementation files, so bare paths are ambiguous. | Bare `git diff --check` and `bash tests/markdown/...` commands without workdir context. |
| 2026-06-17 | Skip architecture for the first slice unless automation is introduced. | The approved spec excludes Brewfiles, scripts, generated config, hidden dotfile bootstrap, and setup automation. | Running architecture unconditionally for documentation-only guide work. |
| 2026-06-17 | Require test-spec before implementation. | The spec contains many safety, compatibility, and verification requirements that need traceable checks. | Implementing guide content directly after plan-review. |
| 2026-06-17 | Keep M1 validation focused on companion baseline surfaces rather than full setup content. | M1 establishes guide, verification, and proof locations; M2 and M3 own the full guide contract and real verification evidence. | Making M1's proof require content that the approved plan assigns to later milestones. |

## Surprises and discoveries

- The companion repository still contained template README content before M1. M1 replaced it with project-specific companion identity and validation instructions.
- The first proof run failed as expected because the guide index did not exist yet.
- The proof script initially failed on evidence-field capitalization; the implementation fixed the check to match case-insensitively while preserving the required fields.

## Validation notes

- `cd /home/xiongxianfei/data/20260617-terminal-first-macos-dev && bash tests/markdown/macbook-setup-best-practices.test.sh`: passed.
- `cd /home/xiongxianfei/data/20260617-terminal-first-macos-dev && git diff --check`: passed before companion commit.
- `cd /home/xiongxianfei/data/20260617-terminal-first-macos-dev && git diff --cached --check`: passed before companion commit.
- `cd /home/xiongxianfei/data/20260524-terminal-dev && git diff --check -- docs/plans/2026-06-17-macbook-setup-best-practices.md docs/changes/2026-06-17-macbook-setup-best-practices/change.yaml docs/changes/2026-06-17-macbook-setup-best-practices/explain-change.md docs/plan.md`: passed.
- `cd /home/xiongxianfei/data/20260524-terminal-dev && git diff --check`: passed.
- `cd /home/xiongxianfei/data/20260617-terminal-first-macos-dev && bash tests/markdown/macbook-setup-best-practices.test.sh && git diff --check`: passed after companion commit.

## Outcome and retrospective

- M1 implementation is ready for code-review. M1 is not closed until code-review and any required review-resolution are complete.

## Readiness

- See `Current Handoff Summary`.
- Ready for M1 code-review. Readiness is not Done; M1 review, any review-resolution, M2, M3, explanation, final verification, and PR handoff remain.
