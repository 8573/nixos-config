{ config, lib, pkgs, ... }: let

  cfg = config.programs.emacs;

  utils = rec {
  };

  emacs-configured = cfg.default-package;

in {

  options.programs.emacs = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Whether to install GNU Emacs globally
      '';
    };

    default-editor = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Whether to make GNU Emacs the default EDITOR
      '';
    };

    daemon = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Whether to run the GNU Emacs daemon for all(?) users (this has no
        effect if <varname>programs.emacs.enable=false</varname>)
      '';
    };

    package = lib.mkOption {
      type = lib.types.package;
      description = ''
        This configuration option isn't meant to be changed; rather, the Emacs
        derivation configured by this module is stored in this option. If this
        module is not enabled, a vanilla Emacs derivation is stored in this
        option instead, meaning that this option can be assumed to hold an
        Emacs derivation.
      '';
    };

    default-package = lib.mkOption {
      type = lib.types.package;
      description = ''
        This is the "vanilla Emacs derivation" that might be stored in
        `programs.emacs.package`.
      '';
    };
  };

  config.programs.emacs.default-package =
    if config.environment.noXlibs then
      pkgs.emacs-nox
    else
      pkgs.emacs;

  config.programs.emacs.package =
    if !cfg.enable then
      cfg.default-package
    else
      emacs-configured;

  config.environment.systemPackages = lib.mkIf cfg.enable [
    cfg.package
  ];

  config.services.emacs = lib.mkIf cfg.enable {
    enable = cfg.daemon;
    install = true;
    package = cfg.package;
    defaultEditor = cfg.default-editor;
  };

  config.lib.c74d.emacs.utils = utils;

}
