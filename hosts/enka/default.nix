{ulib, ...}:
with ulib;
  merge3
  (systemConfiguration {
    nixpkgs.config.allowUnfree = true;
    system.stateVersion = "23.05";

    users.users.nixos = graphicalUser {
      description = "orhnk";
      useDefaultShell = true;
      ignoreShellProgramCheck = true;
      extraGroups = ["wheel" "wireshark" "kvm" "adbusers"];
    };
  })
  (homeConfiguration {
    home.stateVersion = "23.05";
  })
  (importModules [
    ./hardware.nix

    # "android-dev" # android development tools
    "bat" # `cat` with wings
    # "blueman"      # Bluetooth thing
    "boot" # systemd-boot
    # "btop"         # System Monitor
    # "dconf" # System Theme Settings here.
    # "discord"      # Let me sell my personal data
    # "dmenu"      # nushell issue #9497 Use rofi. Literally better.
    # "dunst" # Notification Daemon
    "dwm" # wm that sucks less
    # "emacs" # BROKEN # So many features... IDK whether It's good or not.
    # "embedded-dev"     # Embedded Dev Tools
    # "eww"          # Widgetzzz. Just distracting you and the configuration is just taking forever. I use dmenu instead.
    "eza" # Colorful ls command
    "feh" # Image Viewer & Wallpaper Manager
    "firefox" # Mozilla - pretends safe.
    "fish" # source of `fish-like` zsh extensions
    # "fonts" # System Fonts
    # "fuzzel"       # Wayland App Launcher
    "ghostty" # New Zig terminal emulator
    "github" # Microsoft... + "howto"-like commands using AI
    "git" # Version Control System
    # "gtk" # GNU ToolKit
    # "helix" # NeoVi
    # "hyprland"     # Some animations... NOTE: enable with waybar + uncomment (Hyprland) in nushell/environment.nix.nu
    # "jetbrains" # Heavy but featureful IDE
    "kitty" # Good Terminal Emulator. Doesn't support pixel fonts though.
    # "kmscon"       # TTY but GTK: WARNING: breaks hyprland
    "localisation" # Where are you living sir?
    "logind"
    # "lynx"         # Productivity for the caveman # Using brave + productivity extensions.
    # "matrix"       # Imitation. but good. # Just not using it.
    # "merge"        # Package Manager Emulator # Just for project testing.
    # "neomutt"      # Email Client # Extreme minimalism which doesn't help. Maybe for future fantasy.
    # "networkmanager" # Using ETH on my desktop
    "nix" # The only package manager
    # [
    #   "nushell" # Data. Structured.
    #   "pueue" # Long running command notif. Used with nushell.
    # ]
    "nvidia" # Laggy.
    # "orhanwm"      # Custom WM
    "packages" # Wide range of packages
    # "picom" # X Copmpositor for animations, blur, rounded corners etc.
    # "pulseaudio" # Works Better
    "python" # The cool kid
    # "qt"           # Cute
    # "qutebrowser"  # Browser
    "ripgrep" # grep but lightning fast
    "rust" # You owe me
    "rofi" # dmenu. But better
    "sioyek" # better zathura.
    # "ssh"          # Servers. Authentication. Safe # Currently no servers.
    "st" # SUCKless Terminal (no one knows the real name)
    # "steck"        # pastebin client
    "sudo" # Just suDO It!
    "tor" # Have nothing to hide bro.
    # "ved"          # Text Editor written in V Programming Language
    # "vimacs"       # feature-FULL NeoVim inspired by JetBrains ~ github: orhnk/vimacs
    "minivim" # Minimalist NeoVim
    "vscode" # Microsoft. Again...
    "weechat" # Weeee...
    # "waybar"       # wayland bar
    "mount" # Mounting Devices Automatically
    "yazi" # The supperior file manager
  ])
