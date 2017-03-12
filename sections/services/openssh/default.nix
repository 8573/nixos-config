{ config, lib, pkgs, ... }: {

  services.openssh = {
    enable = lib.elem config.c74d-params.installation-type [
      "server" "desktop"
    ];

    # Note: `startWhenNeeded` may result in tmux being killed on logout,
    # apparently independent of KillUserProcesses.
    startWhenNeeded = false;

    # I can't seem to get past my home router to this computer via IPv4, and
    # yet the fail2ban log fills with bots and skiddies who seem to manage it
    # just fine, so I give up on having SSHd listen on IPv4.
    listenAddresses =
      lib.mkIf (config.c74d-params.installation-type == "desktop") [
        { addr = "[::]";
          port = 22; }
      ];
  };

}
