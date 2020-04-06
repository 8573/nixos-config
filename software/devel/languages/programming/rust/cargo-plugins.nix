{
  id = "cargo-plugins";
  desc = "plugins for the Rust build tool Cargo";
  ignore-broken-pkgs = true;
  sw = p: with p; ([
    cargo-audit
    cargo-fuzz
    cargo-geiger
    cargo-release
    cargo-tree
  ]);
}
