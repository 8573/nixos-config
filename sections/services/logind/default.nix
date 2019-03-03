{ config, lib, pkgs, ... }: {

  services.logind = {
    extraConfig = ''
      # For ZFS's sake, disable automatic lid-close/open suspend/resume.
      HandleLidSwitch=ignore
      HandleLidSwitchDocked=ignore
      HandleLidSwitchExternalPower=ignore
      HandleSuspendKey=ignore
      HandleHibernateKey=ignore
      # Don't break tmux.
      KillUserProcesses=no
    '';
  };

}
