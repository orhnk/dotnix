{
  lib,
  ulib,
  pkgs,
  upkgs,
  theme,
  ...
}:
with ulib;
  merge3
  (let
    ghostty-config = ''
      # custom-shader = ${./shaders/crt-homely.glsl}
    '';
  in (graphicalConfiguration {
    programs.ghostty = enabled {
      package = upkgs.ghostty;

      # Disable it when using nushell
      shellIntegration.enableFishIntegration = true;

      # clearDefaultKeybindings = true; # no overriding of default keybindings

      keybindings =
        (lib.mapAttrs' (name: value: lib.nameValuePair "ctrl+shift+${name}" value) {
          c = "copy_to_clipboard";
          v = "paste_from_clipboard";

          z = "jump_to_prompt:-2";
          x = "jump_to_prompt:2";

          j = "new_split:down";
          l = "new_split:right";

          s = "write_scrollback_file";
          i = "inspector:toggle";

          page_down = "scroll_page_fractional:0.33";
          down = "scroll_page_lines:1";

          page_up = "scroll_page_fractional:-0.33";
          up = "scroll_page_lines:-1";

          home = "scroll_to_top";
          end = "scroll_to_bottom";

          "physical:kp_enter" = "reset_font_size";
          "physical:kp_add" = "increase_font_size:1";
          "physical:kp_subtract" = "decrease_font_size:1";

          t = "new_tab";
          q = "close_surface";

          "physical:one" = "goto_tab:1";
          "physical:two" = "goto_tab:2";
          "physical:three" = "goto_tab:3";
          "physical:four" = "goto_tab:4";
          "physical:five" = "goto_tab:5";
          "physical:six" = "goto_tab:6";
          "physical:seven" = "goto_tab:7";
          "physical:eight" = "goto_tab:8";
          "physical:nine" = "goto_tab:9";
          "physical:zero" = "goto_tab:10";
        })
        // (lib.mapAttrs' (name: value: lib.nameValuePair "ctrl+${name}" value) {
          h = "goto_split:left";
          j = "goto_split:bottom";
          k = "goto_split:top";
          l = "goto_split:right";

          "physical:tab" = "next_tab";
          "shift+physical:tab" = "previous_tab";
        })
        // (lib.mapAttrs' (name: value: lib.nameValuePair "alt+shift+${name}" value) {
          j = "scroll_page_lines:1";
          k = "scroll_page_lines:-1";

          e = "equalize_splits";
          f = "toggle_split_zoom";

          r = "reload_config";
        })
        // (lib.mapAttrs' (name: value: lib.nameValuePair "ctrl+alt+${name}" value) {
          h = "resize_split:left,10";
          j = "resize_split:down,10";
          k = "resize_split:up,10";
          l = "resize_split:right,10";
        });

      settings = with theme; {
        font-size = font.size.normal;
        font-family = font.mono.name;
        # font-thicken = true;

        window-padding-x = padding;
        window-padding-y = padding;

        confirm-close-surface = false;

        window-decoration = false;

        gtk-single-instance = true;

        config-file = [
          (toString (pkgs.writeText "base16-config" ghosttyConfig))
          (toString (pkgs.writeText "shader-config" ghostty-config))
        ];
      };
    };
  }))
  (systemConfiguration {
    environment.variables = {TERMINAL = "ghostty";};
  })
  (homeConfiguration {
    xdg.configFile."ghostty/shaders".source = ./shaders;
  })
