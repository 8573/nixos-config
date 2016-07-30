{ config, lib, pkgs, ... }: let

  std = config.environment.shellAliases;

in {

  programs.bash.shellAliases = std // {
    "ls" = "${std.ls} --classify --si --time-style=posix-long-iso";
    "l" = "ls --format=long --almost-all";
    "cp" = "cp --interactive";
    "mv" = "mv --interactive";
    "rm" = "rm --interactive=once";
  };

}
