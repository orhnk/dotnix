{
  pkgs,
  lib,
  ulib,
  theme,
  ...
}:
with ulib; (let
  config = {
    cococry = import ./config/cococry.nix;

    fancy-animations = {
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

      "animation-mass" = 0.7;
      "inactive-dim" = 5.0e-2;
    };

    fancy-shadows = {
      "shadow" = true;
      # inactiveOpacity = 1;
      # menuOpacity = 0.9;

      "fading" = false;
      # "fadeDelta" = 7;
      # "shadowOpacity" = 0.8;
    };

    minimal-shadows = {
      "shadow" = true;
      "shadow-radius" = 0;
      "shadow-opacity" = 0.25;
      "shadow-offset-x" = 7;
      "shadow-offset-y" = 6;
      "fading" = false;
    };

    bare = {
      "corner-radius" = theme.corner-radius;
      "vsync" = true;
      "backend" = "glx"; # "glx" or "xrender"
      # "glx-no-stencil" = true;
      # "glx-no-rebind-pixmap" = true;
    };
  };
in
  homeConfiguration {
    services.picom = enabled {
      # package = pkgs.picom.overrideAttrs (oldAttr: {
      #   src = pkgs.fetchFromGitHub {
      #     repo = "picom";
      #     owner = "pijulius";
      #     rev = "b8fe9323e7606709d692976a7fe7d2455b328bc6";
      #     sha256 = "YiuLScDV9UfgI1MiYRtjgRkJ0VuA1TExATA2nJSJMhM=";
      #   };
      #   buildInputs = oldAttr.buildInputs ++ (with pkgs; [pcre]);
      #   # nativeBuildInputs = oldAttr.nativeBuildInputs ++ (with pkgs; [pcre asciidoctor]);
      # });
      # settings = config.bare // config.fancy-animations;
      # settings = config.cococry // config.bare;
      settings = config.bare;

      # extraArgs = ["--xrender-sync-fence"];
    };
  })
