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
      up = "nh os switch /home/vukani/.dotfiles/ -H $(hostname) -u";
      rb = "nh os switch /home/vukani/.dotfiles/ -H $(hostname)";
      bup = "nix flake update nixpkgs-bleeding --flake /home/vukani/.dotfiles/";
      lg = "lazygit";
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
