{pkgs, ...}: {
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

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
      oc = "ssh 10.1.0.100";
      jl = "journal.sh";
      ask = "ask.sh";
      beetle = "OLLAMA_MODEL=dolphin3 ask.sh";
      chat = "oterm";
      nd = "nix develop --command zsh";
    };
    history = {
      size = 1000000;
      ignoreSpace = true;
    };
    initContent = ''
      # Vi mode
      bindkey -v
      export KEYTIMEOUT=1

      # Use zsh inside nix-shell and nix develop
      ${pkgs.any-nix-shell}/bin/any-nix-shell zsh --info-right | source /dev/stdin
    '';
  };
}
