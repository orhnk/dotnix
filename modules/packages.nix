{
  ulib,
  pkgs,
  ...
}:
with ulib;
  merge3
  (systemPackages (with pkgs; [
    # Rust Crates
    # ## dioxus
    # pkg-config
    # gtk3
    # gtkmm3
    # atkmm_2_36
    # gtk3-x11
    # gdk-pixbuf-xlib
    # cairo
    # pango
    # dioxus-cli

    # internetarchive # python script download from archive.org
    # asciinema
    # fastfetch
    pfetch
    btop
    # hyperfine # benchmarking tool
    # nix-index
    # p7zip # zip and unzip stuff
    # pstree # tree view of processes
    # strace # trace system calls and signals
    # timg # image viewer for terminal. Using yazi now.
    tree
    # usbutils # lsusb etc.
    # yt-dlp # youtube-dl fork. Using yewtube now.
    ffmpeg_5-full # cli image manipulation, screen casting etc.
    # timer # have custom script: "schedule"
    translate-shell # cli translator
    # ps_mem # memusage - erroneous

    cmake
    clang_16
    clang-tools_16
    go
    jdk
    lld
    # maven # idk what is this?
    # zig
    nodejs
    # vlang
    #   (vlang.overrideAttrs (oldAttrs: {
    #     src = pkgs.fetchFromGitHub {
    #       owner = "vlang";
    #       repo = "v";
    #       rev = "045951924faa8dd4838251306cf13b980de18bff";
    #       sha256 = "sha256-hAPySZprwRnfznUdF4WpJb3JfhuRLn47FY9DJkfypYk=";
    #     };
    #   }))
  ]))
  (graphicalPackages (with pkgs; [
    gimp

    # wine
    wpsoffice

    libnotify # notify-send
    # qbittorrent
    # thunderbird
    # whatsapp-for-linux
    xfce.thunar # File Manager
    # vieb # Vim Browser
    # nvi              # Text Editor
    # kazam # use maim instead
    # rustdesk
    # burpsuite
    brave

    # PROGRAMMING
    android-studio

    # (surf.overrideAttrs (oldAttrs: {
    #   src = pkgs.fetchFromGitHub {
    #     owner = "mrdotx";
    #     repo = "surf";
    #     rev = "5901e424a2af56acd1755c45105a1360e92c8d48";
    #     sha256 = "sha256-uj+eWD7GVYiwA/RQU5nzushT/VlFwNNJ6mk1kHlzaZo=";
    #   };
    # }))

    # libsForQt5.kolourpaint
    # obs-studio
    # surf
    # lynx # Web Browser
    # links2 # better lynx - but not colored :(
    mpv # Media Player
    # zed-editor
    # libgen-cli
    # speedread # spead read the docs from the terminal, awesome!
    # warp-terminal # Requires bash, zsh or fish as default shell
    yewtube # Super productive youtube cli
    # tuir   # Terminal reddit client # Need an update. TODO: TESTME

    # Productivity
    # notion-app-enhanced # probably has a bug or smth. Not opening
    obsidian
    anki-bin # Remembering stuff app - flashcards also anki-bin is newer compared to anki. https://nixos.wiki/wiki/Anki
    # polar-bookshelf # NOT WORKING
    calibre # Ebook Manager

    # libreoffice
    hunspellDicts.en_US
    # hunspellDicts.en_GB-ize
  ]))
  (homeConfiguration {
    programs.fish.shellAliases = {
      ttr = "trans -t tr";
      lynx = "lynx duckduckgo.com";
      links = "links duckduckgo.com";
      screencast = "ffmpeg -video_size 1920x1080 -framerate 60 -f x11grab -i :0.0 -f pulse -ac 2 -i default screencast.mp4";
      screenshot = "ffmpeg -f x11grab -s 1920x1080 -i :0.0 -vframes 1 screenshot.png";
      lg = "lazygit";
    };
  })
# [1]: Used with some nushell scripts (See modules/nushell/scripts/*)
