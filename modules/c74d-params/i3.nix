{ config, lib, pkgs, ... }: let

  mk-enable-opt-default-on = description:
    lib.mkEnableOption description // {
      default = true;
    };

in {

  imports = [
    ./i3status.nix
  ];

  options.c74d-params.i3 = {
    use-Super-key = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = ''
        Whether to use the Super key (a.k.a. Windows key) as the main
        key-binding modifier key for i3, rather than the default, the Alt key.
      '';
    };

    default-layout = lib.mkOption {
      type = lib.types.str;
      default = "tabbed";
      example = "splith";
      description = ''
        The default window layout.
      '';
    };

    font-size = lib.mkOption {
      type = lib.types.int;
      default = config.c74d-params.X11.font-size;
      example = 8;
      description = ''
        The font size to be used for text in i3's window title bars, status
        bar, etc.
      '';
    };

    media-key-levels = lib.mkOption {
      type = lib.types.int;
      default = 20;
      example = 15;
      description = ''
        This is the number of discrete levels (gradations) that should be
        implemented in quantities controlled by media keys, such as display
        brightness and audio volume; i.e., a press of a media key should
        increase or decrease the relevant quantity by 100%/L, where L is this
        value.
      '';
    };

    bindings.open-in-browser.enable = mk-enable-opt-default-on ''
      a key-binding, of Modifier+U, for opening the content of the default X
      selection buffer in a Web browser
    '';

    bindings.display-brightness.enable = lib.mkEnableOption ''
      key-bindings, of the relevant media-keys, for increasing and decreasing
      the brightness of the display backlight
    '' // {
      # A desktop computer, assuming it has a discrete monitor and keyboard,
      # well may not have functional backlight control keys.
      default = config.c74d-params.installation-type == "laptop";
    };

    bindings.audio-volume.enable = lib.mkEnableOption ''
      key-bindings, of the relevant media-keys, for increasing and decreasing
      the audio output volume, and muting or unmuting the audio output
    '' // {
      default = config.hardware.pulseaudio.enable;
    };

    bindings.toggle-Redshift.enable = mk-enable-opt-default-on ''
      key-bindings, of the display-brightness media-keys modified with the main
      i3 modifier key, for toggling Redshift
    '';

    bindings.screen-capture.enable = mk-enable-opt-default-on ''
      key-bindings (Modifier+PrintScreen for JPEG output and
      Modifier+Shift+PrintScreen for PNG output) for taking screen-captures
    '';

    bindings.screen-capture.output-directory = lib.mkOption {
      type = lib.types.str;
      default = "$HOME/screen-captures";
      example = "$HOME/Pictures/Screenshots";
      description = ''
        The path of a directory (which need not exist) in which to save
        screen-captures taken with these key-bindings.
      '';
    };

    extraConfig = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = ''
        Additional lines to append to the i3 configuration file.
      '';
    };
  };

}
