{
  ulib,
  pkgs,
  theme,
  ...
}:
with ulib;
  graphicalConfiguration {
    qt = enabled {
      platformTheme = "gnome";
      style.name = "Adwaita-${theme.variant}";
      style.package = pkgs.adwaita-qt;
    };
  }
