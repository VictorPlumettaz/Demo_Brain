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
# Junctions, not symlinks: a junction needs no administrator rights on Windows.
# The links are NOT tracked in git (see .gitignore). Git never carries a symlink
# here, so the "42-byte text file" problem cannot come back.
#
#   powershell -ExecutionPolicy Bypass -File 00_system\skills_link.ps1
#
# Counterpart for macOS and Linux: 00_system/skills_link.sh

$system = Split-Path -Parent $MyInvocation.MyCommand.Path   # ...\00_system
$vault  = Split-Path -Parent $system                        # vault root
$target = Join-Path $vault '.claude\skills'

New-Item -ItemType Directory -Path $target -Force | Out-Null

$created = 0
Get-ChildItem (Join-Path $system 'skills') -Directory | ForEach-Object {
    $link = Join-Path $target $_.Name
    if (-not (Test-Path $link)) { $created++ }
    New-Item -ItemType Junction -Path $link -Target $_.FullName -Force | Out-Null
}

# Only speak up when something actually changed. Skills are read at startup, so a
# freshly linked skill is not available until Claude Code is restarted once.
if ($created -gt 0) {
    Write-Host "NOTE: $created vault skill(s) were just linked into .claude\skills\."
    Write-Host "They load on the NEXT start of Claude Code - restart once to use them."
}

exit 0
