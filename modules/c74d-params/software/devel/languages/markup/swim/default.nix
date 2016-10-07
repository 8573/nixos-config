{ config, lib, pkgs, ... }: {

  options.c74d-params.software.devel.languages.markup.swim.enable =
    lib.mkOption {
      type = lib.types.bool;
      default = config.c74d-params.software.devel.languages.markup.enable;
    };

  config.environment.systemPackages = lib.mkIf
    config.c74d-params.software.devel.languages.markup.swim.enable
    ((with config.lib.c74d.pkgs; [
      perlPackages.Swim
    ]));

}
