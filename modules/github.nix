{
  ulib,
  pkgs,
  ...
}:
with ulib;
  merge
  (homePackages (with pkgs; [
    github-copilot-cli # using `gh copilot`
  ]))
  (homeConfiguration {
    programs.gh = enabled {
      settings = {
        git_protocol = "ssh";
        prompt = "enabled";
      };
      extensions = [
        # TODO
      ];
    };

    programs.fish.shellAliases = {
      howto = "github-copilot-cli what-the-shell";
      howtogit = "github-copilot-cli git-assist";
      howtogh = "github-copilot-cli gh-assist";
    };
  })
