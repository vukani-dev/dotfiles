{pkgs, ...}: {
  xdg.configFile = {
    "rofi/style/".source = ./style;
  };
  programs.rofi = {
    enable = true;

    extraConfig = {
      bw = 1;
      columns = 2;
    };

    theme = "./style/launcher.rasi";
    # home.file."scripts/rofi/launcher".source = ./bin/launcher;

    package = pkgs.rofi.override {
      plugins = [pkgs.rofi-calc pkgs.rofi-emoji];
    };
  };
}
