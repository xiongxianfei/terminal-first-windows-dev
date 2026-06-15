# Explain Change: How-To Guide Template Best Practices

## Summary

This change defines and implements a stronger reusable template contract for terminal-first Windows development how-to guides. It keeps the approved two-speed guide shape while adding explicit shell context, expected results, conditional safety modules, backup-before-edit guidance, rollback guidance, and troubleshooting routing.

Current implementation evidence covers M1 and M2: the reusable template contract, its focused static proof, the proxy exemplar review, and the Ubuntu baseline portability pilot review. Broader static validation, final verification, and PR handoff remain open downstream stages.

## Decision Trail

| Stage | Decision or evidence |
| --- | --- |
| Proposal | `docs/proposals/2026-06-15-how-to-guide-template-best-practices.md` accepted the required core plus conditional safety-module direction. |
| Proposal review | `docs/proposals/2026-06-15-how-to-guide-template-best-practices.review.md` approved the proposal after resolving circular pilot-validation framing. |
| Spec | `specs/how-to-guide-template-best-practices.md` defined R1-R54 and AC1-AC14 for the template, exemplar, portability pilot, backup guidance, validation boundaries, and non-goals. |
| Spec review | `specs/how-to-guide-template-best-practices.review.md` approved the spec after HGT-SR-001 made backup guidance testable. |
| Test spec | `specs/how-to-guide-template-best-practices.test.md` is active and maps the proof surface to T1-T9. |
| Plan | `docs/changes/2026-06-15-how-to-guide-template-best-practices/plan.md` splits implementation into M1 template, M2 exemplar/pilot, M3 validation, and M4 lifecycle evidence. |

Architecture was marked not required because this change affects Markdown documentation structure and static validation expectations only.

## Diff Rationale By Area

| File | Change | Reason | Source artifact | Test or evidence |
| --- | --- | --- | --- | --- |
| `docs/templates/how-to-guide.md` | Replaced the minimal template with a copyable two-speed guide template containing required metadata, conditional `Scope` and `Safety`, fast path, walkthrough, rollback, troubleshooting, backup-before-edit fields, command context, expected results, and command-block conventions. | Satisfies the M1 template contract for R1-R29 and preserves compatibility with the two-speed guide structure. | Spec R1-R29, R52-R53; plan M1; test spec T1-T2. | `bash tests/markdown/how-to-guide-template-best-practices.test.sh` and M1 `rg` validation checks. |
| `tests/markdown/how-to-guide-template-best-practices.test.sh` | Added the focused M1 proof script for template structure, metadata, conditional modules, command-block conventions, troubleshooting boundaries, and non-goal guardrails. | Provides tests/proof before implementation and gives reviewers a repeatable static check. | Test spec T1-T2, T8; plan M1/M3 validation direction. | Initial run failed against the old template, then passed after the template update. |
| `docs/guides/03-ubuntu-baseline.md` | Converted the portability pilot to the two-speed guide shape while preserving the existing proxy, WSL config, APT source, shared data mount, locale, optional sudo, doctor expectation, rollback, and troubleshooting surfaces. | Satisfies M2 guide conformance and validates that the template works beyond the proxy exemplar. | Spec R30-R45, R52-R54; plan M2; test spec T3-T6. | M2 guide checks and `portability-pilot-review.md`. |
| `docs/changes/2026-06-15-how-to-guide-template-best-practices/exemplar-review.md` | Recorded dry-run exemplar review evidence for `proxy-setup.md`. | Proves the proxy guide is a reference exemplar without being the only pilot. | Spec R40, AC7; test spec T6. | M2 evidence checks. |
| `docs/changes/2026-06-15-how-to-guide-template-best-practices/portability-pilot-review.md` | Recorded dry-run portability-pilot review evidence for `03-ubuntu-baseline.md`. | Proves non-circular validation and records reviewer separation, dry-run mode, fast-path result, verification signal, walkthrough use, defects, and backup coverage. | Spec R41-R45, AC8-AC9; test spec T6. | M2 evidence checks. |
| `docs/changes/2026-06-15-how-to-guide-template-best-practices/plan.md` | Updated M1 state, progress, validation notes, and handoff state. | Keeps the active implementation plan aligned with actual milestone execution. | Implement skill and plan update requirements. | Plan marker checks and `git diff --check`. |
| `docs/changes/2026-06-15-how-to-guide-template-best-practices/change.yaml` | Added compact change metadata for current stage and next handoff. | Keeps change-local lifecycle routing discoverable. | Workflow artifact conventions and implement baseline pack. | File exists and is aligned with the active plan state. |

## Validation Evidence So Far

- `bash tests/markdown/how-to-guide-template-best-practices.test.sh` failed before the template change with missing contributor/template contract text.
- `bash -n tests/markdown/how-to-guide-template-best-practices.test.sh && bash tests/markdown/how-to-guide-template-best-practices.test.sh` passed after the template update.
- `test -f docs/templates/how-to-guide.md` passed.
- `rg -n "Prerequisites|Time|Outcome|Verify|Scope|Safety" docs/templates/how-to-guide.md` passed.
- `rg -n "^## Fast path$|^## Walkthrough$|^## Rollback$|^## Troubleshooting$" docs/templates/how-to-guide.md` passed.
- `rg -n "Backup|Rollback|Scope|powershell|bash|not idempotent|secrets|troubleshooting" docs/templates/how-to-guide.md` passed.
- `git diff --check` passed.
- M2 proof-first validation failed before the Ubuntu pilot rewrite with `missing text in docs/guides/03-ubuntu-baseline.md: **Prerequisites:**`.
- M2 evidence-record validation then failed until `exemplar-review.md` and `portability-pilot-review.md` were added.
- M2 final validation passed: `bash -n tests/markdown/how-to-guide-template-best-practices.test.sh && bash tests/markdown/how-to-guide-template-best-practices.test.sh`.
- M2 final `rg` checks passed for proxy backup coverage, guide metadata/sections, command context, expected results, rollback, troubleshooting, and evidence-file existence.

## Scope Control

This change does not:

- convert all guides;
- rename `docs/guides/03-ubuntu-baseline.md`;
- define or change setup command semantics;
- add command-execution CI;
- require a Windows + WSL runner;
- add generated documentation tooling, hidden automation, or installer behavior.

## Current State

M1 is closed after code review. M2 implementation is ready for code-review after targeted validation. M3, M4, code-review, review-resolution if needed, final verification, and PR handoff remain open.
