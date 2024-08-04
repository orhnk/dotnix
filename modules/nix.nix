{ inputs, lib, ulib, upkgs, pkgs, ... }: with ulib;
merge
(systemConfiguration {
  nix = {
    gc = {
      automatic  = true;
      dates      = "daily";
      options    = "--delete-older-than 3d";
      persistent = true;
    };

    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

    optimise.automatic = true;

    package = upkgs.nixSuper;

    registry = (lib.filterAttrs
      (name: value: value != {})
      (builtins.mapAttrs
        (name: value: lib.mkIf (value ? sourceInfo) {
          flake = value;
        }) inputs)) // { default.flake = inputs.nixpkgs; };

    settings.experimental-features = [
      "fetch-tree"
      "flakes"
      "nix-command"
      # "repl-flake" # unknown experimental feature
    ];

    settings.trusted-users = [ "root" "@wheel" ];
    settings.warn-dirty = false;
  };

  programs.nix-ld = enabled {};
})


(systemPackages (with pkgs; [
  nix-output-monitor
]))
