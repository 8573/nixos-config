{ config, lib, pkgs, ... }: let

  Rust-env = pkgs.buildEnv {
    name = "c74d-Rust-env";
    paths = with pkgs; [
      cargo-audit
      cargo-fuzz
      cargo-geiger
      cargo-release
      cargo-tree
      clippy
      rls
      rust-analyzer
      rustfmt
      rustracer
      rustracerd
    ];
  };

in lib.mkIf
  config.c74d-params.software.devel.languages.programming.rust.enable
{

  environment.variables = {
    "RUST_SRC_PATH" = "${pkgs.rustPlatform.rustcSrc}";
    "c74d_NixOS_Rust_env_path" = "${Rust-env}";
  };

}
