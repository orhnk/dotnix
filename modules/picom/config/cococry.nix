{
  "animations" = true;
  "animation-stiffness" = 250;
  "animation-window-mass" = 1;
  "animation-dampening" = 28;
  "animation-clamping" = false;
  "animation-for-open-window" = "zoom"; # open window
  "animation-for-desktop-switch-in" = "slide-up"; # Animation when switching into a new desktop
  "animation-for-desktop-switch-out" = "slide-down"; # Animation when switching out of the current desktop

  "shadow" = false;
  "shadow-radius" = 0;
  "shadow-opacity" = 0.50;
  "shadow-offset-x" = -25;
  "shadow-offset-y" = -25;
  "dock-shadow" = true;
  "shadow-exclude" = [
    "window_type = 'menu'"
    "class_g = 'Plank'"
    "class_g = 'Cairo-dock'"
    "class_g = 'activate-linux'"
    "class_g = 'eww-background-closer'"
    "class_g = 'GLava'"
    "class_g = 'eww-visualizer'"
    "class_g = 'eww-lyrics'"
    "class_g = 'eww-volume-indicator'"
    "class_g = 'eww-brightness-indicator'"
  ];

  "fading" = true;
  "fade-in-step" = 0.01;
  "fade-out-step" = 0.01;
  "fade-delta" = 3.5;
  "focus-exclude" = ["class_g = 'Cairo-clock'"];

  "opacity-rule" = [
    "92:class_g = 'Alacritty'"
    "100:class_g = 'discord' && focused"
    "100:class_g = 'discord' && !focused"
    "100:class_g = 'dmenu' && focused"
    "100:class_g = 'dmenu' && !focused"
    "100:class_g = 'Thunar' && focused"
    "100:class_g = 'Thunar' && !focused"
    "100:class_g = 'Nemo' && focused"
    "100:class_g = 'Nemo' && !focused"
    "90:class_g = 'Spotify' && focused"
    "85:class_g = 'Spotify' && !focused"
    "92:class_g = 'Rofi'"
    "100:class_g = 'gnome-calculator' && focused"
    "100:class_g = 'gnome-calculator' && !focused"
    "70:class_g = 'eDEX-UI' && focused"
    "65:class_g = 'eDEX-UI' && !focused"
    "100:class_g = 'Gimp-2.10'"
    "100:class_g = 'Blockbench' && focused"
    "100:class_g = 'Blockbench' && !focused"
    "100:class_g = 'Steam' && focused"
    "100:class_g = 'Steam' && !focused"
    "100:class_g = 'Element' && focused"
    "100:class_g = 'Element' && !focused"
    "95:class_g = 'VSCodium' && focused"
    "90:class_g = 'VSCodium' && !focused"
    "100:class_g = 'Lapce' && focused"
    "100:class_g = 'Lapce' && !focused"
    "90:class_g = 'balena-etcher-electron'"
    "100:class_g = 'Blender' && focused"
    "100:class_g = 'Blender' && !focused"
    "100:class_g = 'firefox'"
    "100:class_g = 'Polybar'"
  ];

  "corner-radius" = 20;
  "rounded-corners-exclude" = [
    "window_type = 'desktop'"
    "window_type = 'tooltip'"
    "class_g = 'shutter'"
    "class_g = 'eww-*'"
    "class_g = 'activate-linux'"
    "class_g = 'escrotum'"
    "class_g = 'Peek'"
    "_GTK_FRAME_EXTENTS@:c"
    "class_g = 'Bar'"
    "class_g = 'eww-background-closer'"
  ];

  "blur-background-exclude" = [
    "window_type = 'dock'"
    "window_type = 'menu'"
    "_GTK_FRAME_EXTENTS@:c"
    "class_g ~= '^((?!eww-powermenu).)eww-*$'"
    "class_g = 'activate-linux'"
    "class_g = 'escrotum'"
    "class_g = 'Peek'"
    "class_g = 'Tint2'"
    "class_g = 'Slop'"
    "class_g = 'slop'"
    "class_g = 'conky'"
  ];

  "mark-wmwin-focused" = true;
  "mark-ovredir-focused" = true;
  "detect-rounded-corners" = true;
  "detect-client-opacity" = true;
  "detect-transient" = true;
  "use-damage" = true;
  "glx-no-stencil" = true;
  "log-level" = "warn";

  "wintypes" = {
    "tooltip" = {
      "fade" = true;
      "shadow" = false;
      "opacity" = 1.0;
      "focus" = true;
      "full-shadow" = false;
    };
    "dock" = {"shadow" = true;};
    "dnd" = {"shadow" = true;};
    "popup_menu" = {"opacity" = 1.0;};
    "dropdown_menu" = {"opacity" = 1.0;};
  };
}
