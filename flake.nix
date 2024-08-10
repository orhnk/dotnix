{
  description = "My NixOS Configurations";

  nixConfig = {
    # https://hyprland.cachix.org/
    extra-substituters = ''
      https://nix-community.cachix.org/
      https://cache.privatevoid.net/
      https://cache.garnix.io/
    '';

    # hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=

    extra-trusted-public-keys = ''
      nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=
      cache.privatevoid.net-1:SErQ8bvNWANeAvtsOESUwVYr2VJynfuc9JRwlzTTkVg=
      cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g=
    '';
  };

  inputs = {
    flake-utils = {
      url = "github:numtide/flake-utils";
    };

    ghostty = {
      url = "git+ssh://git@github.com/orhnk/ghostty";
    };

    ghosttyModule = {
      url = "github:clo4/ghostty-hm-module";
    };

    nixSuper = {
      url = "github:privatevoid-net/nix-super";
    };

    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    homeManager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # hyprland = {
    #   url = "github:hyprwm/Hyprland";
    # };

    # hyprpicker = {
    #   url = "github:hyprwm/hyprpicker";
    # };

    # nuScripts = {
    #   url = "github:nushell/nu_scripts";
    #   flake = false;
    # };

    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zls = {
      url = "github:zigtools/zls";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    tools = {
      url = "github:RGBCube/FlakeTools";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    themes = {
      url = "github:orhnk/PhoeNix";
    };

    wallpapers = {
      url = "github:orhnk/Wallpapers";
      flake = false;
    };
  };

  outputs = {
    self,
    flake-utils,
    nixSuper,
    nixpkgs,
    homeManager,
    # nuScripts,
    ghosttyModule,
    fenix,
    tools,
    wallpapers,
    themes,
    ...
  } @ inputs: let
    lib = nixpkgs.lib;
    ulib = import ./lib lib;

    apps.repl = tools.lib.mkApp {
      drv = nixpkgs.pkgs.writeShellScriptBin "repl" ''
        confnix=$(mktemp)
        echo "builtins.getFlake (toString $(git rev-parse --show-toplevel))" >$confnix
        trap "rm $confnix" EXIT
        nix repl $confnix
      '';
    };

    configuration = host: system: let
      pkgs = import nixpkgs {inherit system;};

      upkgs =
        # {inherit nuScripts;}
        # //
        lib.genAttrs
        # "hyprland" "hyprpicker"
        ["nixSuper" "ghostty" "zls"]
        (name: inputs.${name}.packages.${system}.default);

      colorscheme = "gruvbox-material-dark-medium";

      theme = themes.custom (themes.raw.${colorscheme}
        // rec {
          variant =
            if builtins.match ".*light.*" colorscheme != null
            then "light"
            else "dark";

          wallpaperPath = "${wallpapers}/${colorscheme}/favorites";
          # wallpaperPath = "${wallpapers}/${colorscheme}";
          wallpaper =
            if builtins.pathExists wallpaperPath
            then wallpaperPath
            else if builtins.pathExists "${inputs.wallpapers}/default"
            then "${inputs.wallpapers}/default"
            else ./wallpaper.jpg;

          corner-radius = 0;
          border-width = 0;
          app-contour = 3;

          # margin = 10; # aesthetic
          # padding = 8;

          margin = 0; # peak screen usage
          padding = 0;

          font.size.normal = 10;
          font.size.big = 10;

          # font.sans.name = "JetBrainsMono";
          # font.sans.package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};

          font.sans.name = "CozetteVector";
          font.sans.package = pkgs.cozette;

          font.mono.name = font.sans.name;
          font.mono.package = font.sans.package;

          icons.name = "Gruvbox-Plus-Dark";
          icons.package = pkgs.callPackage (import ./derivations/gruvbox-icons.nix) {};
        });

      defaultConfiguration = {
        environment.defaultPackages = [];

        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.sharedModules = [ghosttyModule.homeModules.default];

        networking.hostName = host;
        nixpkgs.hostPlatform = system;
      };
    in
      lib.nixosSystem {
        inherit system;

        specialArgs = {inherit inputs ulib upkgs theme;};
        modules = [
          homeManager.nixosModules.default
          defaultConfiguration
          ./hosts/${host}
        ];
      };

    configurations = builtins.mapAttrs configuration;
  in {
    nixosConfigurations = configurations {
      enka = "x86_64-linux";
    };
  };
}
