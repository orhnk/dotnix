{
  lib,
  pkgs,
  ulib,
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
      shellAliases = {
        e = "$EDITOR";
      };
      interactiveShellInit = ''
        set fish_greeting # Disable greeting

        # SET UP CARAPCE COMPLETIONS #
        set -Ux CARAPACE_BRIDGES 'zsh,fish,bash,inshellisense' # optional
        mkdir -p ~/.config/fish/completions
        # carapace --list | awk '{print $1}' | xargs -I{} touch ~/.config/fish/completions/{}.fish # disable auto-loaded completions (#185)
        carapace _carapace | source
      '';

      plugins = with pkgs.fishPlugins; [
        {
          name = "z";
          src = z.src;
        }
        {
          name = "autopair";
          src = autopair.src;
        }
        {
          name = "wakatime-fish";
          src = wakatime-fish.src;
        }
        {
          name = "done";
          src = done.src;
        }
        {
          name = "fzf-fish";
          src = fzf-fish.src;
        }
        {
          name = "forgit";
          src = forgit.src;
        }
        {
          name = "plugin-git";
          src = plugin-git.src;
        }
        # {
        #   name = "grc";
        #   src = grc.src;
        # }
        # {
        #   name = "humantime-fish";
        #   src = humantime-fish.src;
        # } # ms ureadable time to sing `humatime`
        {
          name = "puffer";
          src = puffer.src;
        } # ... !! etc.
      ];
    };
  })
  # System-wide plugins
  (homePackages (with pkgs; [
    carapace
    fzf
    # grc
  ]))
