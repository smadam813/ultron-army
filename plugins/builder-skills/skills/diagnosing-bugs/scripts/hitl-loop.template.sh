#!/usr/bin/env bash
# Human-in-the-loop reproduction loop.
# Copy this file, edit the steps below, and ask the user to run it.
#
# The user runs the script in their own terminal: it reads from the keyboard,
# so it can't run inside the agent's shell tool. The captured answers are
# saved to $HITL_OUT (default: hitl-capture.txt next to the script) for the
# agent to read once the user says they're done.
#
# Usage:
#   bash hitl-loop.sh
#
# Two helpers:
#   step "<instruction>"          → show instruction, wait for Enter
#   capture VAR "<question>"      → show question, read response into VAR
#                                   (a multi-line paste is kept whole)
#
# `capture` saves its value to the output file, where the agent reads it,
# so capture observations, and leave signing in to the user as a `step`.

set -euo pipefail

if [[ ! -t 0 ]]; then
  printf 'This script needs a keyboard. Run it in your own terminal:\n  bash %s\n' "$0" >&2
  exit 2
fi

OUT="${HITL_OUT:-$(dirname "$0")/hitl-capture.txt}"
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
  local var="$1" question="$2" answer line="" rest
  printf '\n>>> %s\n' "$question"
  read -r -p "    > " answer
  if IFS= read -r -t "$_PASTE_WAIT" line; then
    # A multi-line paste: keep all of it, so the rest can't answer the next
    # prompt or run as commands in the user's shell after the script exits.
    # Its last line may lack a newline, so finish on an empty line.
    answer+=$'\n'"$line"; line=""
    while IFS= read -r -t "$_PASTE_WAIT" line; do answer+=$'\n'"$line"; line=""; done
    rest="$line"   # a timed-out read keeps the partial last line
    printf '\n    (press Enter on an empty line to finish)\n'
    while IFS= read -r line; do
      line="$rest$line"; rest=""
      [[ -n "$line" ]] || break
      answer+=$'\n'"$line"
    done
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
