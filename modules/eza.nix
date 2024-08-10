{
  lib,
  ulib,
  pkgs,
  ...
}:
with ulib;
  graphicalConfiguration {
    programs.eza = enabled {
      enableFishIntegration = true;
      git = true;
      icons = true;
    };
    programs.fish.shellAliases.ls = "${lib.getExe pkgs.eza}";
  }
