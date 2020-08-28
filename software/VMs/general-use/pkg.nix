{ config, lib, pkgs, ... }: {

  networking.hostName = "general-use-VM";

  c74d-params.id =
    "10d5451a6f96a6b6178bcac31b672eeacdfc74cf4867f247ca2c789e1103cf88";

  c74d-params.system-state-version = config.system.stateVersion;

  c74d-params.secure = false;

  c74d-params.X11.enable = true;

  nixpkgs.config.allowUnfree = true;

}
