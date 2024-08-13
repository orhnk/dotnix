{
  ulib,
  pkgs,
  ...
}:
with ulib;
  merge
  (systemConfiguration {
    programs.adb = enabled {};
  })
  (graphicalPackages (with pkgs; [
    android-studio
    android-tools
  ]))
