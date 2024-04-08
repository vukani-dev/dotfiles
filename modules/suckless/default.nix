{...}: {
  nixpkgs.config.packageOverrides = pkgs: {
    dmenu = pkgs.dmenu.overrideAttrs (oldAttrs: {
      src = /home/vukani/.suckless/dmenu;
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
        src = /home/vukani/.suckless/dwm;
      }))
      .override {
        conf = builtins.readFile ./config.dwm.h;
      };

    # slock =
    #   (pkgs.slock.overrideAttrs {
    #     src = /home/vukani/.suckless/slock
    #   })
    #   .override {
    #     conf = builtins.readFile ./config.slock.h;
    #   };

    st =
      (pkgs.st.overrideAttrs
        (oldAttrs: {
          buildInputs = oldAttrs.buildInputs ++ [pkgs.xorg.libXcursor pkgs.harfbuzz];
          src = /home/vukani/.suckless/st;
        }))
      .override {
        conf = builtins.readFile ./config.st.h;
      };
  };
}
