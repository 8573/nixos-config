{ config, lib, pkgs, ... }: let

  if-personal = lib.mkIf config.c74d-params.personal;

  inherit (config.lib.c74d.pkgs.c74d) zsh-config;

in {

  environment.etc = if-personal {
    "zshrc.local".source = "${zsh-config}/zshrc";
    "zshrc.local.zwc".source = "${zsh-config}/zshrc.zwc";
    # Using the compiled (`.zwc`) version of the `zshrc` script seems to save
    # around 10-15 centiseconds for me, but alas Nix doesn't seem to permit
    # files to be exempted from having their timestamps scrubbed, and zsh only
    # looks for `.zwc` scripts *newer* than the respective source scripts, so
    # the compiled version of the `zshrc` script is not used.

    "zshenv".text = lib.mkBefore ''
      # Disable this function, because a far more extensive personal
      # configuration is installed system-wide.
      function zsh-newuser-install {}
    '';
  };

  # These would normally be set by the `programs.zsh` module, but aren't
  # because I disable its managing of zsh completion facilities below, so I'm
  # obliged to set these options myself for fully functional completion.
  environment.systemPackages = [
    pkgs.nix-zsh-completions
  ];
  environment.pathsToLink = [
    "/share/zsh"
  ];

  programs.zsh = if-personal {

    # Disable this because zsh-config manages the completion system.
    enableCompletion = false;

    # Discard the default value because zsh-config manages prompts.
    promptInit = "";

    # Discard the default value because zsh-config manages aliases.
    shellAliases = {};

  };

}
