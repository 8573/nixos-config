{ config, lib, pkgs, ... }: {

  security = {
    # [2018-10-18] Nix sandboxing requires user namespaces.
    allowUserNamespaces = true;

    apparmor = {
      enable = true;
    };

    chromiumSuidSandbox = {
      enable = true;
    };

    hideProcessInformation = true;

    sudo = {
      enable = false;
    };
  };

}
