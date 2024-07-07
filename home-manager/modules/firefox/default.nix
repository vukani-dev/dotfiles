{
  pkgs,
  inputs,
  ...
}: {
  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
    profiles.vukani = {
      bookmarks = [
        {
          name = "Ukuta";
          url = "https://10.0.0.1:8080";
        }
        {
          name = "Organizr - Media Fleet";
          url = "http://10.0.6.13:8001";
        }
        {
          name = "Soroveya";
          url = "http://10.0.0.2:8006";
        }
        {
          name = "Homelab Dash";
          url = "http://10.0.0.5:3000";
        }
        {
          name = "TrueNas";
          url = "http://10.0.0.4";
        }
        {
          name = "HAOs";
          url = "http://10.0.0.3:8006";
        }
        {
          name = "Home Assistant";
          url = "http://10.0.0.250:8123";
        }
        {
          name = "Syncthing - HUB";
          url = "http://10.0.7.23:8384";
        }
        {
          name = "Demselfly";
          url = "http://10.0.7.23:6363";
        }
        {
          name = "Music";
          url = "https://music.binafsi.cloud";
        }
        {
          name = "Chat GPT";
          url = "https://chat.openai.com/";
        }
        {
          name = "Cronometer";
          url = "https://cronometer.com/";
        }
        {
          name = "Njalla";
          url = "https://njal.la/";
        }
      ];
      extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
        sponsorblock
        ublock-origin
        vimium
        keepassxc-browser
        firefox-color
      ];

      settings = {
        "browser.aboutConfig.showWarning" = false;
        "browser.aboutwelcome.enabled" = false;
        "browser.newtabpage.activity-stream.feeds.system.topstories" = false;
        "browser.newtabpage.activity-stream.feeds.topsites" = false;
        "browser.tabs.firefox-view" = false;
        "browser.tabs.tabmanager.enabled" = false;
        "browser.toolbars.bookmarks.visibility" = "never";
        "browser.startup.page" = 3;
        "extensions.pocket.enabled" = false;
        "font.name.monospace.x-western" = "FiraCode Nerd Font Mono";
        "font.name.sans-serif.x-western" = "FiraCode Nerd Font";
        "font.name.serif.x-western" = "FiraCode Nerd Font";
        "security.webauth.u2f" = true;
        "signon.rememberSignons" = true;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "extensions.formautofill.creditCards.enabled" = false;
        "browser.download.useDownloadDir" = false;
      };
      userChrome = builtins.readFile ./userChrome.css;
    };
  };
}
