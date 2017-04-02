{ config, lib, pkgs, ... }: let

  cfg = config.programs.vim;

  utils = rec {
    plugin-pkg = { name, version, src }: {
      inherit name;
      drv = pkgs.vimUtils.buildVimPluginFrom2Nix {
        name = "${name}-${version}";
        inherit src;
      };
    };

    plugin-from-Git-host = fetch-fn: args: plugin-pkg {
      name = args.repo;
      version = args.rev;
      src = fetch-fn args;
    };

    plugin-from-GitHub = plugin-from-Git-host pkgs.fetchFromGitHub;

    plugin-from-GitLab = plugin-from-Git-host pkgs.fetchFromGitLab;

    plugin-from-Bitbucket = plugin-from-Git-host pkgs.fetchFromBitbucket;
  };

  extra-plugins =
    lib.listToAttrs
      (map
        (plugin: lib.nameValuePair plugin.name plugin.drv)
        (lib.filter (plugin: plugin ? drv) cfg.plugins));

  vim-customize-wrapper =
    pkgs.vim_configurable.customize {
      name = "vim-customize-wrapper";

      vimrcConfig.customRC = ''
        function s:try_source(files)
          for l:f in a:files
            let l:f = fnamemodify(l:f, ':p')

            if filereadable(l:f)
              execute 'source' l:f
            endif
          endfor
        endfunction

        ${lib.optionalString cfg.vimrc.useSystemVimrc ''
          call s:try_source(['/etc/vim/vimrc', '/etc/vimrc'])
        ''}

        ${lib.optionalString (cfg.vimrc.file != null) ''
          source ${cfg.vimrc.file}
        ''}

        ${lib.optionalString cfg.vimrc.useUserVimrc ''
          call s:try_source(['~/.vim/vimrc', '~/.vimrc'])
        ''}

        ${lib.optionalString (cfg.vimrc.text != "") ''
          source ${builtins.toFile "vimrc-extra" cfg.vimrc.text}
        ''}
      '';

      vimrcConfig.vam.knownPlugins = extra-plugins // pkgs.vimPlugins;

      vimrcConfig.vam.pluginDictionaries = map (plugin:
        if lib.isString plugin then
          { name = plugin; }
        else if lib.isAttrs plugin then
          lib.filterAttrs (k: _: k != "drv") plugin
        else
          throw "this should never happen"
      ) cfg.plugins;
    };

  # By default, the `customize`'d `vim_configurable` exposes only a wrapper
  # script for invoking Vim itself, and not the other things that the normal
  # `vim_configurable` exposes, including `gvim`, `view`, `vimdiff`, and
  # man-pages.
  #
  # This derivation provides an installation of Vim that exposes all those
  # things, behind adapted copies of the `customize` derivation's wrapper
  # script where applicable.
  vim-configured = pkgs.runCommand
    "vim-configured-${pkgs.vim_configurable.version}"
    { src = pkgs.vim_configurable.override {
        python = pkgs.python3;
      };

      wrapper_script="${vim-customize-wrapper}/bin/vim-customize-wrapper";

      # The man-pages will have already been compressed; attempting to compress
      # them again fails.
      dontGzipMan = true;

      dontStrip = true; }
    ''
      mkdir --parents "$out/bin"

      for f in "$src"/bin/{,e,r,g,rg}{vim,view,vimdiff}; do
        f_out="$out/bin/$(basename "$f")"
        if [[ -e "$f" ]]; then
          sed -e "s|^exec [^ ]* |exec '$f' |" "$wrapper_script" > "$f_out"
          chmod +x "$f_out"
        fi
      done

      for f in "$src"/bin/*; do
        f_out="$out/bin/$(basename "$f")"
        if [[ ! -e "$f_out" ]]; then
          ln -s "$f" "$f_out"
        fi
      done

      ln -s "$src/share" "$out"
    '';

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
        A file to use as this module's Vim installation's vimrc
        (initialization) script.
      '';
    };

    vimrc.text = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = ''
        Extra text to append to this module's Vim installation's vimrc
        (initialization) script.
      '';
    };

    vimrc.useSystemVimrc = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = ''
        Whether to source the system vimrc script (`/etc/vim/vimrc` or
        `/etc/vimrc`), if one exists, from this module's Vim installation's
        vimrc script.
      '';
    };

    vimrc.useUserVimrc = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = ''
        Whether to source the user's vimrc script (`~/.vim/vimrc` or
        `~/.vimrc`), if one exists, from this module's Vim installation's
        vimrc script.
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
    pkgs.vim;

  config.programs.vim.package =
    if !cfg.enable then
      cfg.default-package
    else
      vim-configured;

  config.environment.systemPackages = lib.mkIf cfg.enable [
    cfg.package
  ];

  config.lib.c74d.vim.utils = utils;

}
