{ ulib, ... }: with ulib; merge3

(systemConfiguration {
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "23.05";

  users.users.nixos = graphicalUser {
    description = "orhnk";
    extraGroups = [ "wheel" ];
  };
})

(homeConfiguration {
  home.stateVersion = "23.05";
})

(importModules [
  ./hardware.nix

  "bat"          # `cat` with wings
  "blueman"      # Bluetooth thing
  "boot"         # systemd-boot
  "btop"         # System Monitor
  # "discord"      # Let me sell my personal data
  # "dmenu"      # nushell issue #9497
  "dunst"        # Notification Daemon
  "dwm"          # wm that sucks less
  # "emacs"        # BROKEN
  "eww"          # Widgetzzz
  "feh"          # Image Viewer & Wallpaper Manager
  "firefox"      # Mozilla - pretends safe.
  "fish"         # source of `fish-like` zsh extensions
  "fonts"        # System Fonts
  # "fuzzel"       # Wayland App Launcher
  "ghostty"      # New Zig terminal emulator
  "github"       # Microsoft...
  "git"          # Version Control System
  "gtk"          # GNU ToolKit
  "helix"        # NeoVi
  # "hyprland"     # Some animations... NOTE: enable with waybar + uncomment (Hyprland) in nushell/environment.nix.nu
  "jetbrains"    # Heavy but featureful IDE
  "kitty"        # Aggresively maintained terminal emulator
  # "kmscon"       # TTY but GTK: WARNING: breaks hyprland
  "localisation" # Where are you living sir?
  "logind"    
  "matrix"       # Imitation. but good.
  "networkmanager"
  "nix"          # The only package manager
  "nushell"      # Data. Structured.
  "nvidia"       # Fuck...
  "packages"     # Random cli utilities
  # "picom"        # X Copmpositor
  "pulseaudio"   # Works Better
  "pueue"        # idk
  "python"       # The cool kid
  "qt"           # Cute
  "qutebrowser"  # Browser
  "ripgrep"      # grep. faf.
  "rust"         # You owe me
  "rofi"         # dmenu. But better
  "sioyek"       # wtf is zathura?
  "ssh"          # Servers. Authentication. Safe
  "st"           # SUCKless Terminal (no one knows the real name)
  "steck"        # pastedump
  "sudo"         # Just suDO It!
  "vimacs"       # feature-FULL NeoVim inspired by JetBrains ~ github: orhnk/vimacs
  "vscode"       # Microsoft. Again...
  "weechat"      # Weeee...
  # "waybar"       # wayland bar
])
