{
  ulib,
  theme,
  ...
}:
with ulib;
  homeConfiguration {
    programs.sioyek = with theme.withHashtag;
      enabled {
        config = {
          "startup_commands" = "toggle_custom_color;toggle_statusbar";

          "custom_color_contrast" = "0.3";
          "custom_color_mode_empty_background_color" = base01;
          "page_separator_color" = base01;
          "page_separator_width" = "10";
          "custom_background_color" = base00;
          "custom_text_color" = base07;
          "search_highlight_color" = base0C;
          "status_bar_color" = base0B;
          "status_bar_text_color" = base07;
        };
      };
  }
