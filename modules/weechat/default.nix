{
  ulib,
  pkgs,
  ...
}: with ulib; merge

(graphicalPackages (with pkgs; [
  (with pkgs.weechatScripts;
    pkgs.weechat.override {
      configure = {availablePlugins, ...}: {
        scripts = [weechat-autosort weechat-matrix];
        extraBuildInputs = [availablePlugins.python.withPackages (_: [weechat-matrix])];
      };
    })
]))

(graphicalConfiguration {
  programs.nushell.shellAliases = {
    wee = "weechat";
  };
})
