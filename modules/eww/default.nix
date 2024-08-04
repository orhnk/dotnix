{ulib, ...}:
with ulib;
  homeConfiguration {
    # xdg.configFile."eww".source = ./config;
    programs.eww = enabled {
      configDir = ./config;
    };
  }
