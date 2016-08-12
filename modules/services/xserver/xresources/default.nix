{ config, lib, pkgs, ... }: let

  resources = config.services.xserver.xresources;

  resources-file = pkgs.writeText "Xresources" (
    lib.concatStringsSep "\n" (
      lib.mapAttrsFlatten (k: v: "${k}: ${v}") resources
    ) + "\n"
  );

in {

  options.services.xserver.xresources = lib.mkOption {
    type = lib.types.attrsOf lib.types.str;
    default = {};
    example = {
      "XTerm*background" = "rgb:10/10/10";
      "XTerm*foreground" = "rgb:C0/C0/C0";
    };
    description = ''
      X resources to set system-wide.
    '';
  };

  # `sessionCommands` run after `~/.Xresources` is loaded, so this will
  # override that, but then I'd not use that file, in favor of setting X
  # resources via this NixOS module.
  config.services.xserver.displayManager.sessionCommands =
    lib.mkIf config.services.xserver.enable ''
      '${pkgs.xorg.xrdb}/bin/xrdb' -merge '${resources-file}'
    '';
}
