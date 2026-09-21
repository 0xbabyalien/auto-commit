#!/usr/bin/env bash
set -euo pipefail

LOG_FILE="COMMIT_LOG.md"
STATE_FILE=".commit-state"
TODAY="$(date -u +%Y-%m-%d)"

# Original set of short dev-notes, rotated deterministically by commit count
# rather than pure randomness, so the sequence is reproducible and testable.
NOTES=(
  "Small consistent steps compound faster than sporadic large ones."
  "A quiet repo is not a dead one; check the issues, not just the graph."
  "Automate the boring parts so you can think about the interesting ones."
  "Version control is a diary your future self will thank you for."
  "Green squares are a side effect, not a goal. Ship something real too."
  "Read your own commit history once a month. It teaches you your habits."
  "The best documentation is the one you wish existed when you were stuck."
  "Refactor with tests, not with hope."
)

# Initialize state file on first run
if [ ! -f "$STATE_FILE" ]; then
  echo "0" > "$STATE_FILE"
fi

COMMIT_COUNT=$(cat "$STATE_FILE")
COMMIT_COUNT=$((COMMIT_COUNT + 1))
echo "$COMMIT_COUNT" > "$STATE_FILE"

NOTE_INDEX=$((COMMIT_COUNT % ${#NOTES[@]}))
NOTE="${NOTES[$NOTE_INDEX]}"

# Initialize log file with a header on first run
if [ ! -f "$LOG_FILE" ]; then
  printf '# Commit Log\n\nAutomated activity log. One entry per run.\n\n' > "$LOG_FILE"
fi

{
  printf -- '- **Commit #%s** (%s) — %s\n' "$COMMIT_COUNT" "$TODAY" "$NOTE"
} >> "$LOG_FILE"

echo "Appended commit $COMMIT_COUNT entry for $TODAY."
