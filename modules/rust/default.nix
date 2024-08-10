{
  inputs,
  ulib,
  pkgs,
  ...
}:
with ulib;
  merge
  (systemConfiguration {
    nixpkgs.overlays = [inputs.fenix.overlays.default];
  })
  (let
    flatList = list:
      builtins.concatLists (map (x:
        if builtins.isList x
        then x
        else [x])
      list);
  in
    systemPackages (with pkgs;
      flatList [
        (fenix.complete.withComponents [
          "cargo"
          "clippy"
          "rust-src"
          "rust-std"
          "rust-docs"
          "rustc"
          "rustfmt"
        ])

        # trunk

        rustc
        cargo

        rustup
        cargo-watch
        cargo-expand
        evcxr # Rust REPL
      ]))
