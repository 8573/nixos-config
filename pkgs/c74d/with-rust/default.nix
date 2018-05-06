{ writeText, writeShellScriptBin, nix, nixpkgs-mozilla }:

writeShellScriptBin "with-rust" ''
  exec '${nix}/bin/nix-shell' \
    ${writeText "rust-env.nix" ''
      with import <nixpkgs> {
        overlays = [
          (import "${nixpkgs-mozilla}/rust-overlay.nix")
        ];
      };

      stdenv.mkDerivation {
        name = "rust-env";

        nativeBuildInputs = [
          clang
          rustChannels.stable.rust
          rustfmt
        ];
      }
    ''} \
    "$@"
''
