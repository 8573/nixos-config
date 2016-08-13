{ config, lib, pkgs, ... }: let

  mk-enable-opt-default-on = description:
    lib.mkEnableOption description // {
      default = true;
      example = false;
    };

in {

  options.c74d-params.i3 = {
    use-Super-key = lib.mkOption {
      type = lib.types.bool;
      default = true;
      example = false;
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
      default = 11;
      example = 8;
      description = ''
        The font size to be used for text in i3's window title bars, status
        bar, etc.
      '';
    };

    bindings.open-in-browser.enable = mk-enable-opt-default-on ''
      a key-binding, of Modifier+U, for opening the content of the default X
      selection buffer in a Web browser
    '';

    bindings.display-brightness.enable = mk-enable-opt-default-on ''
      key-bindings, of the relevant media-keys, for increasing and decreasing
      the brightness of the display backlight
    '';

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
      default = "~/screen-captures";
      example = "~/Pictures/Screenshots";
      description = ''
        The path of a directory (which need not exist) in which to save
        screen-captures taken with these key-bindings.
      '';
    };
  };

}
