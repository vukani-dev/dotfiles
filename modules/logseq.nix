{ pkgs, lib, ... }:

let
  # --- User Configuration ---
  # Update these values when a new Logseq version is released
  logseqVersion = "0.10.9"; # Replace with the desired Logseq version tag
  # Get the sha256 hash by running:
  # nix-prefetch-url https://github.com/logseq/logseq/releases/download/<version>/Logseq-linux-x64-<version>.AppImage
  # Example for 0.10.9:
  # nix-prefetch-url https://github.com/logseq/logseq/releases/download/0.10.9/Logseq-linux-x64-0.10.9.AppImage
  logseqSha256 = "0rqa3wzs6sgsc34alm4pyy5ckqhymqvbykam5fpp2ak5ciisw4sx"; # Replace with the actual SHA256 hash from nix-prefetch-url

  # --- Derivation ---
  logseqUrl = "https://github.com/logseq/logseq/releases/download/${logseqVersion}/Logseq-linux-x64-${logseqVersion}.AppImage";

  logseq-appimage = pkgs.stdenv.mkDerivation {
    pname = "logseq-appimage";
    version = logseqVersion;

    src = pkgs.fetchurl {
      url = logseqUrl;
      sha256 = logseqSha256;
    };

    nativeBuildInputs = [
      pkgs.makeWrapper
      pkgs.appimage-run # Tool to run AppImages
    ];

    # Don't try to unpack the AppImage
    dontUnpack = true;

    installPhase = ''
      runHook preInstall

      # Create necessary directories
      mkdir -p $out/bin $out/share/appimage $out/share/applications # Added applications dir

      # Copy the AppImage to a known location within the store path
      # And make it executable
      install -Dm755 $src $out/share/appimage/logseq-${logseqVersion}.AppImage

      # Create a wrapper script in $out/bin
      # This script will use appimage-run to execute the AppImage
      makeWrapper ${pkgs.appimage-run}/bin/appimage-run $out/bin/logseq \
        --add-flags $out/share/appimage/logseq-${logseqVersion}.AppImage

      # Create .desktop file
      cat > logseq.desktop <<EOF
      [Desktop Entry]
      Type=Application
      Name=Logseq
      Comment=A privacy-first, open-source platform for knowledge management and collaboration
      # Use the wrapper script we created as the Executable
      Exec=$out/bin/logseq
      # Try to use 'logseq' as icon name, DE might find it from a theme
      # Getting icons from AppImages automatically is more complex
      Icon=logseq
      Categories=Office;Utility;TextEditor;
      Terminal=false
      EOF

      # Install the .desktop file
      install -Dm644 logseq.desktop $out/share/applications/logseq.desktop

      runHook postInstall
    '';

    meta = with lib; {
      description = "A privacy-first, open-source platform for knowledge management and collaboration (AppImage)";
      longDescription = ''
        Logseq is a platform for knowledge management and collaboration.
        Focus on privacy, longevity, and user control.
        This package uses the official AppImage release from GitHub.
      '';
      homepage = "https://logseq.com/";
      license = licenses.agpl3Only; # Please verify Logseq's current license
      sourceProvenance = [ sourceTypes.binaryNativeCode ];
      platforms = platforms.linux;
      maintainers = [ maintainers.vukani ]; # Or your GitHub handle/name
    };
  };

in {
  # Add the logseq package to the system environment
  environment.systemPackages = [ logseq-appimage ];
} 