{
  ulib,
  pkgs,
  theme,
  ...
}:
with theme.withHashtag;
with ulib; merge
(
let
  dmenu-theme = ''
    -b -nb '${base00}' -fn '${theme.font.sans.name}' -nf '${base07}' -sb '${base0C}' -sf '${base00}'
  '';
in
  (homeConfiguration {
    # TODO: Apply to all shells (add to $PATH)
    programs.nushell.shellAliases = {
      dmenu_run = "dmenu_run ${dmenu-theme}";
      dmenu     = "dmenu     ${dmenu-theme}";
    };
  }))

  (homePackages (with pkgs; [
    dmenu
    xdo   # embed dmenu using x window id
  ]))
