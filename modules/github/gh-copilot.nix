{ lib
, fetchFromGitHub
, buildGoModule
}:

buildGoModule rec {
  pname = "gh-copilot";

  src = fetchFromGitHub {
    owner = "github";
    repo = "gh-copilot";
    rev = "ca1ec3308c5860a7a5b728382276aa086fa9fa0d";
    sha256 = "";
  };
}
