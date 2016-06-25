{ config, lib, pkgs, ... }: {

  # Prevent Wi-Fi from being significantly slowed when Bluetooth is on.
  boot.extraModprobeConfig = ''
    options iwlwifi bt_coex_active=N
  '';

  boot.loader = {
    timeout = 3;
  };

  environment.systemPackages = (with pkgs; [
  ] ++ lib.optionals (!config.environment.noXlibs) [
    xorg.xbacklight
    xorg.xev
  ]);

  fileSystems."/" = {
    device = "zpool-b42d3-0-1/b42d3/nixos";
    fsType = "zfs";
    options = ["noatime" "nodiratime" "suid"];
  };

  fileSystems."/home" = {
    device = "zpool-b42d3-0-1/b42d3/users";
    fsType = "zfs";
    options = ["noatime" "nodiratime" "nosuid"];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/185A-2ABB";
    fsType = "vfat";
    options = ["noatime" "nodiratime" "nosuid" "utf8" "tz=UTC"];
  };

  hardware.bluetooth = {
    enable = true;
  };

  nix = {
    buildCores = 4;
    maxJobs = 4;
  };

  powerManagement.enable = false;

  services.redshift = {
    enable = !config.environment.noXlibs;
    # City
    latitude = "34";
    longitude = "-118";
    # Conf-US-CO-GE
    #latitude = "39";
    #longitude = "-105";
    # Conf-US-NC-Gy
    #latitude = "36";
    #longitude = "-80";
  };

  services.xserver = {
    displayManager.slim = {
      enable = config.services.xserver.enable;
      autoLogin = true;
      defaultUser = "c74d";
    };
    multitouch = {
      # `multitouch` overrides `synaptics` and is less configurable.
      enable = false;
      ignorePalm = true;
    };
    synaptics = {
      enable = true;
      accelFactor = "0.0625";
      /*additionalOptions = ''
        Option "HorizScrollDelta" "256"
        Option "VertScrollDelta" "256"
      '';*/
      maxSpeed = "1.5";
      minSpeed = "0.25";
      palmDetect = true;
      twoFingerScroll = true;
      #vertEdgeScroll = false;
    };
    windowManager = {
      default = "i3";
      i3.enable = true;
    };
  };

  sound.extraConfig = ''
    defaults.pcm.!card 1
  '';

  swapDevices = [
    { device = "/dev/disk/by-partlabel/Linux-swap-partition-for-b42d3"; }
  ];

}
