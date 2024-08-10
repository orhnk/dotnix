{ulib, ...}:
with ulib;
  systemConfiguration {
    services.udisks2 = enabled;
    services.devmon = enabled;
    services.gvfs = enabled;
  }
