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
    ffmpeg # cli image manupilation
    timer #
    notify-desktop # cli desktop nofifier [1]
    translate-shell # cli translator
    gh
    # github-copilot-cli # using `gh copilot`

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
    vieb # Vim Browser
    # nvi              # Text Editor
    ranger
    kazam

    (surf.overrideAttrs (oldAttrs: {
      src = pkgs.fetchFromGitHub {
        owner = "mrdotx";
        repo = "surf";
        rev = "5901e424a2af56acd1755c45105a1360e92c8d48";
        sha256 = "sha256-uj+eWD7GVYiwA/RQU5nzushT/VlFwNNJ6mk1kHlzaZo=";
      };
    }))

    libsForQt5.kolourpaint
    obs-studio
    # surf
    mpv # Media Player

    libreoffice
    hunspellDicts.en_US
    hunspellDicts.en_GB-ize
  ]))
  (systemConfiguration {
    # Workaround for a surf error: https://github.com/NixOS/nixpkgs/issues/16327
    # services.gnome3.at-spi2-core.enable = true;
  })
# [1]: Used with some nushell scripts (See modules/nushell/scripts/*)
