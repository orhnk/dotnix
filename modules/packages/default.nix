{
  ulib,
  pkgs,
  ...
}:
with ulib;
  merge3
  (systemPackages (with pkgs; [
    asciinema
    fastfetch
    hyperfine
    moreutils
    nix-index
    nix-output-monitor
    p7zip
    pstree
    strace
    timg
    tree
    usbutils
    yt-dlp
    ffmpeg_5-full # cli image manupilation
    timer #
    notify-desktop # cli desktop nofifier [1]
    translate-shell # cli translator
    ps_mem          # memusage - erroneous

    wine

    clang_16
    clang-tools_16
    go
    jdk
    lld
    maven
    vlang
    zig
    nodejs
  ]))
  (graphicalPackages (with pkgs; [
    # qbittorrent
    # thunderbird
    # whatsapp-for-linux
    xfce.thunar # File Manager
    # vieb # Vim Browser
    # nvi              # Text Editor
    yazi               # File Manager
    kazam

    # (surf.overrideAttrs (oldAttrs: {
    #   src = pkgs.fetchFromGitHub {
    #     owner = "mrdotx";
    #     repo = "surf";
    #     rev = "5901e424a2af56acd1755c45105a1360e92c8d48";
    #     sha256 = "sha256-uj+eWD7GVYiwA/RQU5nzushT/VlFwNNJ6mk1kHlzaZo=";
    #   };
    # }))

    libsForQt5.kolourpaint
    # obs-studio
    # surf
    # lynx # Web Browser
    links2 # better lynx - but not colored :(
    mpv  # Media Player

    libreoffice
    hunspellDicts.en_US
    hunspellDicts.en_GB-ize
  ]))
  (homeConfiguration {
    programs.nushell.shellAliases = {
      ttr   = "trans -t tr";
      lynx  = "lynx duckduckgo.com";
      links = "links duckduckgo.com";
      cast  = "ffmpeg -video_size 1920x1080 -framerate 60 -f x11grab -i :0.0 -f pulse -ac 2 -i default screencast.mp4";
      fm    = "yazi";
    };
  })
# [1]: Used with some nushell scripts (See modules/nushell/scripts/*)
