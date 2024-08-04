{
  ulib,
  pkgs,
  ...
}:
with ulib;
  merge
  # FIXME: Generally broken.
  (systemPackages (with pkgs; [
    (python311.withPackages (pkgs:
      with pkgs; [
        pip
        requests
        # howdoi # stackoverflow search ~ bad ~
        # prayer-times-calculator
        # pyserial # for arduino
      ]))
    virtualenv
    # poetry
  ]))
  (homeConfiguration {
    programs.fish.shellAliases = {
      venv = "virtualenv venv";
    };
  })
