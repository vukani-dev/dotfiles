{pkgs, ...}: {
  gtk = {
    enable = true;
    theme = {
      name = "Pop-dark";
      package = pkgs.pop-gtk-theme;
    };
  };
}
