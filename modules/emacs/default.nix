# NOTE found from reddit:
# You can pass the path to lib.mkOutOfStoreSymlink. If you're using flakes, make sure to pass an absolute path string.
{
  pkgs,
  ulib,
  ...
}: with ulib; merge

(homeConfiguration {
  xdg.configFile."doom".source = ./config;
  home.file.".doom.d" = {
    source = ./config;
    recursive = true;
    onChange = builtins.readFile ./reload.sh;
  };
  # NOTE: didn't work
  # xdg.configFile."doom".source = ./config; # doom modifies here while `doom sync`
  # xdg.configFile."emacs".source = pkgs.callPackage (import ./doom.nix) {};
  # home.file.".emacs.d".source = pkgs.callPackage (import ./doom.nix) {};

  # use programs.emacs if you don't want to use emacs daemon
  # emacs daemon allows emacs to start up faster
  services.emacs = enabled {};
  programs.emacs = enabled {
    # package = pkgs.emacs29-pgtk;
  };
})

(homePackages (with pkgs; [
    # org-mode export to pdf
    (texlive.combine {
      inherit
        (texlive)
        scheme-basic
        dvisvgm
        dvipng # for preview and export as html
        wrapfig
        amsmath
        ulem
        hyperref
        capt-of
        beamer # for org-mode export to pdf
        ;
    })
    # FIX: although It didn't fix the issue of misrendered icons in doom <17-11-23, utfeight utfeightt@gmail.com>
    emacs-all-the-icons-fonts # doom fonts for various icons
    # texlive.combined.scheme-medium # for org-mode export, (e.g pdflatex"")
    pandoc # universal.
    ispell # for flycheck
    aspellDicts.tr # for ispell emacs
    # graphviz
  ]))
# (
#   with pkgs;
#     systemPackages [
#       # emacsPackages.vterm
#       # #(pkgs.emacs.override {withGTK3 = false; nativeComp = true;})
#       # emacsPackages.adwaita-dark-theme
#     ]
# )
