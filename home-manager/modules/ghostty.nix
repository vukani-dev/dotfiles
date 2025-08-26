{...}: {
  home.file.".config/ghostty/config".text = ''
    # Font
    font-family = FiraCode Nerd Font Mono
    font-size = 14

    # No title bar / borders from Ghostty itself
    window-decoration = none
    # macOS only, safe to leave commented on Linux:
    # macos-titlebar-style = hidden

    # Disable close confirmation
    confirm-close-surface = false

    # Colors
    background = #282c34
    foreground = #ffffff
    cursor-color = #ffffff
    selection-background = #555555
    selection-foreground = #ffffff

    # 8 normal colors
    palette = 0=#282c34
    palette = 1=#e06c75
    palette = 2=#98c379
    palette = 3=#e5c07b
    palette = 4=#61afef
    palette = 5=#c678dd
    palette = 6=#56b6c2
    palette = 7=#abb2bf

    # 8 bright colors
    palette = 8=#929FBA
    palette = 9=#e06c75
    palette = 10=#98c379
    palette = 11=#e5c07b
    palette = 12=#61afef
    palette = 13=#c678dd
    palette = 14=#56b6c2
    palette = 15=#abb2bf
  '';
}
