{
  ulib,
  theme,
  pkgs,
  lib,
  fetchurl,
  ...
}: with ulib; merge

(graphicalPackages ( with pkgs; [
  jetbrains-toolbox # crashes on monitor focus change (?)
  # linuxKernel.packages.linux_latest_libre.perf # perf tool
  (jetbrains.plugins.addPlugins pkgs.jetbrains.clion [
      "github-copilot"
      "ideavim"
      "rust"
      "nixidea"
  ])

  (jetbrains.plugins.addPlugins pkgs.jetbrains.rust-rover [
      "github-copilot"
      "ideavim"
      "rust"
  ])
]))

(graphicalConfiguration {
  home.file.".ideavimrc".source = ./dotideavimrc;
})


# JetBrains products are not-compatiple smoothly with NixOS
# You need to patch your build according to the plugins you use !!!
# Some helpful links that will get you there:
# https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/editors/jetbrains/plugins/plugins.json    # <- Check "name" as the name of your plugin you want to patch
# https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/editors/jetbrains/plugins/default.nix#L11C36-L11C44
# https://nixos.wiki/wiki/Jetbrains_Tools

