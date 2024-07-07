{
  username,
  homeDirectory,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./modules/firefox
    ./modules/zsh.nix
    ./modules/zellij.nix
    ./modules/helix.nix
    ./modules/starship.nix
    ./modules/gtk.nix
    ./modules/rofi
    ./modules/git.nix
    ./modules/yazi/yazi.nix
    ./modules/carapace.nix
    ./modules/nixvim
    ./modules/zoxide.nix
    inputs.nixvim.homeManagerModules.nixvim
  ];
  home.username = username;
  home.homeDirectory = homeDirectory;

  home.sessionVariables = {
    EDITOR = "nvim";
    FLAKE = "/home/vukani/.dotfiles";
    FLAKEREF = "/home/vukani/.dotfiles";
    SHELL = "zsh";
    TERM = "st";
  };

  home.sessionPath = [
    "/home/vukani/scripts/"
  ];

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;

  home.file."scripts" = {
    source = ./scripts;
    recursive = true;
  };

  home.file.".xinitrc".source = ./scripts/.xinitrc;
  home.file.".mozilla/firefox/vukani/chrome/includes" = {
    source = ./modules/firefox/includes;
    recursive = true;
  };
  home.file."pictures/wallpapers/wall1.jpg".source = ./assets/wall1.jpg;
}
