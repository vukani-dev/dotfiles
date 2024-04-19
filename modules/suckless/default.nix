{...}: {
  nixpkgs.config.packageOverrides = pkgs: {
    dmenu = pkgs.dmenu.overrideAttrs (oldAttrs: {
      src = /home/vukani/.suckless/dmenu;
      # src = pkgs.fetchFromGitHub {
      #   owner = "vukani";
      #   repo = "dwm";
      #   rev = "4ec69288e9fe723afdf27d18681542f67fbb71e0";
      # };
      # For `dmenu`, `conf` can't be used because the derivation doesn't support it
      postPatch =
        oldAttrs.postPatch
        + ''
          cp ${pkgs.writeText "config.dmenu.h" (builtins.readFile ./config.dmenu.h)} config.h
        '';
    });

    dwm =
      (pkgs.dwm.overrideAttrs (oldAttrs: {
        buildInputs = oldAttrs.buildInputs ++ [pkgs.xorg.libXcursor pkgs.imlib2 pkgs.xorg.libXinerama pkgs.xorg.libXft pkgs.xorg.libXext pkgs.fontconfig pkgs.pkg-config];
        # src = /home/vukani/.suckless/dwm;
        src = pkgs.fetchFromGitHub {
          owner = "vukani-dev";
          repo = "dwm";
          rev = "4ec69288e9fe723afdf27d18681542f67fbb71e0";
          sha256 = "sha256-+Zfl2Zf+bq3JRGIcxj+YdVIctewt18/3+QypUhYbfx4=";
        };
      }))
      .override {
        conf = builtins.readFile ./config.dwm.h;
      };

    st =
      (pkgs.st.overrideAttrs
        (oldAttrs: {
          buildInputs = oldAttrs.buildInputs ++ [pkgs.xorg.libXcursor pkgs.harfbuzz];
          # src = /home/vukani/.suckless/st;
          src = pkgs.fetchFromGitHub {
            owner = "vukani-dev";
            repo = "st";
            rev = "6ce6f19126eea764b31615db48ebae85b817ea6a";
            sha256 = "sha256-L3WHaaZ0nHCLZkMCN1HWYqzFYEdgMuKOBugXB91akq8=";
          };
        }))
      .override {
        conf = builtins.readFile ./config.st.h;
      };
  };
}
