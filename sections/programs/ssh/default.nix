{ config, lib, pkgs, ... }: {

  programs.ssh = {
    startAgent = {
      desktop = true;
      laptop = true;
      server = false;
      VM = false;
    }.${config.c74d-params.installation-type};

    extraConfig = ''
      Host github.com
        # GitHub closes the idle connections, making SSH print non-sequitur
        # messages in the terminal.
        ControlMaster no

      Host *
        ControlMaster auto
        ControlPath ~/.ssh/mux-socket-%C
        ControlPersist 10m
        HashKnownHosts yes
        VerifyHostKeyDNS ask
        VisualHostKey yes
    '';
  };

}
