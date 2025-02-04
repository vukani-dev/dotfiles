{
  programs.qutebrowser = {
    enable = true;
    settings = {
      # Enable adblocking
      content.blocking = {
        enabled = true;
        hosts.lists = [
          "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
        ];
        method = "hosts";
      };

      # Set Startpage as default search engine
      url = {
        default_page = "https://startpage.com";
        start_pages = ["https://startpage.com"];
        searchengines = {
          DEFAULT = "https://startpage.com/do/search?q={}";
        };
      };
    };
  };
}
