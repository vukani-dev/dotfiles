{
  pkgs,
  inputs,
  ...
}: {
  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
    profiles.vukani = {
      extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
        sponsorblock
        ublock-origin
        vimium
        firefox-color
        metamask
        bitwarden
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

        # Search engine settings for Startpage
        "browser.search.defaultenginename" = "Startpage";
        "browser.search.selectedEngine" = "Startpage";
        "browser.urlbar.placeholderName" = "Startpage";
        "browser.urlbar.placeholderName.private" = "Startpage";
      };
    };
  };
}
