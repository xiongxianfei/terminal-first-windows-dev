# <Configure the desired outcome>

**Prerequisites:** <required starting state, tools, policy approvals, or existing setup>.
**Time:** <estimated time>.
**Outcome:** <what is true after the task is complete>.
**Verify:** `<top-level verification command or observable result>`.

## Fast path

1. <Run the minimum command or edit needed for the happy path.>

   ```text
   <command or configuration snippet>
   ```

   Expected result: <short observable result>.

2. <Run the next required command or check.>

   ```text
   <command or configuration snippet>
   ```

   Expected result: <short observable result>.

3. Verify the task.

   ```text
   <verification command>
   ```

   Expected result: <what success looks like>.

   If this fails with <specific symptom>, see [`docs/troubleshooting/<topic>.md#<anchor>`](../troubleshooting/<topic>.md#<anchor>).

## Walkthrough

### 1. <Repeat fast-path step 1 as an outcome-oriented heading>

<Explain why this step is needed, what it changes, and any local policy or safety assumption the reader should know before running it. Keep design rationale brief and link to ADRs or architecture notes when deeper rationale is needed.>

```text
<same command or configuration snippet as the fast path>
```

Expected result: <short observable result>.

Rollback: <how to undo this step, or `not applicable` for read-only checks>.

### 2. <Repeat fast-path step 2 as an outcome-oriented heading>

<Add context that helps a newer reader complete the same task flow without turning the guide into a tutorial.>

```text
<same command or configuration snippet as the fast path>
```

Expected result: <short observable result>.

Rollback: <how to undo this step, or `not applicable` for read-only checks>.

### 3. Verify the task

```text
<verification command>
```

Expected result: <what success looks like>.

If this fails, use the targeted troubleshooting entry that matches the symptom:

- <Symptom>: [`docs/troubleshooting/<topic>.md#<anchor>`](../troubleshooting/<topic>.md#<anchor>)

## Rollback

<Summarize rollback for the whole task, or write `not applicable` when the guide is verification-only. Keep detailed recovery in `docs/troubleshooting/` when the recovery tree is long.>

## Troubleshooting

Use troubleshooting links at the step where failure is likely. Keep deep recovery instructions in `docs/troubleshooting/`, not in this guide.

## Review checklist

- The title describes the desired outcome.
- Prerequisites, Time, Outcome, and Verify appear before the first setup command.
- Fast path and Walkthrough use the same numbered task flow.
- Every meaningful state-changing step has a nearby expected result or verification.
- Commands use clear shell or file-format fences.
- Troubleshooting links point to specific files and anchors where stable anchors exist.
- Security-sensitive commands call out their impact near the command.
- Design rationale is brief and links to ADRs or architecture notes when needed.
