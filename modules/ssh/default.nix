{ ulib, ... }: with ulib;

homeConfiguration {
  programs.ssh = enabled {
    # matchBlocks."*".setEnv.TERM  = "xterm-kitty";

    # matchBlocks.robotic = {
    #   hostname     = "86.105.252.189";
    #   user         = "orhnk";
    #   port         = 2299;
    #   identityFile = "~/.ssh/id_rsa";
    # };
    # FIXME:
    extraConfig = ''
      Host github.com
      IdentityFile /home/nixos/.ssh/id_rsa
    '';
  };
}
