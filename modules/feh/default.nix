{
  ulib,
  theme,
  pkgs,
  ...
}: with ulib;

systemConfiguration {
  system.userActivationScripts.wallpaper = {
    text = ''
      ${pkgs.feh}/bin/feh --bg-fill ${theme.wallpaper}
    '';
  };
}
