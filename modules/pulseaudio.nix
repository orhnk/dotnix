{
  ulib,
  pkgs,
  ...
}:
with ulib;
  merge
  (systemConfiguration {
    security.rtkit = enabled {};

    services.pipewire = enabled {
      alsa = enabled {support32Bit = true;};
      audio = enabled {};
      pulse = enabled {};
      jack = enabled {};
    };

    # nixpkgs.config.pulseaudio = true;
    # hardware.pulseaudio = enabled {
    #   support32Bit = true; ## If compatibility with 32-bit applications is desired.
    #   package = pkgs.pulseaudioFull;
    #   extraConfig = ''
    #     load-module module-alsa-source device=hw:1,0
    #     load-module module-alsa-source device=hw:1,2
    #   '';
    # };
  })
  (systemPackages (with pkgs; [
    # pulsemixer # pulseaudio cli
    pwvucontrol
  ]))
