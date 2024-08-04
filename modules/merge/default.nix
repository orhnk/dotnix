{ulib, pkgs, ...}: with ulib;

(homePackages [
  (pkgs.callPackage (import ./merge.nix) {})
])
