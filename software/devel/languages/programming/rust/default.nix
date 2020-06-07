let
  Rust-at-version = channel: pkgs: cfg: (pkgs.rustChannelOf ({
    inherit channel;
  } // cfg)).rust;

  Rust-4th-anniversary-version = Rust-at-version "1.34.2";
  Rust-5th-anniversary-version = Rust-at-version "1.44.0";
in
{
  id = "rust";
  # NOTE: Much of the Rust software installed if this software module is
  # enabled is installed not from this file but from
  # `sections/environment/variables/rust.nix`.
  desc = "software for working with the programming language Rust";
  modules = [
    ./global
  ];
  # NOTE: Don't add Clippy etc. here as rustup extensions; use the NixOS
  # packages for those tools.
  sw = p: with p; ([
    (Rust-4th-anniversary-version p {})
    (Rust-5th-anniversary-version p {})
  ]);
}
