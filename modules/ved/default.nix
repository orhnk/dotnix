{ ulib, pkgs, ... }: with ulib;

(homePackages [
  (pkgs.callPackage (import ./ved.nix) {
    vlang = pkgs.vlang.overrideAttrs (oldAttrs: {
      src = pkgs.fetchFromGitHub {
        owner = "vlang";
        repo = "v";
        rev = "89f06d35fd341a391eda4a98ccdaf42b8513bb40";
        sha256 = "sha256-hAPySZprwRnfznUdF4WpJb3JfhuRLn47FY9DJkfypYk=";
      };
    });
  })
])
