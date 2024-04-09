{pkgs, ...}: {
  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Macchiato-Compact-Pink-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = ["peach"];
        size = "compact";
        tweaks = ["rimless" "black"];
        variant = "macchiato";
      };
    };
  };
}
