{
  ulib,
  pkgs,
  theme,
  ...
}:
with ulib;
  merge
  (systemConfiguration {
    # fonts.fontconfig.antialias = false; # please don't

    # Disable antialiasing for specific fonts (CozetteVector in this case)
    fonts.fontconfig = enabled {
      localConf = ''
        <!-- Disable antialiasing for specific fonts (CozetteVector) -->
        <match target="font">
          <test name="family" qual="any">
            <string>CozetteVector</string>
          </test>
          <edit name="hinting" mode="assign">
            <bool>false</bool>
          </edit>
          <edit name="antialias" mode="assign">
            <bool>false</bool>
          </edit>
          <edit name="lcdfilter" mode="assign">
            <const>lcddefault</const>
          </edit>
        </match>

        <!-- Match Arabic script and set IranNastaliq as the preferred font -->
        <match>
          <test name="lang" compare="contains">
            <string>ar</string>
          </test>
          <edit name="family" mode="prepend" binding="strong">
            <string>IranNastaliq</string>
          </edit>
        </match>

        <!-- Match Latin script and set JetBrains Mono as the preferred font -->
        <match>
          <test name="lang" compare="contains">
            <string>en</string>
          </test>
          <edit name="family" mode="prepend" binding="strong">
            <string>JetBrains Mono</string>
          </edit>
        </match>
      '';
    };

    console = {
      earlySetup = true;
      font = "Lat2-Terminus16";
      packages = with pkgs; [terminus_font];
    };
  })
  (systemFonts (with pkgs; [
    theme.font.sans.package
    theme.font.mono.package
    theme.font.extra.package

    (nerdfonts.override {
      fonts = ["JetBrainsMono"];
    })

    # noto-fonts
    # noto-fonts-cjk-sans
    # noto-fonts-lgc-plus
    noto-fonts-emoji
    jetbrains-mono
    iosevka

    # # Bitmap Fonts
    cozette
    tewi-font
    # creep
    siji # pixel icons

    # Non-Latin
    scheherazade-new

    # Custom Fonts
    (pkgs.stdenv.mkDerivation {
      name = "arabic-diwani-font";
      src = ./custom/33-B-Fantezy.ttf;
      phases = ["installPhase"]; # Skip unpack and build phases
      installPhase = ''
        mkdir -p $out/share/fonts/truetype
        cp $src $out/share/fonts/truetype/
      '';
    })

    (pkgs.stdenv.mkDerivation {
      name = "arabic-riqa-font";
      src = ./custom/ArefRuqaa-Bold-1.ttf;
      phases = ["installPhase"]; # Skip unpack and build phases
      installPhase = ''
        mkdir -p $out/share/fonts/truetype
        cp $src $out/share/fonts/truetype/
      '';
    })
  ]))
