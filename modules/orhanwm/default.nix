{
  ulib,
  pkgs,
  theme,
  ...
}:
with ulib;
with theme;
  merge3
  (
    let
      logfile = "~/dwm.log";
      dmenu-theme = theme.dmenuTheme + " -fn '${theme.font.sans.name}'";
      rofi-dmenu = "rofi -dmenu -i";
      rofi-app-launcher = "rofi -show drun";
      terminal-emulator = "ghostty";
      selection-to-editor = "kitty sh -c 'xclip -o | nvim -'";
      clipboard-dump = "greenclip print";
      web-browser = "vieb";
      clipboard_daemon = "greenclip daemon";
      wallpaper = theme.wallpaper;
      powermenu_script = ''
        #!/bin/sh
        action=$(echo -e "shutdown\nreboot\nsleep\nlogout" | ${rofi-dmenu})

        if [ "$action" == "shutdown" ]; then
          shutdown -h now
        elif [ "$action" == "sleep" ]; then
          systemctl hibernate
        elif [ "$action" == "logout" ]; then
          pkill dwm
        elif [ "$action" == "reboot" ]; then
          reboot
        fi
      '';

      # TODO: auto-infer these from module representation
      appinfo = ''
        #define TERMINAL_EMULATOR       "${terminal-emulator}"
        // #define APP_LAUNCHER         "dmenu_run ${dmenu-theme}"
        // #define CLIPBOARD_MANAGER    "${clipboard-dump} | dmenu -l 5 ${dmenu-theme} | xclip -selection clipboard"
        #define APP_LAUNCHER            "${rofi-app-launcher}"
        #define CLIPBOARD_MANAGER       "${clipboard-dump} | ${rofi-dmenu} | xclip -selection clipboard"
        #define SELECTION_TO_EDITOR     "${selection-to-editor}"
        #define WEB_BROWSER             "${web-browser}"
        #define POWERMENU               "${pkgs.writeScript "powermenu" powermenu_script}"

        static const char *fonts[]          = {
          "${theme.font.sans.name}",
          "${theme.font.mono.name}",
          // "Iosevka:style:medium:size=12",
        }; //:size=10

        static const unsigned int borderpx  = ${toString theme.border-width}; /* border pixel of windows                         */
        static const unsigned int gappih    = ${toString theme.margin};       /* horiz inner gap between windows                 */
        static const unsigned int gappiv    = ${toString theme.margin};       /* vert inner gap between windows                  */
        static const unsigned int gappoh    = ${toString theme.margin};       /* horiz outer gap between windows and screen edge */
        static const unsigned int gappov    = ${toString theme.margin};       /* vert outer gap between windows and screen edge  */
      '';

      system-theme = ''
        static const char black[]         = "#${theme.base00}";
        static const char blue[]          = "#${theme.base07}"; // focused window border
        static const char gray2[]         = "#${theme.base07}"; // unfocused window border
        static const char gray3[]         = "#${theme.base01}";
        static const char gray4[]         = "#${theme.base00}";
        static const char green[]         = "#${theme.base0C}";
        static const char orange[]        = "#${theme.base09}";
        static const char pink[]          = "#${theme.base0E}";
        static const char red[]           = "#${theme.base08}";
        static const char white[]         = "#${theme.base06}";
        static const char yellow[]        = "#${theme.base0B}";
        static const char col_borderbar[] = "#${theme.base00}";
      '';
      xrandr = ''
        xrandr --output VGA-1     \
               --mode 1024x768    \
               --pos 0x0          \
               --rotate normal    \
               --right-of HDMI-1  \
                                  \
               --output HDMI-1    \
               --mode 1920x1080   \
               --rotate normal    \
               --primary
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
          videoDrivers = ["nvidiaLegacy390"]; # nvidia GT630

          # Enables Desktop Manager
          # Don't forget to set displayManager.defaultSession = "xfce";
          desktopManager = {
            xfce = enabled {};
          };

          displayManager = {
            gdm = enabled {};
            defaultSession = "none+orhanwm"; # nodesktopenv + wm ("none+i3")
            session = [
              # https://mynixos.com/nixpkgs/option/services.xserver.displayManager.session
              {
                manage = "window"; # desktop or window
                name = "orhanwm";
                # start = lib.fileContents ./boot.sh;
                start = ''
                  xrdb merge ~/.Xresources &
                  # xbacklight -set 10 & # TODO: not working (idk if essential)
                  xset r rate 200 50 &
                  dash ~/.config/orhanwm/scripts/bar.sh &
                  # eww daemon & # start eww daemon for faster widget startup
                  ${clipboard_daemon} &
                  ${xrandr}

                  # draw our wallpaper only if xinit is not set
                  if [ ! -f $XDG_CONFIG_HOME/sxmo/xinit ]; then
                    DISPLAY=:0 ${pkgs.feh}/bin/feh --bg-fill -z ${wallpaper}
                  fi

                  # NOTE: picom autostarts in the way It's declared in `default.nix`

                  while type orhanwm ; do orhanwm && continue || break; done
                '';
              }
            ];
            # autoLogin = enabled { user = "nixos"; }; # Resulting a halt after boot on my machine
            # Either need to enable kmscon or disable autologin
          };
        };
      }
  )
  (let
    bar-theme = ''
      black=#${base00}
      black_dark=#1d2021
      blue=#${base0D}
      blue_dark=#458588
      aqua=#${base0C}
      aqua_dark=#689d6a
      green=#${base0B}
      green_dark=#98971a
      grey=#${base01}
      # grey_dark=#3c3836
      magenta=#${base0E}
      magenta_dark=#b16286
      orange=#${base09}
      orange_dark=#d65d0e
      red=#${base08}
      red_dark=#cc241d
      white=#${base0F}
      white_dark=#${base0F}
    '';
  in (homeConfiguration {
    # xdg.configFile."orhanwm".source = ./config;
    # xdg.configFile."nix/orhanwm/bar/theme".text = bar-theme; # TODO: symlinkJoin
  }))
  (homePackages
    (with pkgs; [
      (pkgs.callPackage (import ./orhanwm.nix) {})
      # orhanwm: screenshot tool (used with xclip)
      maim
      xclip # also mentioned in nvim config
      # copyq                   # featureful clipboard manager
      haskellPackages.greenclip #            clipboard manager

      # Needed for small scripts like dwmbar, startup etc.
      dash

      # orhanwm: imlib2
      imlib2

      # orhanwm: Image viewer + wallpaper setter: NOTE: Minimalist + Solid
      feh

      # orhanwm: acpi
      acpi

      # orhanwm: build tool: TODO: move these buildInputs to `compile.nix`
      gnumake

      simplescreenrecorder

      # TODO: move to orhanwm
      xorg.xmodmap # needed for orhanwm
      sx #
      pkg-config # TODO: Move to cargo
      fontconfig
    ]))
