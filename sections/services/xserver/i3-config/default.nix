{ config, lib, pkgs, ... } @ args: let

  cfg = config.c74d-params.i3;

  c74d-pkgs = config.lib.c74d.pkgs;

  mod-key =
    if cfg.use-Super-key then
      "Mod4"
    else
      "Mod1";

  font-size = toString cfg.font-size;

  i3status = import ./i3status-rust-wrapped.nix args;
  i3status-cfg-file = import ./i3status-rust-cfg.nix args;

  sh = "${pkgs.bash}/bin/sh";
  chromium = "${c74d-pkgs.wrapped.chromium}/bin/chromium";
  xclip = "${pkgs.xclip}/bin/xclip";

  Chromium-open-binding =
    lib.optionalString cfg.bindings.open-in-browser.enable ''
      # Open contents of default X selection buffer in Chromium
      bindsym $mod+u exec '${sh}' -c '"${chromium}" "$("${xclip}" -o)" >/dev/null'
    '';

  brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";

  brightness-level-calc = ./brightness-level-calc.awk;

  brightnessctl-exp =
    let
      pkg = pkgs.writeShellScriptBin "brightnessctl-exponential" ''
        set -euo pipefail
        old="$('${brightnessctl}' -mc backlight get)"
        max="$('${brightnessctl}' -mc backlight max)"
        case "$1" in
          (dec) delta=-1;;
          (inc) delta=1;;
        esac
        new="$(gawk \
          -v mapped_delta="$delta" \
          -v mapped_max='${toString cfg.media-key-levels}' \
          -v raw_old="$old" \
          -v raw_max="$max" \
          --posix --lint=fatal -f '${brightness-level-calc}')"
        exec '${brightnessctl}' -qc backlight set "$new"
      '';
    in
      "${pkg}/bin/brightnessctl-exponential";

  brightness-control-bindings =
    lib.optionalString cfg.bindings.display-brightness.enable ''
      # Control display brightness
      bindsym XF86MonBrightnessDown exec '${brightnessctl-exp}' dec
      bindsym XF86MonBrightnessUp exec '${brightnessctl-exp}' inc
    '';

  amixer = "${pkgs.alsaUtils}/bin/amixer";

  audio-volume-control-bindings =
    lib.optionalString cfg.bindings.audio-volume.enable ''
      # Key-bindings for audio output control
      bindsym XF86AudioRaiseVolume exec '${amixer}' -Mq set Master 5%+ unmute
      bindsym XF86AudioLowerVolume exec '${amixer}' -Mq set Master 5%- unmute
      bindsym XF86AudioMute exec '${amixer}' -Mq set Master toggle
    '';

  systemctl = "/run/current-system/sw/bin/systemctl";

  Redshift-toggle = op: "exec ${systemctl} --user ${op} redshift.service";

  Redshift-toggle-bindings =
    lib.optionalString cfg.bindings.toggle-Redshift.enable ''
      # Toggle Redshift
      bindsym $mod+XF86MonBrightnessDown ${Redshift-toggle "start"}
      bindsym $mod+XF86MonBrightnessUp ${Redshift-toggle "stop"}
    '';

  screencap-dir = cfg.bindings.screen-capture.output-directory;

  mkdir = "${pkgs.coreutils-full}/bin/mkdir";
  date = "${pkgs.coreutils-full}/bin/date";
  im-import = "${pkgs.imagemagick.out}/bin/import";

  screencap-cmd = file-ext: ''
    exec '${sh}' -c '"${mkdir}" -p "${screencap-dir}" && "${im-import}" -window root "${screencap-dir}/screencap-$("${date}" "+%F-%T-%N").${file-ext}"'
  '';

  screencap-bindings =
    lib.optionalString cfg.bindings.screen-capture.enable ''
      # Screen-capture
      bindsym $mod+Print ${screencap-cmd "jpg"}
      bindsym $mod+Shift+Print ${screencap-cmd "png"}
    '';

  i3-cfg-file = pkgs.runCommand "i3-config" {} ''
    sed_script="$(mktemp --tmpdir)"

    cat >> "$sed_script" <<'I3CONFIGSED'
      0,/^$/s/^$/\nset $mod ${mod-key}\n/;
      s/\<Mod1\>/$mod/g;
      s/\<\(monospace\) 8\>/\1 ${font-size}/g;
      s|^\(\s*status_command \(/.*/\)\?\)i3status$|\1'${i3status}/bin/i3status-rs' '${i3status-cfg-file}'|;
      s/^exec i3-config-wizard\>/#&/;
      # Don't start anything on start-up by default.
      s/^exec\>/#&/;
      # Disable the executable-name-based dmenu_run...
      s/^bindsym $mod+d exec dmenu_run/#&/;
      # ...in favor of the .desktop-file-based i3-dmenu-desktop.
      s/^# \(bindsym $mod+d exec \(-[^ ]\+ \+\)*\<i3-dmenu-desktop\>\)/\1/;
      # Bind i3 programs by their Nix store paths.
      s|^\(bindsym *[^ ]\+ *exec *\(-[^ ]\+ \+\)*\)\(\<i3-[^ ]\+\>\)|\1'${pkgs.i3}/bin/\3'|;
      # Disable i3's default bindings of programs by their unqualified
      # filenames --- the filenames might not be in PATH, and the bindings
      # might clash with mine.
      s/^bindsym *[^ ]\+ *exec *\(-[^ ]\+ \+\)*[a-zA-Z0-9]/#&/;
    I3CONFIGSED

    sed -f "$sed_script" '${pkgs.i3}/etc/i3/config' > "$out"

    rm "$sed_script"

    echo >> "$out"

    cat >> "$out" <<'I3CONFIG'
    exec i3-msg layout ${cfg.default-layout}

    ${Chromium-open-binding}
    ${brightness-control-bindings}
    ${audio-volume-control-bindings}
    ${Redshift-toggle-bindings}
    ${screencap-bindings}

    ${cfg.extraConfig}
    I3CONFIG
  '';

in {

  hardware.brightnessctl = lib.mkIf cfg.bindings.display-brightness.enable {
    enable = true;
  };

  services.xserver.windowManager.i3.configFile =
    lib.mkIf config.services.xserver.windowManager.i3.enable i3-cfg-file;

}
