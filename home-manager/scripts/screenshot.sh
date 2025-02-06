#!/bin/sh

# Take a screenshot of a selected area and save it to the Pictures folder.
# Requires: maim, xclip

# Set the output directory and filename
output_dir="$HOME/pictures/screenshots"
mkdir -p "$output_dir" # Create the directory if it doesn't exist
filename=$(date '+%Y-%m-%d_%H-%M-%S').png
filepath="$output_dir/$filename"

# Take the screenshot using maim with selection
maim -s "$filepath"

# Check if the screenshot was successful
if [ -f "$filepath" ]; then
  # Copy the image path to the clipboard (optional, but very useful)
  echo "Screenshot saved to $filepath"
  xclip -selection clipboard -t image/png -i "$filepath"

  #notify-send "Screenshot Saved" "Screenshot saved to $filepath" -i "$filepath"
else
  echo "Screenshot failed!"
  notify-send "Screenshot Failed" "Failed to take screenshot."
fi

exit 0