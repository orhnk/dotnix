{
  acpi,
  imlib2,
  libXinerama,
  libXft,
  libX11,
  gnumake,
  theme ? null,
  appinfo ? null,
  pkgs ? import <nixpkgs> {},
}:
pkgs.stdenv.mkDerivation {
  name = "dwm";

  src = pkgs.symlinkJoin {
    name = "dwm";
    paths = [
      (pkgs.writeTextDir "chadwm/themes/dynamic.h" theme)
      (pkgs.writeTextDir "chadwm/nixos/appinfo.h" appinfo)
      ./config
    ];
  };

  buildInputs = [imlib2 libX11 libXft libXinerama gnumake acpi];

  installPhase = ''
    mkdir $out
    cp -rv $src/chadwm/* $out
    rm $out/config.h -rf

    cd $out
    make dwm

    mkdir bin
    mv dwm bin/dwm

    cp bin/dwm $out
  '';
}
