{ulib, theme, ...}: with ulib; with theme.withHashtag;

graphicalConfiguration {
  programs.qutebrowser = enabled {
    extraConfig = ''
      c.statusbar.padding = {'top': 5, 'bottom': 5, 'left': 3, 'right': 3}
      c.tabs.padding = {'top': 10, 'bottom': 8, 'left': 5, 'right': 3}
      config.bind(',ap' , 'config-cycle content.user_stylesheets ~/.config/nixpkgs/themes/solarized-everything-css/css/apprentice/apprentice-all-sites.css ""')
      config.bind(',dr' , 'config-cycle content.user_stylesheets ~/.config/nixpkgs/themes/solarized-everything-css/css/darculized/darculized-all-sites.css ""')
      config.bind(',gr' , 'config-cycle content.user_stylesheets ~/.config/nixpkgs/themes/solarized-everything-css/css/gruvbox/gruvbox-all-sites.css ""')
      config.bind(',sd' , 'config-cycle content.user_stylesheets ~/.config/nixpkgs/themes/solarized-everything-css/css/solarized-dark/solarized-dark-all-sites.css ""')
      config.bind(',ysd', 'config-cycle content.user_stylesheets ~/.config/nixpkgs/core/sway/recipes/qutebrowser/horizon.css ""')
      config.bind(',sl' , 'config-cycle content.user_stylesheets ~/.config/nixpkgs/themes/solarized-everything-css/css/solarized-light/solarized-light-all-sites.css ""')
      config.set("colors.webpage.darkmode.enabled", True)
    '';

    searchEngines = {
      "DEFAULT" = "https://duckduckgo.com/?q={}";
      "w"       = "https://en.wikipedia.org/w/index.php?search={}";
      "aw"      = "https://wiki.archlinux.org/?search={}";
      "no"      = "https://search.nixos.org/options?channel=unstable&from=0&size=50&sort=relevance&query={}";
      "np"      = "https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&query={}";
      "d"       = "https://en.wiktionary.org/wiki/{}";
      "v"       = "https://eo.wiktionary.org/wiki/{}";
      "s"       = "http://stackoverflow.com/search?q={}";
      "gh"      = "https://github.com/search?q={}&type=Repositories";
      "h"       = "https://hackage.haskell.org/packages/search?terms={}";
      "sg"      = "https://sourcegraph.com/search?q={}";
      "libgen"  = "https://libgen.is/search.php?req={}";
      "viki"    = "https://eo.wikipedia.org/w/index.php?search={}";
      "ia"      = "https://archive.org/details/texts?and%5B%5D={}&sin=";
      "crate"   = "https://crates.io/search?q={}";
    };

    settings = {
      colors = {
        tabs = {
          even.bg = "${base00}";
          odd.bg = "${base00}";
          selected.even.bg = "${base01}";
          selected.odd.bg = "${base01}";
        };
      };

      fonts = {
        completion.category = "${toString theme.font.size.normal}pt ${theme.font.sans.name}";
        default_family = "${theme.font.sans.name}";
        prompts = "${toString theme.font.size.normal}pt ${theme.font.sans.name}";
      };

      # hints.chars = "arstdhneio";
      # url.default_page = "${scripts}/homepage/homepage.html";
    };
  };
}
