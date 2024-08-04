{
  inputs,
  ulib,
  pkgs,
  flake-utils,
  ...
}:
with ulib;
  merge
  (systemConfiguration {
    nixpkgs.overlays = [inputs.fenix.overlays.default];
  })
  (systemPackages (with pkgs; [
    # (fenix.complete.withComponents [
    #   "cargo"
    #   "clippy"
    #   "rust-src"
    #   "rust-std"
    #   "rust-docs"
    #   "rustc"
    #   "rustfmt"
    # ])

    trunk
    # cargo-tauri
    # # (pkgs.callPackage (import ./tauri-deps.nix) {}) # TODO

    rustc
    cargo

    rustup
    cargo-watch
    cargo-expand
    evcxr # Rust REPL
  ]))
