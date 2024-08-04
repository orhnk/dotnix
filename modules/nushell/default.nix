{
  config,
  ulib,
  lib,
  pkgs,
  upkgs,
  theme,
  ...
}:
with ulib;
  merge3
  (systemConfiguration {
    users.defaultUserShell = pkgs.nushell;
  })
  (homeConfiguration {
    programs.zoxide = enabled {
      enableNushellIntegration = true;
    };

    # xdg.configFile. "nushell/zoxide.nu".source = pkgs.runCommand "zoxide.nu" {} ''
    #     ${lib.getExe pkgs.zoxide} init nushell --cmd cd > $out
    #   '';

    programs.starship = enabled {
      settings = {
        command_timeout = 100;
        scan_timeout = 20;

        cmd_duration.show_notifications = true; # should be in a GUI env

        # package.disabled = ulib.isServer;

        character.error_symbol = "";
        character.success_symbol = "";
      };
    };

    programs.nushell = enabled {
      configFile.text = import ./configuration.nix.nu;
      envFile.text = import ./environment.nix.nu {
        inherit (upkgs) nuScripts;
        inherit theme;
      };

      environmentVariables = {
        inherit (config.environment.variables) NIX_LD;
      };

      shellAliases = {
        cdtmp = "cd (mktemp --directory)";

        la = "ls --all";
        ll = "ls --long";
        lla = "ls --long --all";
        sl = "ls";

        cp = "cp --verbose --progress";
        mk = "mkdir";
        mv = "mv --verbose";

        pstree = "pstree -g 2";
        tree = "tree -CF --dirsfirst";

        fd = "rg --files";
        copy = "xclip -selection clipboard";
      };
    };
  })
  (homePackages (with pkgs; [
    carapace
    fish # For completions.
    zoxide # For completions and better cd.
    timer
  ]))
