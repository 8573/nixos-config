{ writeText, writeShellScriptBin, nix, clang, rustChannels, rustfmt }:

writeShellScriptBin "with-rust" ''
  exec '${nix}/bin/nix-shell' \
    ${writeText "rust-env.nix" ''
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
