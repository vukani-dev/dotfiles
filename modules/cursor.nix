{
  pkgs,
  lib,
  ...
}: let
  # --- User Configuration ---
  # Update these values if the URL/version changes
  # Note: The URL provided seems to contain a hash, which might change even for the same version.
  # You might need to find a more stable download link pattern if possible, or update the URL and hash frequently.
  cursorVersion = "0.48.6";
  cursorUrl = "https://downloads.cursor.com/production/0781e811de386a0c5bcb07ceb259df8ff8246a52/linux/x64/Cursor-0.49.6-x86_64.AppImage";

  # Get the sha256 hash by running:
  # nix-prefetch-url <cursorUrl>
  # Example:
  # nix-prefetch-url https://downloads.cursor.com/production/b6fb41b5f36bda05cab7109606e7404a65d1ff32/linux/x64/Cursor-0.47.9-x86_64.AppImage
  cursorSha256 = "132bhv64xhl391aa0c5cdiy7h5ljw529dk0wr53689hm1mkkyzjq"; # Replace with the actual SHA256 hash
in {
  # Define the package derivation
  environment.systemPackages = let
    cursor-appimage = pkgs.stdenv.mkDerivation {
      pname = "cursor-appimage";
      version = cursorVersion;

      src = pkgs.fetchurl {
        url = cursorUrl;
        sha256 = cursorSha256;
        # The filename from the URL is complex, explicitly name the downloaded file
        name = "Cursor-${cursorVersion}-x86_64.AppImage";
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
        install -Dm755 $src $out/share/appimage/cursor-${cursorVersion}.AppImage

        # Create a wrapper script in $out/bin
        # This script will use appimage-run to execute the AppImage
        makeWrapper ${pkgs.appimage-run}/bin/appimage-run $out/bin/cursor \
          --add-flags $out/share/appimage/cursor-${cursorVersion}.AppImage

        # Create .desktop file
        cat > cursor.desktop <<EOF
        [Desktop Entry]
        Type=Application
        Name=Cursor
        Comment=An AI-first code editor
        # Use the wrapper script we created as the Executable
        Exec=$out/bin/cursor
        # Try to use 'cursor' as icon name, or 'code-oss' if cursor isn't found
        Icon=cursor
        Categories=Development;IDE;TextEditor;
        Terminal=false
        EOF

        # Install the .desktop file
        install -Dm644 cursor.desktop $out/share/applications/cursor.desktop

        runHook postInstall
      '';

      meta = with lib; {
        description = "An AI-first code editor (AppImage)";
        longDescription = ''
          Cursor is an AI-first code editor based on VSCode.
          This package uses the official AppImage release downloaded directly.
        '';
        homepage = "https://cursor.sh/";
        # License needs verification - likely proprietary or custom
        license = licenses.unfree;
        sourceProvenance = [sourceTypes.binaryNativeCode];
        platforms = platforms.linux;
        maintainers = [maintainers.vukani]; # Or your GitHub handle/name
      };
    };
  in [cursor-appimage]; # Add the package to systemPackages
}

