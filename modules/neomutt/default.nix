{
  pkgs,
  ulib,
  ...
}:
with ulib;
  homeConfiguration {
    programs.neomutt = enabled {
      editor = "nvim";
      sort = "date";
      vimKeys = true;
      sidebar = enabled {};
      # extraconfig.source = ./config;
    };

    xdg.configFile."neomutt".source = pkgs.symlinkJoin {
      name = "neomutt";
      paths = [
        # (pkgs.writeTextDir "lua/custom/themes/dynamic.lua" vimacs-theme) # TODO
        ./config
      ];
    };

    programs.fish.shellAliases = {
      mail = "neomutt";
    };
  }
