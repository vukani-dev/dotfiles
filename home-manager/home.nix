{
  username,
  homeDirectory,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./modules/librewolf.nix
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
  ];
  home.username = username;
  home.homeDirectory = homeDirectory;

  home.sessionVariables = {
    EDITOR = "nvim";
    FLAKE = "${homeDirectory}/.dotfiles";
    NH_FLAKE = "${homeDirectory}/.dotfiles";
    FLAKEREF = "${homeDirectory}/.dotfiles";
    SHELL = "zsh";
    TERM = "st";
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

  home.file.".xinitrc".source = ./scripts/.xinitrc;
  home.file."pictures/wallpapers/wall1.jpg".source = ./assets/flowers.jpg;
}
