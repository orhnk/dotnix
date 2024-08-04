{
  ulib,
  pkgs,
  theme,
  ...
}:
with ulib;
with theme.withHashtag;
  merge
  (homePackages (with pkgs; [
    (siduck76-st.overrideAttrs (oldAttrs: {
      src = pkgs.callPackage (import ./st.nix) {};
    }))
  ]))
  (let
    dotXresources = ''
      Xft.antialias:	1
      Xft.hinting:	1
      Xft.autohint:	0
      Xft.hintstyle:	hintslight
      Xft.rgba:	rgb
      Xft.lcdfilter:	lcddefault
      Xcursor.theme: Vanilla-DMZ

      ! window padding
      st.borderpx:  0

      !-- values between 0.1  - 1.0 --!
      st.alpha: 1.0
      st.font:           ${theme.font.mono.name}

      #define base00 ${base00}
      #define base01 ${base01}
      #define base02 ${base02}
      #define base03 ${base03}
      #define base04 ${base04}
      #define base05 ${base05}
      #define base06 ${base06}
      #define base07 ${base07}
      #define base08 ${base08}
      #define base09 ${base09}
      #define base0A ${base0A}
      #define base0B ${base0B}
      #define base0C ${base0C}
      #define base0D ${base0D}
      #define base0E ${base0E}
      #define base0F ${base0F}

      *.foreground:   base05
      #ifdef background_opacity
      *.background:   [background_opacity]base00
      #else
      *.background:   base00
      #endif
      *.cursorColor:  base05

      *.color0:       base00
      *.color1:       base08
      *.color2:       base0B
      *.color3:       base0A
      *.color4:       base0D
      *.color5:       base0E
      *.color6:       base0C
      *.color7:       base05

      *.color8:       base03
      *.color9:       base08
      *.color10:      base0B
      *.color11:      base0A
      *.color12:      base0D
      *.color13:      base0E
      *.color14:      base0C
      *.color15:      base07

      ! Note: colors beyond 15 might not be loaded (e.g., xterm, urxvt),
      ! use 'shell' template to set these if necessary
      *.color16:      base09
      *.color17:      base0F
      *.color18:      base01
      *.color19:      base02
      *.color20:      base04
      *.color21:      base06
    '';
  in
    homeConfiguration {
      home.file.".Xresources".text = dotXresources; # NOTE
    })
