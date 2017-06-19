{ config, lib, pkgs, ... }: let

  cfg = config.services.tmux;

  TMUX_TMPDIR = config.environment.variables.TMUX_TMPDIR;

in {

  options.services.tmux = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Whether to automatically start a tmux server for each logged-in user
        account. If this is enabled, setting `programs.tmux.enable = true` is
        recommended, though not required.
      '';
    };
  };

  config = {
    systemd.user.services.tmux = lib.mkIf cfg.enable {
      description = "tmux Server";

      # Don't wipe the users' tmux sessions on each configuration switch.
      restartIfChanged = false;

      script = ''
        ${lib.optionalString
          (lib.isString TMUX_TMPDIR && TMUX_TMPDIR != "") ''
            export TMUX_TMPDIR="${TMUX_TMPDIR}"
          ''}
        exec ${pkgs.tmux}/bin/tmux new-session -d -c '%h'
      '';

      serviceConfig = {
        Type = "forking";
      };

      wantedBy = [
        "default.target"
      ];
    };
  };

}
