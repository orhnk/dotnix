{
  ulib,
  theme,
  pkgs,
  ...
}: with ulib;

systemConfiguration {
  # PERF: you can optimize this using systemd.user.services.<name>.reloadTriggers
  # https://search.nixos.org/options?channel=23.11&show=systemd.user.services.%3Cname%3E.reloadTriggers&from=0&size=50&sort=relevance&type=packages&query=reloadTriggers
  # -------------
  # For Randomized images using -z (--randomize) option
  system.userActivationScripts.wallpaper = {
  text = ''
  if [ ! -f $XDG_CONFIG_HOME/sxmo/xinit ]; then
    DISPLAY=:0 ${pkgs.feh}/bin/feh --bg-fill --auto-reload ${theme.wallpaper} -z
  fi
  '';
  };

  # systemd.user.services.wallpaper = {
  #   description = "Dynamic Wallpaper Daemon using feh";
  #   documentation = [ "man:feh" ];
  #   serviceConfig = {
  #     ExecStart = "${pkgs.feh}/bin/feh --bg-fill ${theme.wallpaper} -z";
  #     ExecReload = "${pkgs.feh}/bin/feh --bg-fill ${theme.wallpaper} -z";
  #     # Restart = "on-failure";
  #     # RestartSec = 1;
  #     # TimeoutStopSec = 10;
  #   };
  #   reloadIfChanged = true;
  #   restartTriggers = [
  #     theme.wallpaper
  #   ];
  # };
}
