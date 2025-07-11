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
      up = "nh os switch /home/vukani/.dotfiles/ -u";
      rb = "nh os switch /home/vukani/.dotfiles/";
      lg = "lazygit";
      win-gaming = "xfreerdp /v:10.1.0.77 /u:vukani /size:1920x1080";
    };
    history.size = 100000;
    history.path = "/home/vukani/.config/zsh/history";
    initContent = "setopt HIST_IGNORE_SPACE";
    oh-my-zsh = {
      enable = true;
      plugins = ["git" "vi-mode"];
      theme = "robbyrussell";
    };
  };
}
