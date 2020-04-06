let
  Rust = pkgs: cfg: (pkgs.rustChannelOf ({
    channel = "1.34.2";
  } // cfg)).rust;
in
{
  id = "rust";
  desc = "software for working with the programming language Rust";
  modules = [
    ./global
    ./cargo-plugins.nix
  ];
  sw = p: with p; ([
    (Rust p {})

    ((Rust p {}).override {
      extensions = [
        "clippy-preview"
      ];
    })

    rls

    rustfmt
  ]);
}
