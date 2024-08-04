{ ulib, pkgs, theme, ... }: with ulib; merge

(systemConfiguration {
  # fonts.fontconfig.antialias = false; # please don't

  # Disable antialiasing for specific fonts (CozetteVector in this case)
  fonts.fontconfig = enabled {
      localConf = ''
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

  (nerdfonts.override {
    fonts = ["JetBrainsMono"];
  })

  # noto-fonts
  # noto-fonts-cjk-sans
  # noto-fonts-lgc-plus
  noto-fonts-emoji
  jetbrains-mono
  # iosevka

  # # Bitmap Fonts
  cozette
  tewi-font
  # creep
]))
