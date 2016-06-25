{ config, lib, pkgs, ... }: {

  nix = {
    gc = {
      automatic = true;
    };
    useSandbox = true;
    extraOptions = ''
      auto-optimise-store = true
      build-fallback = false
    '';
  };

}
