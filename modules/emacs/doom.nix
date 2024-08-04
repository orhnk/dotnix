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
    pname = "doomemacs";
    version = "1.0.0";

    # fetch git repo
    src = pkgs.fetchFromGitHub {
      owner = "doomemacs";
      repo = "doomemacs";
      rev = "36e7aaa619342eff61b1daf3ac664f94d5272db7";
      sha256 = "sha256-AW30n1Nr8sbgN6vvyfFmgL7Jh9PwDRYDH0HmVIlsvqs=";
    };

    propagatedBuildInputs = [pkgs.emacs];

    installPhase = ''
      mkdir -p $out
      cp -r $src/* $out
      # cd $out/bin/
      # ls
      # doom install
    '';

    # doInstallCheck = true;
    #
    # buildPhase = ''
    #   mkdir -p $out
    #   cd $out/
    #   ls
    #   cd bin/
    #   ls
    #   doom sync
    # '';
  }
