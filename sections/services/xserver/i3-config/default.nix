{ config, lib, pkgs, ... } @ args: let

  cfg = config.c74d-params.i3;

  mod-key =
    if cfg.use-Super-key then
      "Mod4"
    else
      "Mod1";

  font-size = toString cfg.font-size;

  i3status-cfg-file = import ./i3status.nix args;

  sh = "${pkgs.bash}/bin/sh";
  chromium = "${pkgs.chromium}/bin/chromium";
  xclip = "${pkgs.xclip}/bin/xclip";

  Chromium-open-binding =
    lib.optionalString cfg.bindings.open-in-browser.enable ''
      # Open contents of default X selection buffer in Chromium
      bindsym $mod+u exec '${sh}' -c '"${chromium}" "$("${xclip}" -o)" >/dev/null'
    '';

  xbacklight = "${pkgs.xorg.xbacklight}/bin/xbacklight";

  brightness-control-bindings =
    lib.optionalString cfg.bindings.display-brightness.enable ''
      # Control display brightness
      bindsym XF86MonBrightnessDown exec '${xbacklight}' - 1
      bindsym XF86MonBrightnessUp exec '${xbacklight}' + 1
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

  mkdir = "${pkgs.coreutils}/bin/mkdir";
  date = "${pkgs.coreutils}/bin/date";
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
    sed '
        0,/^$/s/^$/\nset $mod ${mod-key}\n/;
        s/\<Mod1\>/$mod/g;
        s/\<\(monospace\) 8\>/\1 ${font-size}/g;
        s|^\s*status_command /.*/i3status$|& -c '${i3status-cfg-file}'|;
        s/^exec i3-config-wizard\>/#&/;
      ' '${pkgs.i3}/etc/i3/config' > "$out"

    echo >> "$out"

    cat >> "$out" <<'I3CONFIG'
    exec i3-msg layout ${cfg.default-layout}

    ${Chromium-open-binding}
    ${brightness-control-bindings}
    ${Redshift-toggle-bindings}
    ${screencap-bindings}

    ${cfg.extraConfig}
    I3CONFIG
  '';

in {

  services.xserver.windowManager.i3.configFile =
    lib.mkIf config.services.xserver.windowManager.i3.enable i3-cfg-file;

}
