{ config, lib, pkgs, ... }: {

  i18n.inputMethod = lib.mkIf (
    config.c74d-params.X11.enable
    && !config.c74d-params.minimal
  ) {
    enabled = "fcitx";

    fcitx = {
      engines = (with pkgs.fcitx-engines; [
        anthy
        hangul
        # NOTE: Use the "Pinyin" input method, not the "Pinyin (libPinyin)"
        # one (both are provided by `libpinyin`), because the latter seems
        # crashy.
        libpinyin
        table-other
      ]);
    };

    ibus = {
      engines = (with pkgs.ibus-engines; [
        hangul
        libpinyin
        table
        table-others
        uniemoji
      ]);
    };
  };

  # Start the IBus daemon with each X11 session. I suspect that a desktop
  # environment would do this for me, hence this being restricted to i3
  # environments.
  services.xserver.displayManager.sessionCommands =
    let
      conditions =
        config.i18n.inputMethod.enabled == "ibus"
        && config.c74d-params.i3.enable;
      autostart-ibus-daemon-pkgs =
        lib.filter
          (lib.hasSuffix "-autostart-ibus-daemon")
          config.environment.systemPackages;
      autostart-ibus-daemon-pkg =
        assert lib.length autostart-ibus-daemon-pkgs == 1;
        lib.head autostart-ibus-daemon-pkgs;
      autostart-ibus-daemon-file =
        "${autostart-ibus-daemon-pkg}/etc/xdg/autostart/ibus-daemon.desktop";
      cmd = pkgs.runCommand "autostart-ibus-daemon-extracted" {} ''
        sed -n < "${autostart-ibus-daemon-file}" > "$out" '
          /^Exec=/ {
            s/^Exec=/exec /;
            p;
          }
        '
        chmod +x "$out"
      '';
    in
      lib.mkIf conditions ''
        "${cmd}" &
      '';

}
