#!/usr/bin/env bash
# Human-in-the-loop reproduction loop.
# Copy this file, edit the steps below, and ask the user to run it.
#
# The user runs the script in their own terminal: it reads from the keyboard,
# so it can't run inside the agent's shell tool. The captured answers are
# saved to $HITL_OUT (default: $TMPDIR/hitl-capture.txt, falling back to /tmp)
# for the agent to read once the user says they're done.
#
# Usage:
#   bash hitl-loop.sh
#
# Two helpers:
#   step "<instruction>"          → show instruction, wait for Enter
#   capture VAR "<question>"      → show question, read response into VAR
#                                   (a multi-line paste is kept whole). Name
#                                   VAR in UPPER_CASE: capture's own locals
#                                   are lower-case and would swallow it.
#
# `capture` saves its value to the output file, where the agent reads it,
# so capture observations, and leave signing in to the user as a `step`.

set -euo pipefail

if [[ ! -t 0 ]]; then
  printf 'This script needs a keyboard. Run it in your own terminal:\n  bash %s\n' "$0" >&2
  exit 2
fi

# Outside the repo, so pasted output (which can carry tokens) never gets committed.
OUT="${HITL_OUT:-${TMPDIR:-/tmp}/hitl-capture.txt}"
: > "$OUT"

# Lines still queued this soon after the first one are the rest of a paste.
# bash 3.2 (macOS) only takes whole-second timeouts.
_PASTE_WAIT=0.1
(( BASH_VERSINFO[0] >= 4 )) || _PASTE_WAIT=1

step() {
  printf '\n>>> %s\n' "$1"
  read -r -p "    [Enter when done] " _
}

capture() {
  local var="$1" question="$2" answer line="" pasted=0
  printf '\n>>> %s\n' "$question"
  read -r -p "    > " answer
  # Anything already queued is the rest of a multi-line paste: keep it, so it
  # can't answer the next prompt or run as commands in the user's shell after
  # the script exits. -n reads the terminal raw, so a last line with no
  # newline shows up too; a timed-out read keeps it.
  while IFS= read -r -n 65536 -t "$_PASTE_WAIT" line; do
    answer+=$'\n'"$line"; line=""; pasted=1
  done
  [[ -z "$line" ]] || { answer+=$'\n'"$line"; pasted=1; }
  if (( pasted )); then
    # Swallow the Enter that ends the paste, plus any lines typed after it.
    printf '\n    (press Enter on an empty line to finish)\n'
    while IFS= read -r line && [[ -n "$line" ]]; do answer+=$'\n'"$line"; done
  fi
  printf -v "$var" '%s' "$answer"
  printf '### %s\n%s\n\n' "$var" "$answer" >> "$OUT"
}

# --- edit below ---------------------------------------------------------

step "Open the app at http://localhost:3000 and sign in."

capture ERRORED "Click the 'Export' button. Did it throw an error? (y/n)"

capture ERROR_MSG "Paste the error message (or 'none'):"

# --- edit above ---------------------------------------------------------

printf '\n--- Saved your answers to %s. Tell the agent you are done. ---\n' "$OUT"
