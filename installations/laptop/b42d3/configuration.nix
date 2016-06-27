{ config, lib, pkgs, ... }: {

  c74d-params = {
    id = "b42d35f1";
    installation-type = "laptop";
    secure = false;

    hw.cores = 4;
  };

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

  powerManagement.enable = false;

  services.redshift = {
    enable = !config.environment.noXlibs;
  };

  services.xserver = {
    displayManager.slim = {
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
  };

  sound.extraConfig = ''
    defaults.pcm.!card 1
  '';

  swapDevices = [
    { device = "/dev/disk/by-partlabel/Linux-swap-partition-for-b42d3"; }
  ];

}
