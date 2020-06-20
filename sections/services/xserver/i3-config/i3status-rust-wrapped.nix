{ config, lib, pkgs, ... }: let

  src = pkgs.i3status-rust;

  PATH-prefix = lib.makeBinPath (with pkgs; [
    lm_sensors
  ]);

in pkgs.writeShellScriptBin "i3status-rs" ''
  export PATH="${PATH-prefix}:$PATH"
  exec '${src}/bin/i3status-rs' "$@"
''
