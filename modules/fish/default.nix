{
  ulib,
  pkgs,
  ...
}:
with ulib;
  merge3
  (systemConfiguration {
    users.defaultUserShell = pkgs.fish;
    users.users.root.ignoreShellProgramCheck = true; # FIXME: magic string user: root
  })
  (homeConfiguration {
    programs.starship = enabled {};
    programs.fish = enabled {
      interactiveShellInit = ''
        set fish_greeting # Disable greeting

        # SET UP CARAPCE COMPLETIONS #
        set -Ux CARAPACE_BRIDGES 'zsh,fish,bash,inshellisense' # optional
        mkdir -p ~/.config/fish/completions
        # carapace --list | awk '{print $1}' | xargs -I{} touch ~/.config/fish/completions/{}.fish # disable auto-loaded completions (#185)
        carapace _carapace | source
      '';
    };
  })
  # System-wide plugins
  (homePackages (with pkgs; [
    zoxide # For completions and better cd.
    carapace
    # fzf
    # grc
    # (with fishPlugins; [
    #   done
    #   fzf-fish
    #   forgit
    #   hydro
    #   grc
    # ])
  ]))
