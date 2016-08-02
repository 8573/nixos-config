{ config, lib, pkgs, ... }: let

  cfg = config.programs.vim;

in {

  options.programs.vim = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Whether to globally install Vim.
      '';
    };

    plugins = lib.mkOption {
      type = with lib.types; listOf (either str attrs);
      default = [];
      description = ''
        Vim plug-ins to globally install with VAM.
      '';
    };

    vimrc.file = lib.mkOption {
      type = with lib.types; nullOr path;
      default = null;
      description = ''
        A file to use as the system vimrc script.
      '';
    };

    vimrc.text = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = ''
        Extra text to append to the system vimrc script.
      '';
    };

    package = lib.mkOption {
      type = lib.types.package;
      description = ''
        This configuration option isn't meant to be changed; rather, the Vim
        derivation configured by this module is stored in this option. If this
        module is not enabled, a vanilla Vim derivation is stored in this
        option instead, meaning that this option can be relied upon to hold a
        Vim derivation.
      '';
    };

    default-package = lib.mkOption {
      type = lib.types.package;
      description = ''
        The "vanilla Vim derivation" that might be stored in
        `programs.vim.package`. This will be the `vim` package, or the
        `vim_configurable` package if that is in `environment.systemPackages`
        and `vim` is not.
      '';
    };
  };

  config.programs.vim.default-package =
    let
      default = pkgs.vim;
      vims = [
        pkgs.vim
        pkgs.vim_configurable
      ];
    in
      lib.findSingle
        (lib.flip lib.elem vims)
        default
        default
        config.environment.systemPackages;


  config.programs.vim.package =
    if !cfg.enable then
      cfg.default-package
    else
      pkgs.vim_configurable.customize {
        name = "vim";

        vimrcConfig.customRC = ''
          ${lib.optionalString (cfg.vimrc.file != null) ''
            source ${cfg.vimrc.file}
          ''}

          ${cfg.vimrc.text}
        '';

        vimrcConfig.vam.knownPlugins = pkgs.vimPlugins;

        vimrcConfig.vam.pluginDictionaries = map (plugin:
          if lib.isString plugin then
            { name = plugin; }
          else if lib.isAttrs plugin then
            plugin
          else
            throw "this should never happen"
        ) cfg.plugins;
      };

  config.environment.systemPackages = lib.mkIf cfg.enable [
    cfg.package
  ];

}
