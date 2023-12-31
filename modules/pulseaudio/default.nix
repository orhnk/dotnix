{ ulib, ... }: with ulib;

systemConfiguration {
  # security.rtkit = enabled {};
  # sound          = enabled {};

  # services.pipewire = enabled {
  #   # alsa  = enabled { support32Bit = true; };
  #   pulse = enabled {};
  # };
  nixpkgs.config.pulseaudio = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;    ## If compatibility with 32-bit applications is desired.

}
