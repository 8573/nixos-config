{ config, lib, pkgs, ... }: let

  if-personal = lib.mkIf config.c74d-params.personal;

  zsh-config = config.lib.c74d.call-pkg "own/zsh-config" {};

in {

  environment.etc = if-personal {
    "zshrc.local".source = "${zsh-config}/zshrc";
    "zshrc.local.zwc".source = "${zsh-config}/zshrc.zwc";
    # Using the compiled (`.zwc`) version of the `zshrc` script seems to save
    # around 10-15 centiseconds for me, but alas Nix doesn't seem to permit
    # files to be exempted from having their timestamps scrubbed, and zsh only
    # looks for `.zwc` scripts *newer* than the respective source scripts, so
    # the compiled version of the `zshrc` script is not used.
  };

  programs.zsh = if-personal {

    # Disable this because zsh-config manages the completion system.
    enableCompletion = false;

    # Discard the default value because zsh-config manages prompts.
    promptInit = "";

    shellInit = ''
      # Disable this function, because a far more extensive personal
      # configuration is installed system-wide.
      function zsh-newuser-install {}
    '';

    # Discard the default value because zsh-config manages aliases.
    shellAliases = {};

  };

}
