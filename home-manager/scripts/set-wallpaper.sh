#!/bin/sh
# Set wallpaper centered with margin, complementary color background
# Shifts dominant hue ~150 degrees with soft saturation and muted brightness

# Auto-detect active monitor resolution
SCREEN=$(hyprctl monitors -j | jq -r '.[0] | "\(.width)x\(.height)"')
SCREEN=${SCREEN:-2496x1664}
MARGIN=80

IMG="$1"
if [ -z "$IMG" ]; then
    # No argument — pick daily wallpaper from ~/pictures/wallpapers/
    WALLS=$(find ~/pictures/wallpapers -type f -o -type l | sort)
    COUNT=$(echo "$WALLS" | wc -l)
    if [ "$COUNT" -eq 0 ]; then exit 1; fi
    DAY=$(date +%j)
    IDX=$(( (DAY - 1) % COUNT ))
    IMG=$(echo "$WALLS" | sed -n "$((IDX + 1))p")
fi

# Resolve symlinks for imagemagick
IMG=$(readlink -f "$IMG")

# Extract complementary color:
# 1. Get dominant color
# 2. Shift hue +150 degrees (42% of 360)
# 3. Fix saturation at 25% (muted/soft)
# 4. Fix lightness at 35% (not too bright, not too dark)
COLOR=$(magick "$IMG" -resize 50x50 -colors 1 -resize 1x1! \
    -colorspace HSL \
    -channel R -evaluate Add 42% +channel \
    -channel G -evaluate Set 25% +channel \
    -channel B -evaluate Set 35% +channel \
    -colorspace sRGB \
    -format '#%[hex:p{0,0}]' info: 2>/dev/null)
COLOR=${COLOR:-#282c34}

# Calculate inner area (screen minus margins)
SW=$(echo "$SCREEN" | cut -dx -f1)
SH=$(echo "$SCREEN" | cut -dx -f2)
IW=$((SW - MARGIN * 2))
IH=$((SH - MARGIN * 2))

# Compose: resize image to fit within inner area, place centered on colored canvas
TMPWALL="/tmp/wallpaper-composed.png"
magick "$IMG" -resize "${IW}x${IH}" -background "$COLOR" -gravity center -extent "${SCREEN}" "$TMPWALL"

pkill swaybg
sleep 0.2
swaybg -i "$TMPWALL" -m fill &
