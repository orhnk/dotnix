{
  ulib,
  lib,
  pkgs,
  upkgs,
  ...
}:
with ulib;
  merge3
  (homeConfiguration {
    programs.fish.shellAliases.x = "hx";
    programs.helix = enabled {
      languages.language = [
        {
          name = "nix";

          auto-format = false;
          formatter.command = "alejandra";
          formatter.args = ["-"];

          language-servers = ["nixd"];
        }
      ];

      languages.language-server.nixd.command = "nixd";

      settings.theme = "base16_transparent"; # Adaptive but ugly
      # settings.theme = "gruvbox";

      settings.editor = {
        # color-modes = true;
        # completion-replace = true;
        # completion-trigger-len = 0;
        # cursor-shape.insert = "bar";
        # cursorline = true;
        # bufferline = "multiple";
        # file-picker.hidden = false;
        # idle-timeout = 300;
        line-number = "relative";
        shell = ["bash" "-c"];
        # text-width = 100;
      };

      # settings.editor.indent-guides = {
      #   character = "▏";
      #   render = true;
      # };

      # settings.editor.statusline.mode = {
      #   insert = "INSERT";
      #   normal = "NORMAL";
      #   select = "SELECT";
      # };

      # settings.editor.whitespace = {
      #   characters.tab = "→";
      #   render.tab = "all";
      # };

      settings.keys =
        lib.genAttrs ["normal" "select"] (name: {
          # Case sensitive
          D = "extend_to_line_end";
          # TAB = "buffer_next";
          # S-tab = "buffer_previous";
        })
        // lib.genAttrs ["insert"] (name: {
          j = {
            k = "normal_mode";
            j = "normal_mode";
          };
        });
    };
  })
  (systemConfiguration {
    # environment.variables = {
    #   EDITOR = "hx";
    #   VISUAL = "hx";
    # };
  })
  (homePackages (with pkgs; [
    # CMAKE
    cmake-language-server

    # # GO
    # gopls

    # HTML
    vscode-langservers-extracted

    # # KOTLIN
    # kotlin-language-server

    # # LATEX
    # texlab

    # LUA
    lua-language-server

    # MARKDOWN
    marksman

    # NIX
    alejandra
    nixd

    # PYTHON
    python311Packages.python-lsp-server

    # RUST
    rust-analyzer

    # # ZIG
    # upkgs.zls
  ]))
