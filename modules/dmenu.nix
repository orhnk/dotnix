{
  ulib,
  lib,
  pkgs,
  theme,
  config,
  ...
}:
with theme.withHashtag;
with ulib;
  merge
  (let
    dmenu-theme = theme.dmenuTheme + " -fn '${theme.font.sans.name}'";
  in (homeConfiguration {
    programs.fish.shellAliases = {
      dmenu_run = "dmenu_run ${dmenu-theme}";
      dmenu = "dmenu     ${dmenu-theme}";
      # embedmenu = "dmenu -w $(${lib.getExe pkgs.xdo} id)      "; # Embed dmenu to a window
    };
  }))
  (homePackages (with pkgs; [
    dmenu
    # xdo # embed dmenu using x window id
  ]))
