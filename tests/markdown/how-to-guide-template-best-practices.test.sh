#!/usr/bin/env bash
set -euo pipefail

fail() {
  echo "$1" >&2
  exit 1
}

require_file() {
  local path="$1"
  test -f "$path" || fail "missing required file: $path"
}

require_text() {
  local path="$1"
  local text="$2"
  grep -Fq "$text" "$path" || fail "missing text in $path: $text"
}

require_regex() {
  local path="$1"
  local pattern="$2"
  grep -Eq "$pattern" "$path" || fail "missing pattern in $path: $pattern"
}

require_order() {
  local path="$1"
  local first="$2"
  local second="$3"
  local first_line
  local second_line

  first_line="$(grep -nF "$first" "$path" | head -n 1 | cut -d: -f1 || true)"
  second_line="$(grep -nF "$second" "$path" | head -n 1 | cut -d: -f1 || true)"

  test -n "$first_line" || fail "missing ordered text in $path: $first"
  test -n "$second_line" || fail "missing ordered text in $path: $second"
  test "$first_line" -lt "$second_line" || fail "expected '$first' before '$second' in $path"
}

template=docs/templates/how-to-guide.md

require_file "$template"
require_regex "$template" '^# <(Configure|Verb|[A-Z][^>]*)'

for text in \
  "<!--" \
  "Required for every guide" \
  "Conditional for state-changing or environment-sensitive guides" \
  "**Prerequisites:**" \
  "**Time:**" \
  "**Outcome:**" \
  "**Verify:**" \
  "**Scope:**" \
  "**Safety:**" \
  "## Fast path" \
  "## Walkthrough" \
  "## Rollback" \
  "## Troubleshooting" \
  "Expected result:" \
  "../troubleshooting/<topic>.md#<anchor>" \
  "Scope:" \
  "Backup:" \
  "Rollback:" \
  "powershell" \
  "bash" \
  "ini" \
  "toml" \
  "lua" \
  "tmux" \
  "not idempotent" \
  "secrets" \
  "proxy credentials" \
  "tokens" \
  "private hostnames" \
  "private certificate material"; do
  require_text "$template" "$text"
done

require_order "$template" "**Prerequisites:**" "## Fast path"
require_order "$template" "## Fast path" "## Walkthrough"
require_order "$template" "## Walkthrough" "## Rollback"
require_order "$template" "## Rollback" "## Troubleshooting"
require_order "$template" "Backup:" '```'

require_regex "$template" '^1\. '
require_regex "$template" '^   Run from <Windows PowerShell \| Ubuntu shell \| inside Neovim \| inside tmux>:'
require_text "$template" "Do not mix Windows and Ubuntu commands in one code block."
require_text "$template" 'Define placeholders such as `<UbuntuUser>` before using them.'
require_text "$template" "Prefer commands that can be re-run safely."
require_text "$template" 'Deep troubleshooting belongs under `docs/troubleshooting/`.'
require_text "$template" "Durable design rationale belongs in ADRs or architecture notes."
require_text "$template" "Rollback is required for persistent machine-changing guides."
require_text "$template" 'The final `Troubleshooting` section is a symptom router.'

test ! -f docs/guides/how-to-guide.md || fail "template must not live under docs/guides/how-to-guide.md"
test ! -f docs/guides/_template.md || fail "template must not live under docs/guides/_template.md"

if grep -Eiq "generated documentation site|template engine|one-command installer|hidden automation" "$template"; then
  fail "template must not introduce generated docs tooling or hidden automation"
fi
