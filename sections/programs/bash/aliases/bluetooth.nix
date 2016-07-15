{ config, lib, pkgs, ... }: {

  programs.bash.shellAliases = lib.mkIf (
    config.c74d-params.personal && config.hardware.bluetooth.enable
  ) {
    # TODO: Once <https://github.com/NixOS/nixpkgs/issues/16973> is fixed,
    # change these aliases to use lower-power quotes.
    "bt-on" = ''bluetoothctl <<<"power on"'';
    "bt-off" = ''bluetoothctl <<<"power off"'';
  };

}
