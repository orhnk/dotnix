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
    programs.nushell.shellAliases = {
      dc = "discordo";
    };
  })
  (
    graphicalPackages (with pkgs; [
      # (discord.override {
      #   withOpenASAR = true;
      #   withVencord  = true;
      # })
      discordo
    ])
  )
