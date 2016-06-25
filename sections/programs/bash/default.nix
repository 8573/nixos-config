{ config, lib, pkgs, ... }: {

  programs.bash = {
    enableCompletion = true;

    interactiveShellInit = ''
      # See also <https://github.com/mrzool/bash-sensible/raw/d252937b073de6afbf5ac0ed3d7a9ae015ec9fab/sensible.bash>

      set -o noclobber

      shopt -s checkjobs
      shopt -s checkwinsize
      shopt -s cmdhist
      shopt -s dirspell
      shopt -s extglob
      shopt -s globstar
      shopt -s histappend
      shopt -s histverify
      shopt -s no_empty_cmd_completion

      bind 'set completion-ignore-case on'
      bind 'set completion-map-case on'
      bind '"\e[A": history-search-backward'
      bind '"\e[B": history-search-forward'
      bind '"\e[C": forward-char'
      bind '"\e[D": backward-char'

      HISTCONTROL='erasedups:ignoreboth'
      export HISTIGNORE='exit:ls:l:ll:bg:fg:history:clear'
      HISTSIZE=65536
      HISTTIMEFORMAT='%F %T '
    '';

    shellAliases = let std = config.environment.shellAliases; in std // {
      "ls" = "${std.ls} --classify --si --time-style=posix-long-iso";
      "l" = "ls --format=long --almost-all";
      "cp" = "cp --interactive";
      "mv" = "mv --interactive";
      "rm" = "rm --interactive=once";
    };
  };

}
