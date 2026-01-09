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
      bup = "nix flake update nixpkgs-bleeding --flake /home/vukani/.dotfiles/";
      lg = "lazygit";
      win-gaming = "xfreerdp /v:10.5.18.177 /u:vukani /size:1920x1080";
    };
    history = {
      size = 100000;
      ignoreSpace = true;
    };
    initContent = ''
      # Vi mode
      bindkey -v
      export KEYTIMEOUT=1
    '';
  };
}
