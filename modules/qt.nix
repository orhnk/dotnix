{
  ulib,
  pkgs,
  theme,
  ...
}:
with ulib;
  graphicalConfiguration {
    # FIXME
    qt = enabled {
      platformTheme = "gtk";
      style = {
        name = "gtk2";
        package = pkgs.libsForQt5.breeze-qt5;
      };
    };
  }
