#!/bin/sh
# Open journal in a zen ghostty window
# Usage: jl        (dark theme, default)
#        jl light  (light theme)
JOURNAL="/mnt/vault/documents/life-log/$(date +%Y).md"
ZEN="$HOME/scripts/zen-init.lua"

if [ "$1" = "light" ]; then
  BG="e8e4df"
  FG="6b6462"
  export JL_THEME=light
else
  BG="2b2d30"
  FG="a9b1b8"
  export JL_THEME=dark
fi

ghostty \
  --window-padding-x=200 \
  --window-padding-y=80 \
  --title=journal \
  --resize-overlay=never \
  --background="$BG" \
  --foreground="$FG" \
  -e nvim -u "$ZEN" "$JOURNAL" >/dev/null 2>&1 &
disown
