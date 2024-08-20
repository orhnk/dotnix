{
  ulib,
  pkgs,
  ...
}:
with ulib;
  merge3
  (systemPackages (with pkgs; [
    # internetarchive # python script download from archive.org
    # asciinema
    pfetch
    btop
    # p7zip # zip and unzip stuff
    tree
    ffmpeg_4-full # cli image manipulation, screen casting etc.
    translate-shell # cli translator

    clipboard-jh # The only clipboard manageer

    # Productivity
    porsmo # Cli Timer with libnotify + start-stop functionality

    # Programming Language Dependencies
    cmake
    clang_16
    clang-tools_16
    go
    jdk
    lld
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
    # Graphical
    # xournalpp # Advanced note taking with ugly UI some features aren't really good.
    rnote # Minimal Note taking app (rust + gtk) 
    # pinta # Windows Paint
    gimp

    wpsoffice

    libnotify # notify-send
    # qbittorrent
    # thunderbird
    # whatsapp-for-linux
    xfce.thunar # File Manager
    # vieb # Vim Browser
    # kazam # use maim instead
    # rustdesk
    brave

    mpv # Media Player
    # speedread # spead read the docs from the terminal, awesome!
    yewtube # Super productive youtube cli

    # Productivity
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
