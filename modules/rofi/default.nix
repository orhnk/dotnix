{
  ulib,
  pkgs,
  theme,
  ...
}:
with theme.withHashtag;
with ulib;
  merge3 (let
    rofi-config = ./themes/center-minimal.rasi.nix;
    rofi-theme = ''
      * {
          background:     ${base00};
          background-alt: ${base01};
          foreground:     ${base06};
          selected:       ${base01};
          selected-fg:    ${base0C};
          active:         ${base0D};
          urgent:         ${base08};
          font:           "${theme.font.mono.name} ${builtins.toString theme.font.size.normal}";
      }
    '';
  in (homeConfiguration {
    programs.rofi = enabled {
      plugins = with pkgs; [
        # rofi-calc
        # rofi-top
      ];

      theme = builtins.toPath (pkgs.writeText "theme.rasi" (import rofi-config {inherit rofi-theme;}));
    };
  }))
  (systemFonts (with pkgs; [
    # icomoon-feather
  ]))
  (graphicalPackages (with pkgs; [
    rofimoji
    rofi-pulse-select
    rofi-power-menu

    # DEPS
    ## CUSTOM SCRIPTS
    ### SCREENSHOT
    xorg.xwininfo
    xdotool
  ]))
