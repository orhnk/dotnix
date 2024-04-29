{ ulib, pkgs, ... }: with ulib;

(homePackages (with pkgs; [
  tor-browser
  briar-desktop
  onionshare-gui
  wireshark
]))
