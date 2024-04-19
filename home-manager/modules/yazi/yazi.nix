{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    keymap.manager.prepend_keymap = [
      {
        exec = "quit";
        on = ["Q"];
      }
      {
        exec = "quit --no-cwd-file";
        on = ["q"];
      }
      {
        exec = "cd /mnt/mwendo";
        on = ["m"];
      }
      {
        exec = "cd /home/vukani";
        on = ["H"];
      }
      {
        exec = "cd /home/vukani/.dotfiles";
        on = ["C"];
      }
    ];
  };
  xdg.configFile."yazi/yazi.toml".source = ./yazi.toml;
}
