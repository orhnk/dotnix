{ ulib, pkgs, ... }: with ulib;

graphicalPackages (with pkgs; [
  # platformio
  arduino-ide
])
