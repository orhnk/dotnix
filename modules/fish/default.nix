{
  ulib,
  pkgs,
  ...
}:
with ulib;  merge3

  (systemConfiguration {
    users.defaultUserShell = pkgs.fish;
  })

  (systemConfiguration {
    users.users.nixos.ignoreShellProgramCheck = true;
    users.users.root.ignoreShellProgramCheck = true;
  })

  (homeConfiguration {
    programs.starship = enabled {};
    programs.fish = enabled {
      interactiveShellInit = ''
        set fish_greeting # Disable greeting
      '';
    };
  })

  # # System-wide plugins
  # (homePackages (with pkgs; [
  #   fzf
  #   grc
  #   (with fishPlugins; [
  #     done
  #     fzf-fish
  #     forgit
  #     hydro
  #     grc
  #   ])
  # ]))
