#!/bin/sh
# Link the real skill folders into .claude/skills/ so Claude Code can load them.
#
# Why this exists:
#   Claude Code only loads skills from .claude/skills/ — that path is hardcoded.
#   Obsidian refuses to show any folder starting with a dot.
#   So the real files live at 00_system/skills/ (visible, searchable, in the graph)
#   and this script puts a link for each one where Claude Code looks.
#
# You do not normally run this by hand: .claude/settings.json calls it on every
# session start. It is idempotent — running it again changes nothing and says nothing.
#
# The links are NOT tracked in git (see .gitignore). Git never carries a symlink
# here, so the Windows "42-byte text file" problem cannot come back.
#
#   sh 00_system/skills_link.sh
#
# Counterpart for Windows: 00_system/skills_link.ps1

root=$(cd "$(dirname "$0")/.." && pwd)
target="$root/.claude/skills"
created=0

mkdir -p "$target" || exit 0

for dir in "$root"/00_system/skills/*/; do
    [ -d "$dir" ] || continue
    name=$(basename "$dir")
    [ -e "$target/$name" ] || created=$((created + 1))
    ln -sfn "$dir" "$target/$name" 2>/dev/null
done

# Only speak up when something actually changed. Skills are read at startup, so a
# freshly linked skill is not available until Claude Code is restarted once.
if [ "$created" -gt 0 ]; then
    echo "NOTE: $created vault skill(s) were just linked into .claude/skills/."
    echo "They load on the NEXT start of Claude Code — restart once to use them."
fi

exit 0
