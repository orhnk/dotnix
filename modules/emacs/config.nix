{
  lib,
  stdenv,
  pkgs,
  src,
  emacs,
}: let
  config = ./config;
in
  stdenv.mkDerivation {
    pname = "doom-emacs";
    version = "1.0.0";

    src = pkgs.symlinkJoin {
      name = "doomemacs";
      paths = [
        ./config
      ];
    };

    buildPhase = ''
      mkdir -p $out
      cp -r $src/* $out/
    '';
  }
