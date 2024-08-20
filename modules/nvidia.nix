{
  config,
  lib,
  ulib,
  pkgs,
  ...
}:
with ulib;
  merge
  (systemConfiguration {
    boot.kernelPackages = lib.mkForce pkgs.linuxKernel.packages.linux_5_15; # conflicts with boot.nix. Lower version needed for legacy 390.

    nixpkgs.config.allowBroken = true;
    nixpkgs.config.allowUnfree = true;
    nixpkgs.config.nvidia.acceptLicense = true;
    # Enable OpenGL
    hardware.opengl = enabled;

    # Load nvidia driver for Xorg and Wayland
    # services.xserver.videoDrivers = ["nvidiaLegacy390"]; # nVidia GeForce GT630
    services.xserver.videoDrivers = ["nvidia"];

    boot.blacklistedKernelModules = ["nouveau"];

    hardware.nvidia = {
      # Modesetting is required.
      modesetting = enabled;

      # # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
      # powerManagement.enable = false;
      # # Fine-grained power management. Turns off GPU when not in use.
      # # Experimental and only works on modern Nvidia GPUs (Turing or newer).
      # powerManagement.finegrained = false;

      # Use the NVidia open source kernel module (not to be confused with the
      # independent third-party "nouveau" open source driver).
      # Support is limited to the Turing and later architectures. Full list of
      # supported GPUs is at:
      # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
      # Only available from driver 515.43.04+
      # Currently alpha-quality/buggy, so false is currently the recommended setting.
      open = false;

      # Enable the Nvidia settings menu,
      # accessible via `nvidia-settings`.
      nvidiaSettings = true;

      # # Optionally, you may need to select the appropriate driver version for your specific GPU.
      package = config.boot.kernelPackages.nvidiaPackages.legacy_390; # BROKEN on nixpkgs
    };

    ## Fixes nvidia-smi but doesn't work globally (set it within a shell)
    # environment.sessionVariables = {
    #   LD_LIBRARY_PATH = "/run/opengl-driver/lib";
    # };
  })
  (systemPackages [
    (pkgs.linuxPackages.nvidia_x11)
  ])
