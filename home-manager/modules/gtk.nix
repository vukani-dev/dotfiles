{pkgs, ...}: {
  gtk = {
    enable = true;
    theme = {
      name = "pop-gtk-theme";
      package = pkgs.pop-gtk-theme;
    };
  };
}
