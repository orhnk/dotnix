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

  powermenu_script = ''
    action=$(echo -e "shutdown\nsleep\nlogout\nreboot" | dmenu -l 4 ${dmenu-theme})

    if [ "$action" == "shutdown" ]; then
      sudo shutdown -h now
    elif [ "$action" == "sleep" ]; then
      systemctl hibernate
    elif [ "$action" == "logout" ]; then
      pkill dwm
    elif [ "$action" == "reboot" ]; then
      sudo reboot
    fi
  '';
in
  (homeConfiguration {
    # TODO: Apply to all shells (add to $PATH)
    programs.fish.shellAliases = {
      dmenu_run = "dmenu_run ${dmenu-theme}";
      dmenu     = "dmenu     ${dmenu-theme}";
      embedmenu = "dmenu -w $(xdo id)      ";
    };
  }))

  (homePackages (with pkgs; [
    dmenu
    xdo   # embed dmenu using x window id
  ]))
