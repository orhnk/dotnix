{
  ulib,
  theme,
  pkgs,
  ...
}: with ulib;

systemConfiguration {
  system.activationScripts.wallpaper = {
    text = ''
      ${pkgs.feh}/bin/feh --bg-fill ${theme.wallpaper}
    '';
  };
}
