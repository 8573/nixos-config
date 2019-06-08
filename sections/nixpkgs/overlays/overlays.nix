let

  base = import <nixpkgs> {};

  nixpkgs-mozilla = base.fetchFromGitHub {
    owner = "mozilla";
    repo = "nixpkgs-mozilla";
    # This revision is dated 2019-05-09.
    rev = "33bda5d711a82a2b511262ef3be367a86ef880df";
    sha256 = "0lbb22paqsn3g0ajxzw4vj7lbn9ny2vdkp5sqm3a7wrc56a8r35b";
  };

in [

  (self: super: {
    inherit nixpkgs-mozilla;
  })

  (import "${nixpkgs-mozilla}/rust-overlay.nix")

]
