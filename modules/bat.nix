{
  ulib,
  pkgs,
  theme,
  ...
}:
with ulib;
  merge
  (homeConfiguration {
    programs.bat = enabled {
      config.theme = "base16";
      themes.base16.src = pkgs.writeText "base16.tmTheme" theme.tmTheme;
    };
    programs.fish.shellAliases = {
      cat = "bat";
      less = "bat --plain";
    };
  })
  (systemConfiguration {
    environment.variables = {
      MANPAGER = "bat --plain --language man";
      PAGER = "bat --plain";
    };
  })
