{ ulib, pkgs, ... }: with ulib; merge

(systemPackages (with pkgs; [
  (python311.withPackages (pkgs: with pkgs; [
    pip
    requests
    # howdoi # stackoverflow search --bad--
  ]))
  virtualenv
  poetry
]))

(homeConfiguration {
  programs.fish.shellAliases = {
    venv = "virtualenv venv";
  };
})
