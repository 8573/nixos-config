{ config, lib, pkgs, ... }: {

  programs.ssh = {
    extraConfig = ''
      Host github.com
        # GitHub closes the idle connections, making SSH print non-sequitur
        # messages in the terminal.
        ControlMaster no

      Host *
        ControlMaster auto
        ControlPath ~/.ssh/mux-socket-%C
        ControlPersist 10m
        VerifyHostKeyDNS ask
        VisualHostKey yes
    '';
  };

}
