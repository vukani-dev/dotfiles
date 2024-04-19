{
  pkgs,
  config,
  ...
}: {
  programs.helix = {
    enable = true;
    defaultEditor = false;
    settings = {
      theme = "onedark";
      editor = {
        line-number = "relative";
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
      };
    };
    languages = {
      language = [
        {
          auto-format = true;
          formatter.command = "alejandra";
          name = "nix";
        }
        {
          auto-format = true;
          formatter.command = "shfmt";
          name = "bash";
        }
      ];
    };
  };
}
