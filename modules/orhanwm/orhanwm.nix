{
  rustPlatform,
  pkgs,
}:

rustPlatform.buildRustPackage {
  pname = "orhanwm";
  version = "0.1.0";

  src = pkgs.symlinkJoin {
    name = "orhanwm";
    paths = [
      ./source
    ];
  };

  # sourceRoot = "${src.name}/cargo-insta";

  cargoHash = "sha256-fnCw5pWJjvKDWmiwBEge7l+6trnyl+gm3EuWAxzcdNw=";

  # meta = with lib; {
  #   description = "Minimalist window manager for X11";
  #   homepage = "https://github.com/orhnk";
  #   changelog = "https://github.com/mitsuhiko/insta/blob/${version}/CHANGELOG.md";
  #   license = licenses.asl20;
  #   maintainers = with maintainers; [ figsoda oxalica matthiasbeyer ];
  # };
}
