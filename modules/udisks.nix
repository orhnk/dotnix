{ulib, ...}:
with ulib;
  systemConfiguration {
    services.udisks2 = enabled {};
  }
