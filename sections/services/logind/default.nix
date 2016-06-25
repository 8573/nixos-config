{ config, lib, pkgs, ... }: {

  services.logind = {
    extraConfig = ''
      # For ZFS's sake, disable automatic lid-close/open suspend/resume.
      HandleLidSwitch=ignore
      # Don't break tmux.
      KillUserProcesses=no
    '';
  };

}
