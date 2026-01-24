{pkgs, ...}: {
  programs.firefox = {
    enable = true;
    package = pkgs.librewolf;
    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
        "sponsorBlocker@ajay.app" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
          installation_mode = "force_installed";
        };
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          # Bitwarden
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/{446900e4-71c2-419f-a6a7-df9c091e268b}/latest.xpi";
          installation_mode = "force_installed";
        };
        "{d7742d87-e61d-4b78-b8a1-b469842139fa}" = {
          # Vimium-FF
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/{d7742d87-e61d-4b78-b8a1-b469842139fa}/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    };
    profiles.default = {
      isDefault = true;
      settings = {
        # Cookie banners
        "cookiebanners.service.mode.privateBrowsing" = 2;
        "cookiebanners.service.mode" = 2;

        # Privacy (keep LibreWolf defaults)
        "privacy.donottrackheader.enabled" = true;
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;

        # SESSION PERSISTENCE - override LibreWolf's aggressive defaults
        "browser.startup.page" = 3; # Restore previous session
        "browser.sessionstore.resume_from_crash" = true;
        "browser.sessionstore.max_resumed_crashes" = 2;

        # Disable clearing on shutdown
        "privacy.sanitize.sanitizeOnShutdown" = false;
        "privacy.clearOnShutdown.history" = false;
        "privacy.clearOnShutdown.sessions" = false;
        "privacy.clearOnShutdown.cookies" = false;
        "privacy.clearOnShutdown.cache" = false;
        "privacy.clearOnShutdown.formdata" = false;
        "privacy.clearOnShutdown.offlineApps" = false;
        "privacy.clearOnShutdown.siteSettings" = false;
        "privacy.clearOnShutdown_v2.historyFormDataAndDownloads" = false;
        "privacy.clearOnShutdown_v2.cookiesAndStorage" = false;
        "privacy.clearOnShutdown_v2.cache" = false;

        # Keep cookies
        "network.cookie.lifetimePolicy" = 0; # Keep cookies until they expire
      };
    };
  };
}
