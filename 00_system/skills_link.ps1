# Link the real skill folders into .claude/skills/ so Claude Code can load them.
#
# Why this exists:
#   Claude Code only loads skills from .claude/skills/ — that path is hardcoded.
#   Obsidian refuses to show any folder starting with a dot.
#   So the real files live at 00_system/skills/ (visible, searchable, in the graph)
#   and this script puts a link for each one where Claude Code looks.
#
# Junctions, not symlinks: a junction needs no administrator rights on Windows.
# The links themselves are NOT tracked in git — see .gitignore. Run this once per
# fresh clone, and again after adding a new skill.
#
#   powershell -ExecutionPolicy Bypass -File 00_system\skills_link.ps1

$system = Split-Path -Parent $MyInvocation.MyCommand.Path   # ...\00_system
$vault  = Split-Path -Parent $system                        # vault root
$target = Join-Path $vault '.claude\skills'

New-Item -ItemType Directory -Path $target -Force | Out-Null

$count = 0
Get-ChildItem (Join-Path $system 'skills') -Directory | ForEach-Object {
    New-Item -ItemType Junction -Path (Join-Path $target $_.Name) -Target $_.FullName -Force | Out-Null
    Write-Host "  junction  $($_.Name)"
    $count++
}

Write-Host "Done: $count skills linked into $target"
