{ config, lib, pkgs, ... }: let

  src = pkgs.i3status-rust;

  PATH-prefix = lib.makeBinPath (with pkgs; [
    lm_sensors
  ]);

  coreutil = x: "${pkgs.coreutils-full}/bin/${x}";

  gawk = "${pkgs.gawk}/bin/gawk";

  cfg-file-name =
    ''$(builtin printf '%s' "$('${coreutil "id"}' -u)" |
        '${coreutil "sha256sum"}' |
        '${gawk}' '{print $1}').toml'';

in pkgs.writeShellScriptBin "i3status-rs" ''
  export PATH="${PATH-prefix}:$PATH"
  exec '${src}/bin/i3status-rs' "$1/${cfg-file-name}"
''
