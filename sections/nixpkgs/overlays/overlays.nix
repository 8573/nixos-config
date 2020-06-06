let

  base = import <nixpkgs> {};

  nixpkgs-mozilla = base.fetchFromGitHub {
    owner = "mozilla";
    repo = "nixpkgs-mozilla";
    # This revision is dated 2020-02-19.
    rev = "e912ed483e980dfb4666ae0ed17845c4220e5e7c";
    sha256 = "08fvzb8w80bkkabc1iyhzd15f4sm7ra10jn32kfch5klgl0gj3j3";
  };

in [

  (self: super: {
    inherit nixpkgs-mozilla;
  })

  (import "${nixpkgs-mozilla}/rust-overlay.nix")

]
