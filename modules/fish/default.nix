{
  config,
  ulib,
  pkgs,
  upkgs,
  theme,
  ...
}:
with ulib; merge3

  (systemConfiguration {
    users.defaultUserShell = pkgs.fish;
  })

  (homeConfiguration {
    programs.starship = enabled {};
    programs.fish = enabled {
      interactiveShellInit = ''
        set fish_greeting # Disable greeting
      '';
    };
  })

  (systemConfiguration {
    users.users.nixos.ignoreShellProgramCheck = true;
    users.users.root.ignoreShellProgramCheck = true;
  })
