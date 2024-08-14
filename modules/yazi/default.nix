{
  ulib,
  lib,
  pkgs,
  theme,
  ...
}:
with ulib;
  merge
  (let
    no-statusline = ''
      function Status:render() return {} end

      local old_manager_render = Manager.render
      function Manager:render(area)
        return old_manager_render(self, ui.Rect { x = area.x, y = area.y, w = area.w, h = area.h + 1 })
      end
    '';
  in
    # KEYBINDINGS: https://yazi-rs.github.io/docs/quick-start
    # MORE ON NIX OPTIONS: https://mynixos.com/search?q=yazi
    # https://sourcegraph.com/github.com/nix-community/home-manager/-/blob/tests/modules/programs/yazi/settings.nix
    homeConfiguration {
      # # xdg.configFile."yazi/init.lua".source = ./config/init.lua;
      # xdg.configFile."yazi/plugins".source = ./config/plugins;

      programs.yazi = enabled {
        # Bleeding edge
        package = pkgs.yazi.overrideAttrs (oldAttr: {
          src = pkgs.fetchFromGitHub {
            owner = "sxyazi";
            repo = "yazi";
            rev = "a9eb218a5be4059633b9978c183537f28bd1203b";
            sha256 = "sha256-nvcFDWZx/g65fT/+eaya0/MIATNvoCLQ0JXuUCgdE/I=";
          };
        });
        enableFishIntegration = true;
        shellWrapperName = "fm"; # Alias with shell integration (auto cd etc.)

        initLua =
          # write configuration parts to file by concating in nix e.g no-statusline
          lib.concatStringsSep "\n" [
            no-statusline
          ];

        keymap = {
          manager.prepend_keymap = [
            # input.keymap = [
            {
              on = ["l"];
              run = "plugin --sync smart-enter";
              desc = "Enter the child directory, or open the file";
            }

            {
              on = ["f"];
              run = "plugin jump-to-char";
              desc = "Jump to char";
            }

            {
              on = ["<C-x>"];
              run = ''
                shell '${lib.getExe pkgs.xdragon} -x -i -T "$1"' --confirm
              '';
            }

            {
              on = ["<C-y>"];
              run = ["plugin system-clipboard"];
            }

            {
              on = ["C"];
              run = ["plugin chmod"];
            }

            {
              on = ["T"];
              run = "plugin --sync max-preview";
              desc = "Maximize or restore preview";
            }

            {
              on = ["<Tab>"];
              run = "tab_switch 1 --relative";
            }

            {
              on = ["<BackTab>"];
              run = "tab_switch -1 --relative";
            }
          ];
        };

        plugins = builtins.listToAttrs (
          map (x: {
            name = x;
            value = ./plugins/${x}.yazi;
          }) [
            "smart-enter"
            "max-preview"
            "jump-to-char"
            "system-clipboard"
            "chmod"
          ]
        );

        settings = {
          # log = {
          #   enabled = false;
          # };
          manager = {
            #   show_hidden = true;
            sort_by = "modified";
            sort_reverse = true;
            sort_dir_first = false;
            linemode = "mtime";
          };

          preview = {
            max_width = 2000;
            max_height = 2000;
          };

          # opener = {
          #   edit = [
          #     {
          #       run = ''nvim "$@"'';
          #       block = true;
          #     }
          #   ];
          # };
        };

        flavors = {
          dynamic = pkgs.symlinkJoin {
            name = "yazi-dynamic-theme";
            paths = [
              (pkgs.writeTextDir "tmtheme.xml" theme.tmTheme)
              ./flavor/dynamic.yazi
            ];
          };
        };
      };
    })
  (homePackages (with pkgs; [
    # xdragon # Drag & Drop functionality # Use system-clipboard instead.
    clipboard-jh
  ]))
