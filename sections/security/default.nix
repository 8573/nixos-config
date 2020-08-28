{ config, lib, pkgs, ... }: {

  security = {
    # [2020-06-16] I notice that the hardened profile disables
    # hyper-threading. simukis seems to approve (see #rust-offtopic), I don't
    # notice a performance degradation, and it looks as though this setting is
    # indeed mitigating some CPU vulnerabilities that I have, so I let it be.
    #allowSimultaneousMultithreading = ...;

    # [2018-10-18] Nix sandboxing requires user namespaces.
    allowUserNamespaces = true;

    apparmor = {
      enable = true;
    };

    chromiumSuidSandbox = {
      enable = {
        desktop = true;
        laptop = true;
        server = false;
        VM = false;
      }.${config.c74d-params.installation-type};
    };

    hideProcessInformation = true;

    sudo = {
      enable = false;
    };
  };

}
