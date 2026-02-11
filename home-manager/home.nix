{
  username,
  homeDirectory,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./modules/firefox.nix
    ./modules/zen-browser.nix
    ./modules/zsh.nix
    ./modules/zellij.nix
    ./modules/starship.nix
    ./modules/gtk.nix
    ./modules/rofi
    ./modules/git.nix
    ./modules/yazi/yazi.nix
    ./modules/carapace.nix
    ./modules/zoxide.nix
    ./modules/ghostty.nix
    ./modules/hyprland.nix
  ];
  home.username = username;
  home.homeDirectory = homeDirectory;

  home.sessionVariables = {
    EDITOR = "nvim";
    NH_FLAKE = "${homeDirectory}/.dotfiles";
    SHELL = "zsh";
    TERM = "ghostty";
  };

  home.sessionPath = [
    "${homeDirectory}/scripts/"
  ];

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;

  home.file."scripts" = {
    source = ./scripts;
    recursive = true;
  };

  xdg.configFile."calcurse/conf".source = ./modules/calcurse.conf;

  # Daily wallpaper rotation
  systemd.user.services.daily-wallpaper = {
    Unit.Description = "Set daily wallpaper";
    Service = {
      Type = "oneshot";
      ExecStart = "${homeDirectory}/scripts/set-wallpaper.sh";
      Environment = "PATH=/run/current-system/sw/bin:${homeDirectory}/scripts";
    };
  };
  systemd.user.timers.daily-wallpaper = {
    Unit.Description = "Daily wallpaper rotation";
    Timer = {
      OnCalendar = "daily";
      Persistent = true;
    };
    Install.WantedBy = ["timers.target"];
  };

  home.file.".xinitrc".source = ./scripts/.xinitrc;
  home.file."pictures/wallpapers" = {
    source = ./assets;
    recursive = true;
  };
}
