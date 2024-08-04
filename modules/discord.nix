{
  ulib,
  pkgs,
  theme,
  ...
}:
with ulib;
  merge
  (graphicalConfiguration {
    # xdg.configFile."Vencord/settings/quickCss.css".text = theme.discordCss;
    programs.fish.shellAliases = {
      dc = "discordo";
    };
  })
  (graphicalPackages (with pkgs; [
    # (discord.override {
    #   withOpenASAR = true;
    #   withVencord  = true;
    # })
    discordo # Using terminal discord client. Helps me to keep my focus.
  ]))
