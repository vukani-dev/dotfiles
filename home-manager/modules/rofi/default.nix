{pkgs, ...}: {
  xdg.configFile = {
    "rofi/style/".source = ./style;
  };
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    plugins = [pkgs.rofi-calc pkgs.rofi-emoji];

    extraConfig = {
      bw = 1;
      columns = 2;
    };

    theme = "./style/launcher.rasi";
  };
}
