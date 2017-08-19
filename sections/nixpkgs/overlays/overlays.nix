let

  base = import <nixpkgs> {};

  nixpkgs-mozilla = base.fetchFromGitHub {
    owner = "mozilla";
    repo = "nixpkgs-mozilla";
    # This revision is dated 2017-08-15.
    rev = "ca0031baaac0538b9089625c8fa0b790b4270d36";
    sha256 = "0albnrwnx5ixgxvlrrcdyjsh5r25bqiw0xw7kdgi298inwyz3xz5";
  };

in [

  (self: super: {
    inherit nixpkgs-mozilla;
  })

  (import "${nixpkgs-mozilla}/rust-overlay.nix")

]
