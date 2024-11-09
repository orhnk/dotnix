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
    porsmo
    # <my fork> Cli Timer with libnotify + start-stop functionality
    # (porsmo.overrideAttrs (oldAttrs: {
    #   src = fetchFromGitHub {
    #     owner = "orhnk";
    #     repo = "porsmo";
    #     rev = "e38195400ba32fd8ae2c2426f5a4bc428a57f953";
    #     sha256 = "";
    #   };
    # }))

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

    mtpfs
    libmtp
    simple-mtpfs
  ]))
  (graphicalPackages (with pkgs; [
    # Graphical
    # xournalpp # Advanced note taking with ugly UI some features aren't really good.
    rnote # Minimal Note taking app (rust + gtk) # using fireshot's screenshot painting
    # pinta # Windows Paint
    gimp

    libnotify # notify-send
    qbittorrent
    # thunderbird
    # whatsapp-for-linux
    xfce.thunar # File Manager
    # vieb # Vim Browser
    # kazam # use maim instead
    # rustdesk
    brave
    telegram-desktop

    mpv # Media Player
    # speedread # spead read the docs from the terminal, awesome!
    # yewtube # Super productive youtube cli # broken
    pipe-viewer

    # Productivity
    # todoist-electron # use google tasks
    obsidian
    anki-bin # Remembering stuff app - flashcards also anki-bin is newer compared to anki. https://nixos.wiki/wiki/Anki
    # notion-app-enhanced # Broken?
    # anytype # Notion alternative
    # polar-bookshelf # NOT WORKING

    libreoffice
    # wpsoffice
    hunspellDicts.en_US
    # hunspellDicts.en_GB-ize
  ]))
  (homeConfiguration {
    programs.fish.shellAliases = {
      yt = "pipe-viewer --novideo";
      ttr = "trans -t tr";
      lynx = "lynx duckduckgo.com";
      links = "links duckduckgo.com";
      screencast = "ffmpeg -video_size 1920x1080 -framerate 60 -f x11grab -i :0.0 -f pulse -ac 2 -i default screencast.mp4";
      screenshot = "ffmpeg -f x11grab -s 1920x1080 -i :0.0 -vframes 1 screenshot.png";
      lg = "lazygit";
    };
  })
# [1]: Used with some nushell scripts (See modules/nushell/scripts/*)
