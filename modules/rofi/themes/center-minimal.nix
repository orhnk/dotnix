{
  configuration = {
    modi = "drun,run,filebrowser,window";
    show-icons = false;
    drun-display-format = "{name}";
    window-format = "{w} · {c} · {t}";
  };

  window = {
    transparency = "real";
    location = "center";
    anchor = "center";
    fullscreen = false;
    width = "200px";
    x-offset = "0px";
    y-offset = "0px";
    enabled = true;
    border-radius = "0px";
    cursor = "default";
    background-color = "@background";
  };

  mainbox = {
    enabled = true;
    spacing = "0px";
    background-color = "transparent";
    orientation = "vertical";
    children = map ["inputbar" "listbox"];
  };

  listbox = {
    spacing = "0px";
    padding = "0px";
    background-color = "transparent";
    orientation = "vertical";
    children = map ["listview"];
  };

  inputbar = {
    enabled = true;
    text-color = "@foreground";
    children = map ["entry"];
  };

  entry = {
    enabled = true;
    expand = true;
    padding = "12px 16px";
    border-radius = "0px";
    background-color = "@background-alt";
    text-color = "inherit";
    cursor = "text";
    placeholder = "Search";
    placeholder-color = "inherit";
  };

  listview = {
    enabled = true;
    columns = 1;
    padding = "10px";
    lines = 10;
    cycle = true;
    dynamic = true;
    scrollbar = false;
    layout = "vertical";
    reverse = false;
    fixed-height = true;
    fixed-columns = true;
    background-color = "transparent";
    text-color = "@foreground";
    cursor = "default";
  };

  element = {
    enabled = true;
    padding = "0px 5px";
    border-radius = "0px";
    background-color = "transparent";
    text-color = "@foreground";
    cursor = "pointer";
  };

  "element normal.normal" = {
    background-color = "inherit";
    text-color = "inherit";
  };

  "element normal.urgent" = {
    background-color = "@urgent";
    text-color = "@foreground";
  };

  "element normal.active" = {
    background-color = "@active";
    text-color = "@foreground";
  };

  "element selected.normal" = {
    background-color = "@selected";
    text-color = "@background";
  };

  "element selected.urgent" = {
    background-color = "@urgent";
    text-color = "@background";
  };

  "element selected.active" = {
    background-color = "@urgent";
    text-color = "@foreground";
  };

  "element-icon" = {
    background-color = "transparent";
    text-color = "inherit";
    size = "23px";
    cursor = "inherit";
  };

  "element-text" = {
    background-color = "transparent";
    text-color = "inherit";
    cursor = "inherit";
    vertical-align = 0.5;
    horizontal-align = 0.0;
  };
}
