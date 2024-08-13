# NOTE found from reddit:
# You can pass the path to lib.mkOutOfStoreSymlink. If you're using flakes, make sure to pass an absolute path string.
{
  pkgs,
  ulib,
  lib,
  ...
}:
with ulib;
  merge3
  (homeConfiguration {
    xdg.configFile."doom".source = pkgs.callPackage (import ./config.nix) {};
    # xdg.configFile."emacs".source = pkgs.callPackage (import ./doom.nix) {};

    services.emacs = enabled {};
    programs.emacs = enabled {
      # package = pkgs.emacs29-pgtk;
    };
  })
  (homePackages (with pkgs; [
    # # org-mode export to pdf
    # (texlive.combine {
    #   inherit
    #     (texlive)
    #     scheme-basic
    #     dvisvgm
    #     dvipng # for preview and export as html
    #     wrapfig
    #     amsmath
    #     ulem
    #     hyperref
    #     capt-of
    #     beamer # for org-mode export to pdf
    #     ;
    # })
    emacs-all-the-icons-fonts # doom fonts for various icons
    # texlive.combined.scheme-medium # for org-mode export, (e.g pdflatex"")
    pandoc # universal.
    ispell # for flycheck
    aspellDicts.tr # for ispell emacs
    # graphviz
    emacsPackages.vterm
  ]))
# ( with pkgs;
#     systemPackages [
#       # emacsPackages.vterm
#       # #(pkgs.emacs.override {withGTK3 = false; nativeComp = true;})
#       # emacsPackages.adwaita-dark-theme
#     ] )

  (systemFonts (with pkgs; [
    eb-garamond
  ]))
