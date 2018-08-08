{ config, lib, pkgs, ... }: {

  services.dbus = {
    packages =
      # TODO: Delete the following line should it become implied by
      # `programs.dconf.enable = true`.
      lib.optional (config.programs.dconf.enable) pkgs.gnome3.dconf;
  };

}
