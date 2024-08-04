{ # NOTE: NOT CALLED DURING THE BUILD
  lib,
  runCommand,
  pkgs,
  colorscheme ? "default",
  extraArgs ? ["--bg-fill"],
}:
runCommand "wallpaper.txt" rec {
  name = "wallpaper";
  src = ../wallpapers;

  buildInputs = [pkgs.feh pkgs.xorg.libX11];

  dontBuild = true;
  dontConfigure = true;
} ''
  DISPLAY=:0
  feh ${toString extraArgs} $src/${colorscheme}/**/* # 
''
