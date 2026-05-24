# Learn Session: Review Record Location Ambiguity

## Frame

- Trigger: Maintainer question after spec review: "Our project use rigorloop, it defines docs/changes to record review finding. Why don't we record the review finding under docs/changes?"
- Trigger type: explicit maintainer/contributor observation.
- Scope: review-record placement for proposal-review and spec-review findings in this repository.
- Evidence in scope:
  - `docs/workflows.md`
  - `CONSTITUTION.md`
  - `docs/proposals/2026-05-24-bootstrap-terminal-first-windows-dev.review.md`
  - `specs/terminal-first-workstation-setup.review.md`
- Explicit exclusions: no changes to workflow policy, skill behavior, or existing review artifacts in this session.
- Prior learnings reviewed: no existing `docs/learn/` records were present.
- Session record path: `docs/learn/sessions/2026-05-24-review-record-location-ambiguity.md`

## Observe

O1. The current project-local workflow guide maps proposal and spec reviews beside their source artifacts, while `docs/changes/<change-id>/review-log.md` is mapped specifically to code review.

Evidence:

- `docs/workflows.md` maps proposal review to `docs/proposals/YYYY-MM-DD-slug.review.md`.
- `docs/workflows.md` maps spec review to `specs/slug.review.md`.
- `docs/workflows.md` maps code review to `docs/changes/<change-id>/review-log.md`.
- `CONSTITUTION.md` describes `docs/changes/<change-id>/` as execution-plan scope for approved changes.

O2. The current change had no `docs/changes/<change-id>/` pack yet when proposal-review and spec-review ran.

Evidence:

- Workflow order places proposal-review and spec-review before architecture, plan, and implementation.
- No `docs/changes/` directory was present at the time of this learn session.
- The spec review happened before architecture, plan, test-spec, or implementation.

O3. The maintainer expects RigorLoop review findings to be recorded under `docs/changes/`, which conflicts with or extends the current project-local artifact map.

Evidence:

- The trigger question explicitly states that the project uses RigorLoop and that RigorLoop defines `docs/changes` to record review findings.
- `docs/workflows.md` currently does not say whether early lifecycle review findings should also be mirrored into a future change pack.

## Classify

| Observation ID | Proposed primary classification | Final primary classification | Secondary routes | Confirmed by | Rationale |
| --- | --- | --- | --- | --- | --- |
| O1 | observation | observation | none | evidence only | Current behavior follows the project-local workflow guide. |
| O2 | observation | observation | none | evidence only | There was no change pack to record into yet. |
| O3 | direction | candidate direction, unconfirmed | possible workflow proposal or workflow guide update | not confirmed for routing | This is maintainer direction or expectation, but there is not yet an accepted authoritative artifact changing the artifact map. |

## Route

- O1 and O2 are recorded in this session only.
- O3 is not routed yet because contributor confirmation is required before changing workflow policy or creating follow-up artifacts.
- No topic file was created because this is not yet a contributor-confirmed durable lesson.

## No-Learn Rationale

This session captured a useful workflow ambiguity, but not a durable lesson. The current behavior was consistent with `docs/workflows.md`; changing it would be workflow policy work, not learn-session authority.

## Follow-ups

No follow-up artifact was created in this session.

Candidate follow-up, pending owner confirmation: revise `docs/workflows.md` or create a workflow proposal to state whether early lifecycle review findings should be:

- stored beside proposals/specs until a change pack exists;
- mirrored into `docs/changes/<change-id>/review-log.md` after a change pack is created;
- recorded only in `docs/changes/<change-id>/review-log.md` once the project chooses change-pack-first workflow for all non-trivial work.
