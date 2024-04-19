{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      la = "ls -a";
      v = "nvim .";
      up = "nh os switch -u";
      rb = "nh os switch";
      win = "xfreerdp /u:vukani /v:10.0.1.78 /sound /dynamic-resolution";
      lg = "lazygit";
    };
    history.size = 100000;
    history.path = "/home/vukani/.config/zsh/history";
    oh-my-zsh = {
      enable = true;
      plugins = ["git" "vi-mode"];
      theme = "robbyrussell";
    };
  };
}
