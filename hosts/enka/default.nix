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

  "bat"
  "blueman"
  "boot"
  "btop"
  "discord"
  # "dmenu" # nushell issue #9497
  "dunst"
  "dwm"
  # "emacs" # BROKEN
  "eww"
  "feh"
  "firefox"
  "fish"
  "fonts"
  "ghostty"
  "github"
  "git"
  "gtk"
  "helix"
  "jetbrains"
  "kitty"
  "kmscon"
  "localisation"
  "logind"
  "matrix"
  "networkmanager"
  "nix"
  "nushell"
  "nvidia"
  "packages"
  "picom"
  "pulseaudio"
  "pueue"
  "python"
  "qt"
  "ripgrep"
  "rust"
  "rofi"
  "sioyek"
  "ssh"
  "st"
  "steck"
  "sudo"
  "vimacs"
  "vscode"
])
