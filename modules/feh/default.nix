{
  ulib,
  theme,
  pkgs,
  ...
}: with ulib;

systemConfiguration {
  # PERF: you can optimize this using systemd.user.services.<name>.reloadTriggers
  # https://search.nixos.org/options?channel=23.11&show=systemd.user.services.%3Cname%3E.reloadTriggers&from=0&size=50&sort=relevance&type=packages&query=reloadTriggers
  system.userActivationScripts.wallpaper = {
    text = ''
      ${pkgs.feh}/bin/feh --bg-fill ${theme.wallpaper}
    '';
  };
}
