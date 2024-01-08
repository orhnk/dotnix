{
  rustPlatform,
  pkgs,
}:

rustPlatform.buildRustPackage {
  pname = "merge";
  version = "0.1.0";

  src = pkgs.symlinkJoin {
    name = "merge";
    paths = [
      ./src
    ];
  };

  # sourceRoot = "${src.name}/cargo-insta";

  cargoHash = "sha256-a9htCxhEdfgiwMe7il3xqmulZjDPk7kWYzGC4vfugOI=";

  # meta = with lib; {
  #   description = "Minimalist window manager for X11";
  #   homepage = "https://github.com/orhnk";
  #   changelog = "https://github.com/mitsuhiko/insta/blob/${version}/CHANGELOG.md";
  #   license = licenses.asl20;
  #   maintainers = with maintainers; [ figsoda oxalica matthiasbeyer ];
  # };
}
