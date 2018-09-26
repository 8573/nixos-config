let

  base = import <nixpkgs> {};

  nixpkgs-mozilla = base.fetchFromGitHub {
    owner = "mozilla";
    repo = "nixpkgs-mozilla";
    # This revision is dated 2018-09-13.
    rev = "b9c99d043b1cb55ee8c08265223b7c35d687acb9";
    sha256 = "0akyhdv5p0qiiyp6940k9bvismjqm9f8xhs0gpznjl6509dwgfxl";
  };

in [

  (self: super: {
    inherit nixpkgs-mozilla;
  })

  (import "${nixpkgs-mozilla}/rust-overlay.nix")

]
