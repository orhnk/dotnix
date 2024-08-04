{
  ulib,
  pkgs,
  ...
}:
with ulib;
  merge
  (systemPackages (with pkgs; [
    lynx
    neovim
  ]))
  (let
    lynxConfig = builtins.readFile ./lynx.cfg;
  in
    homeConfiguration {
      home.file.".lynxrc".text = lynxConfig;
    })
