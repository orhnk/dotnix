{
  ulib,
  theme,
  ...
}:
with ulib;
  graphicalConfiguration {
    services.dunst = with theme.withHashtag;
      enabled {
        iconTheme = icons;

        settings.global = {
          width = "(0, 200)";
          # height = "(0, 200)";

          dmenu = "rofi -dmenu -i";

          corner_radius = corner-radius;
          gap_size = margin;
          horizontal_padding = padding;
          padding = padding;

          frame_color = base0A;
          frame_width = app-contour;
          separator_color = "frame";
          transparency = 10;

          background = base00;
          foreground = base07;

          alignment = "right";
          font = "${font.sans.name} ${toString font.size.normal}";

          min_icon_size = 100;

          offset = "50x50";
          origin = "top-right";
        };

        settings.urgency_low = {
          frame_color = base0D;
          timeout = 5;
        };

        settings.urgency_normal = {
          frame_color = base0B;
          timeout = 10;
        };

        settings.urgency_critical = {
          frame_color = base08;
          timeout = 15;
        };
      };
  }
