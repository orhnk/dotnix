{
  ulib,
  lib,
  pkgs,
  upkgs,
  theme,
  ...
}:
with ulib;
  merge3
  (let
    vimacs = ./config;
    vimacs-theme = (
      with theme.withHashtag; ''
                  local M = {}

        -- Credits to original https://github.com/morhetz/gruvbox
        -- Customised to swamp.nvim by masroof-maindak.

        local M = {}

        M.base_30 = {
          white = "${base07}",
          darker_black = "${base00}",
          black = "${base01}", --  nvim bg
          black2 = "${base02}",
          one_bg = "${base00}",
          one_bg2 = "${base01}",
          one_bg3 = "${base02}",
          grey = "${base03}",
          grey_fg = "${base04}",
          grey_fg2 = "${base05}",
          light_grey = "${base06}",

          statusline_bg = "${base02}",
          lightbg = "${base06}",

          red           = "${base08}",
          baby_pink     = "${base0E}",
          pink          = "${base0E}",
          line          = "${base03}", -- for lines like vertsplit
          green         = "${base0B}",
          vibrant_green = "${base0B}",
          nord_blue     = "${base0D}",
          blue          = "${base0D}",
          yellow        = "${base0A}",
          sun           = "${base0A}",
          purple        = "${base0E}",
          dark_purple   = "${base0E}",
          teal          = "${base0C}",
          orange        = "${base09}",
          cyan          = "${base0C}",
          pmenu_bg      = "${base03}",
          folder_bg     = "${base03}",
        }

        M.base_16 = {
          base00 = "${base00}",
          base01 = "${base00}",
          base02 = "${base02}",
          base03 = "${base03}",
          base04 = "${base04}",
          base05 = "${base05}",
          base06 = "${base06}",
          base07 = "${base07}",
          base08 = "${base08}",
          base09 = "${base09}",
          base0A = "${base0A}",
          base0B = "${base0B}",
          base0C = "${base0C}",
          base0D = "${base0D}",
          base0E = "${base0E}",
          base0F = "${base0F}",
        }

        M.type = "dark"

        return M
      ''
    );
  in (graphicalConfiguration {
    programs.neovim = enabled {
      package = pkgs.neovim-unwrapped;
      vimAlias = true;
      viAlias = true;
    };

    xdg.configFile."nvim".source = pkgs.symlinkJoin {
      name = "minivim";
      paths = [
        (pkgs.writeTextDir "lua/themes/dynamic.lua" vimacs-theme)
        ./config
      ];

      # Remove the cache after building the configuration
      postBuild = ''
        CACHE_DIR="$HOME/.cache/nvim/luac"
        CACHE_FILE="$CACHE_DIR/%home%nixos%.config%nvim%lua%custom%themes%dynamic.luac"

        if [ -f "$CACHE_FILE" ]; then
          rm "$CACHE_FILE"
        fi
      '';
    };
  }))
  (systemConfiguration {
    environment.variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  })
  (homePackages (with pkgs; [
    neovide
    
    lazygit
    # WakaTime Status Tracker
    wakatime

    # Languages
    # codespell

    # # C/C++
    # cppcheck
    # clangd
    # # CMAKE
    # cmake-language-server

    # LUA
    lua-language-server

    # # MARKDOWN
    # marksman
    deno

    # NIX
    alejandra

    # nixd
    nil
    deadnix

    # # PYTHON
    # python311Packages.python-lsp-server

    # RUST
    rust-analyzer

    # [T]
    taplo

    # Lua
    stylua

    # BASH
    bash-language-server
  ]))
