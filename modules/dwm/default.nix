{
  ulib,
  lib,
  pkgs,
  theme,
  config,
  ...
}:
with ulib;
with theme;
  merge3
  (
    let
      logfile = "~/dwm.log";
      wallpaper = theme.wallpaper;
      dmenu-theme = theme.dmenuTheme + " -fn '${theme.font.sans.name}'";
      rofi-dmenu = "rofi -dmenu -i";
      rofi-app-launcher = "rofi -show drun";
      terminal-emulator = "ghostty";
      selection-to-editor = "kitty sh -c 'xclip -o | nvim -'";
      clipboard-dump = "greenclip print";
      web-browser = "vieb";
      clipboard_daemon = "greenclip daemon";
      # automount-script = "${lib.getExe pkgs.udiskie}";

      powermenu_script = builtins.readFile ../rofi/scripts/powermenu.sh;
      screenshotter = builtins.readFile ../rofi/scripts/screenshot.sh;
      pulse-selector = builtins.readFile ../rofi/scripts/pulse-select.sh;

      system-theme = import ./themes/system/siduck {inherit theme;};
      xrandr-monitor-script = builtins.readFile ./scripts/monitor.sh;

      appinfo = ''
        #define TERMINAL_EMULATOR       "${terminal-emulator}"
        #define APP_LAUNCHER            "${rofi-app-launcher}"
        #define CLIPBOARD_MANAGER       "${clipboard-dump} | ${rofi-dmenu} | xclip -selection clipboard"
        #define SELECTION_TO_EDITOR     "${selection-to-editor}"
        #define WEB_BROWSER             "${web-browser}"
        // #define POWERMENU               "${pkgs.writeScript "powermenu" powermenu_script}"
        #define POWERMENU               "${lib.getExe pkgs.rofi} -show p -modi p:'rofi-power-menu --symbols-font \"Symbols Nerd Font Mono\"' -theme-str 'window {width: 8em;} listview {lines: 6;}'"
        #define SCREENSHOTTER           "${pkgs.writeScript "screenshot" screenshotter}"
        #define PULSE_SELECTOR          "${pkgs.writeScript "pulse-selector" pulse-selector}"
        #define EMOJI_PICKER            "${lib.getExe pkgs.rofimoji}"

        static const char *fonts[]          = {
          "${theme.font.sans.name}:size=${builtins.toString theme.font.size.normal}",
          "${theme.font.mono.name}:size=${builtins.toString theme.font.size.normal}",
          "Siji:size=20", // Bitmap gyliphs
          // "Iosevka:style:medium:size=12",
        }; //:size=10

        static const unsigned int borderpx  = ${toString theme.border-width}; /* border pixel of windows                         */
        static const unsigned int gappih    = ${toString theme.margin};       /* horiz inner gap between windows                 */
        static const unsigned int gappiv    = ${toString theme.margin};       /* vert inner gap between windows                  */
        static const unsigned int gappoh    = ${toString theme.margin};       /* horiz outer gap between windows and screen edge */
        static const unsigned int gappov    = ${toString theme.margin};       /* vert outer gap between windows and screen edge  */

        static const int showbar            = 1;        /* 0 means no bar */
      '';
    in
      systemConfiguration {
        hardware.opengl = enabled {
          # On 64-bit systems, if you want OpenGL for 32-bit programs
          # such as in Wine, you should also set the following:
          driSupport32Bit = true;
        };

        services.xserver = enabled {
          # xrandrHeads = [ # NOTE: No effect
          #   # do `xrandr --query` to get the names of your screens
          #   # "HDMI-0" # TODO: uncomment this
          #   "VGA-1"
          # ];
          layout = "tr";
          # videoDrivers = ["nvidiaLegacy390"]; # nvidia GT630 # DEFINED IN NVIDIA's OWN CONFIG

          # # Enables Desktop Manager
          # # Don't forget to set displayManager.defaultSession = "xfce";
          # desktopManager = {
          #   xfce = enabled {};
          # };

          windowManager.dwm = enabled {
            package = pkgs.callPackage (import ./recompile.nix) {
              theme = system-theme;
              inherit appinfo;
            };
          };

          displayManager = {
            gdm = enabled {};
            defaultSession = "none+chadwm"; # nodesktopenv + wm ("none+i3")
            session = [
              {
                manage = "window"; # window manager
                name = "chadwm";
                start = import ./scripts/boot-user.nix.sh {inherit xrandr-monitor-script config pkgs clipboard_daemon wallpaper;};
              }
            ];
            # autoLogin = enabled { user = "nixos"; }; # Resulting a halt after boot on my machine
            # Either need to enable kmscon or disable autologin
          };
        };
      }
  )
  (let
    bar-theme = import ./config/scripts/icon-bar.sh.nix {inherit theme;};
  in (homeConfiguration {
    xdg.configFile."chadwm".source = pkgs.symlinkJoin {
      name = "chadwm";
      paths = [
        (pkgs.writeTextDir "scripts/bar.sh" bar-theme)
        ./config
      ];
    };
  }))
  (homePackages
    (with pkgs; [
      # chadwm: screenshot tool (used with xclip)
      maim
      xdotool # get curr win. SS'ing scripts.
      xclip # also mentioned in nvim config

      # copyq                   # featureful clipboard manager
      haskellPackages.greenclip #            clipboard manager

      # Needed for small scripts like dwmbar, startup etc.
      dash

      # chadwm: imlib2
      imlib2

      # chadwm: Image viewer + wallpaper setter: NOTE: Minimalist + Solid
      feh

      simplescreenrecorder

      # TODO: move to orhanwm
      xorg.xmodmap # needed for orhanwm
      sx #
      pkg-config # TODO: Move to cargo
      fontconfig
    ]))
