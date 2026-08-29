#!/usr/bin/env bash
# Install capitalist-code-skill into Cursor (~/.cursor/skills) and Cline (~/.cline/skills).
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
LANG_VARIANT="${1:-en}"   # en | zh-CN
CURSOR_SKILLS="${CURSOR_SKILLS_DIR:-$HOME/.cursor/skills}"
CLINE_SKILLS="${CLINE_SKILLS_DIR:-$HOME/.cline/skills}"

if [[ "$LANG_VARIANT" != "en" && "$LANG_VARIANT" != "zh-CN" ]]; then
  echo "Usage: $0 [en|zh-CN]"
  exit 1
fi

SRC="$ROOT/skills/$LANG_VARIANT"
if [[ ! -d "$SRC/cline-handoff-spec" ]]; then
  echo "Missing $SRC — clone the full repo."
  exit 1
fi

mkdir -p "$CURSOR_SKILLS" "$CLINE_SKILLS"

link_skill() {
  local name="$1" dest_root="$2"
  local from="$SRC/$name"
  local to="$dest_root/$name"
  if [[ -e "$to" || -L "$to" ]]; then
    rm -rf "$to"
  fi
  ln -sfn "$from" "$to"
  echo "linked $to -> $from"
}

# Cursor: write for Cline + execute Cursor-bound specs + shared protocol pack
link_skill cline-handoff-spec "$CURSOR_SKILLS"
link_skill execute-cursor-spec "$CURSOR_SKILLS"

# Cline: write for Cursor + execute Cline-bound specs
link_skill cursor-handoff-spec "$CLINE_SKILLS"
link_skill execute-cline-spec "$CLINE_SKILLS"

# Optional: Claude Code compat
if [[ -d "$HOME/.claude/skills" ]]; then
  ln -sfn "$SRC/cline-handoff-spec" "$HOME/.claude/skills/cline-handoff-spec"
  ln -sfn "$SRC/execute-cursor-spec" "$HOME/.claude/skills/execute-cursor-spec"
  echo "linked ~/.claude/skills/{cline-handoff-spec,execute-cursor-spec}"
fi

echo
echo "Installed language: $LANG_VARIANT"
echo "Enable Cline Skills: Settings → Features → Enable Skills"
echo "In a project, create .cline/handoff/{specs,lessons,archive,reviews} as needed (or let the write skill create them)."
