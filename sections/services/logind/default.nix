{ config, lib, pkgs, ... }: {

  services.logind = {
    extraConfig = ''
      # Don't break tmux.
      KillUserProcesses=no
    '';
  };

}
