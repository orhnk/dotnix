{
  ulib,
  pkgs,
  theme,
  ...
}:
with ulib;
  graphicalConfiguration {
    qt = enabled {
      platformTheme.name = "adwaita";
      style.name = "adwaita";
    };
  }
