{
  inputs,
  lib,
  ulib,
  upkgs,
  pkgs,
  ...
}:
with ulib;
  merge
  (systemConfiguration {
    nix = {
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 30d";
      };

      nixPath = ["nixpkgs=${inputs.nixpkgs}"];

      optimise.automatic = true;

      package = upkgs.nixSuper;

      registry =
        (lib.filterAttrs
          (name: value: value != {})
          (builtins.mapAttrs
            (name: value:
              lib.mkIf (value ? sourceInfo) {
                flake = value;
              })
            inputs))
        // {default.flake = inputs.nixpkgs;};

      settings = {
        experimental-features = [
          "fetch-tree"
          "flakes"
          "nix-command"
        ];

        auto-optimise-store = true;
        trusted-users = ["root" "@wheel"];
        warn-dirty = false;
      };
    };
    programs.nix-ld = enabled {};
  })
  (systemPackages (with pkgs; [
    nix-output-monitor
  ]))
