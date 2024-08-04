{
  ulib,
  pkgs,
  ...
}:
with ulib;
  merge
  (systemPackages (with pkgs; [
    steck
  ]))
  (homeConfiguration {
    programs.fish.shellAliases.share = "steck paste";
  })
