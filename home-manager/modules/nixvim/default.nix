{pkgs, ...}: {
  imports = [
    ./cmp.nix
    ./luasnip.nix
  ];

  programs.nixvim = {
    enable = true;
    globals.mapleader = " ";
    extraPackages = [
      # pkgs.cargo
      # pkgs.rustc
      pkgs.alejandra
      pkgs.prettierd
      pkgs.ripgrep
      pkgs.xclip
    ];
    colorschemes.onedark.enable = true;
    plugins = {
      ledger.enable = true;
      conform-nvim = {
        enable = true;
        formatOnSave = {
          lspFallback = true;
          timeoutMs = 500;
        };
        notifyOnError = true;
        formattersByFt = {
          liquidsoap = ["liquidsoap-prettier"];
          html = [["prettierd" "prettier"]];
          css = [["prettierd" "prettier"]];
          javascript = [["prettierd" "prettier"]];
          javascriptreact = [["prettierd" "prettier"]];
          typescript = [["prettierd" "prettier"]];
          typescriptreact = [["prettierd" "prettier"]];
          python = ["black"];
          lua = ["stylua"];
          nix = ["alejandra"];
          markdown = [["prettierd" "prettier"]];
          yaml = ["yamllint" "yamlfmt"];
          c = ["prettierd" "prettier"];
        };
      };
      lsp-format.enable = true;
      lsp = {
        enable = true;
        servers = {
          nil_ls.enable = true;
          bashls.enable = true;
          dockerls.enable = true;
          html.enable = true;
          jsonls.enable = true;
          marksman.enable = true;
          nushell.enable = true;
          pylsp.enable = true;
          tsserver.enable = true;
          typos-lsp.enable = true;
          yamlls.enable = true;
          terraformls.enable = true;
          svelte.enable = true;
          # rust-analyzer.enable = true;
          eslint.enable = true;
          csharp-ls.enable = true;
          cssls.enable = true;
          #          clangd.enable = true;
        };
      };
      telescope = {
        enable = true;
        keymaps = {
          "<leader>f" = {
            action = "find_files";
            options.desc = "Find files";
          };
          "<leader>b" = {
            action = "buffers";
            options.desc = "List open buffers";
          };
          "<leader>g" = {
            action = "live_grep";
            options.desc = "Grep in project";
          };
          "gr" = {
            action = "lsp_references";
            options.desc = "Goto references";
          };
        };
        extraOptions = {
          pickers = {
            # find_files = {
            #   hidden = true;
            #   file_ignore_patterns = ["%.git/.*"];
            # };
          };
        };
      };
      treesitter.enable = true;
      autoclose.enable = true;
      harpoon = {
        enable = true;
        enableTelescope = true;
        keymapsSilent = true;
        keymaps = {
          addFile = "<leader>ha";
          toggleQuickMenu = "<C-i>";
          navFile = {
            "1" = "<leader>hj";
            "2" = "<leader>hk";
            "3" = "<leader>hl";
            "4" = "<leader>hm";
          };
        };
      };
      markdown-preview = {
        enable = true;
        settings = {
          browser = "firefox";
        };
      };
      lualine.enable = true;
      which-key.enable = true;
      illuminate.enable = true;
      comment-nvim = {
        enable = true;
      };
    };
    options = {
      number = true; # Show line numbers
      relativenumber = true; # Show relative line numbers
      shiftwidth = 2; # Tab width should be 2
      history = 10000;
    };
    keymaps = [
      {
        key = "<leader>y";
        mode = ["n" "v"];
        action = "\"+y";
        options = {
          silent = true;
          noremap = true;
          desc = "[y]ank to system clipboard";
        };
      }
      {
        key = "<leader>Y";
        mode = "n";
        action = "\"+Y";
        options = {
          silent = true;
          noremap = true;
          desc = "[Y]ank line to system clipboard";
        };
      }
    ];
  };
}
