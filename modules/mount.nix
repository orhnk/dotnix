{
  pkgs,
  ulib,
  ...
}:
with ulib;
  merge
  (systemConfiguration {
    services.udisks2 = enabled;
    services.devmon = enabled;
    services.gvfs = enabled;
  })
  (systemPackages (with pkgs; [
    # udiskie
  ]))
