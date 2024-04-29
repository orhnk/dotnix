{
  pkgs,
  lib,
  ulib,
  theme,
  ...
}:
with ulib;
 (homeConfiguration {
  services.picom = enabled {
    package = pkgs.picom.overrideAttrs (oldAttr: {
      src = pkgs.fetchFromGitHub {
        repo = "picom";
        owner = "pijulius";
        rev = "982bb43e5d4116f1a37a0bde01c9bda0b88705b9";
        sha256 = "YiuLScDV9UfgI1MiYRtjgRkJ0VuA1TExATA2nJSJMhM=";
      };
      # merge buildInputs with xcb-util
    });
    activeOpacity = 1;
    settings = {
      "animations" = true;
      "animation-stiffness" = 300;
      "animation-dampening" = 50;
      "animation-clamping" = true;
      "animation-for-open-window" = "zoom"; # Open
      "animation-for-unmap-window" = "zoom"; # Minimize
      "animation-for-menu-window" = "zoom";
      "animation-for-transient-window" = "zoom"; # popups

      "animation-for-workspace-switch-in" = "zoom"; # workspace in move
      "animation-for-workspace-switch-out" = "zoom"; # workspace out move

      "vsync" = true;
      "backend" = "glx";
      # "animation-mass" = 0.7;
      "corner-radius" = theme.corner-radius; # rounded corners
      "inactive-dim" = 5.0e-2;
    };

    # extraArgs = ["--xrender-sync-fence"];

    backend = "glx"; # "glx" or "xrender"
    inactiveOpacity = 1;
    menuOpacity = 0.9;

    fade = true;
    fadeDelta = 7;

    shadow = true;
    shadowOpacity = 0.8;

    vSync = true;
  };
})
