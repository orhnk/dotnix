{
  ulib,
  pkgs,
  theme,
  config,
  ...
}:
with theme.withHashtag;
with ulib; merge
(
let
  dmenu-theme = theme.dmenuTheme + " -fn '${theme.font.sans.name}'";
in
  (homeConfiguration {
    # TODO: Apply to all shells (add to $PATH)
    programs.nushell.shellAliases = {
      dmenu_run = "dmenu_run ${dmenu-theme}";
      dmenu     = "dmenu     ${dmenu-theme}";
      # embedmenu = "dmenu -w $(xdo id)      ";
    };
  }))

  (homePackages (with pkgs; [
    dmenu
    xdo   # embed dmenu using x window id
  ]))
