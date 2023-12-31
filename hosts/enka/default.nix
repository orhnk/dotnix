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

  "bat"        # `cat` with wings
  "blueman"    # Bluetooth thing
  "boot"       # systemd-boot
  "btop"       # System Monitor
  "discord"    # Let me sell my personal data
  # "dmenu"    # nushell issue #9497
  "dunst"      # Notification Daemon
  "dwm"        # wm that sucks less
  # "emacs"      # BROKEN
  "eww"      # Widgetzzz
  "feh"        # Image Viewer & Wallpaper Manager
  "firefox"    # Mozilla
  "fish"       # source of `fish-like` zsh extensions
  "fonts"      # System Fonts
  "ghostty"    # New Zig terminal emulator
  "github"     # Microsoft...
  "git"        # Version Control System
  "gtk"        # GNU ToolKit
  "helix"      # NeoVi
  "jetbrains"  # Heavy but featureful IDE
  "kitty"      # Aggresively maintained terminal emulator
  "kmscon"     # TTY but GTK
  "localisation" # Where are you living?
  "logind"    
  "matrix"     # Imitation
  "networkmanager"
  "nix"        # The only package manager
  "nushell"    # Data. Structured.
  "nvidia"     # Fuck...
  "packages"   # Random cli utilities
  "picom"      # X Copmpositor
  "pulseaudio" # Works Better
  "pueue"      # idk
  "python"     # The cool kid
  "qt"         # Cute
  "ripgrep"    # grep. faf.
  "rust"       # You owe me
  "rofi"       # dmenu. But better
  "sioyek"     # who tf is zathura?
  "ssh"        # Servers. Authentication. Safe
  "st"         # SUCKless Terminal (no one knows the real name)
  "steck"      # ...
  "sudo"       # suDO
  "vimacs"     # feature-FULL NeoVim inspired by JetBrains
  "vscode"     # Microsoft. Again...
])
