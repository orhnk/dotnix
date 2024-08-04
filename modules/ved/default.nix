{ ulib, pkgs, ... }: with ulib;

(homePackages [
  (pkgs.callPackage (import ./ved.nix) {
    # vlang = pkgs.vlang.overrideAttrs (oldAttrs: {
    #   src = pkgs.fetchFromGitHub {
    #     owner = "vlang";
    #     repo = "v";
    #     rev = "045951924faa8dd4838251306cf13b980de18bff";
    #     sha256 = "sha256-hAPySZprwRnfznUdF4WpJb3JfhuRLn47FY9DJkfypYk=";
    #   };
    # });
  })
])
