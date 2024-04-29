{
  lib,
  pkgs,
  vlang,
  ...
}:
pkgs.stdenv.mkDerivation {
  pname = "ved";
  version = "0.0.1";

  src = lib.cleanSource ./src;

  HOME = "/tmp";
  sandBoxProfile = "";

  nativeBuildInputs = with pkgs.xorg; [libX11 libXi libXcursor vlang ];

  installPhase = ''
    mkdir -p /tmp/bin/

    v . -o /tmp/bin/ved

    install -D /tmp/bin/ved $out/bin/ved
  '';
}
