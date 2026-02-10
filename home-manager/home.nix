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

  home.file.".xinitrc".source = ./scripts/.xinitrc;
  home.file."pictures/wallpapers/wall1.jpg".source = ./assets/flowers.jpg;
}
