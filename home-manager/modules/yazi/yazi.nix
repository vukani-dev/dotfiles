{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
  };
  xdg.configFile."yazi/yazi.toml".source = ./yazi.toml;
  xdg.configFile."yazi/keymap.toml".source = ./keymap.toml;
}
