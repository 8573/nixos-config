{ config, lib, pkgs, ... }:

with lib;
let

  params = config.c74d-params;

  is-hex-string = s:
    let
      hex-digits = [
        "0" "1" "2" "3" "4" "5" "6" "7" "8" "9"
        "a" "b" "c" "d" "e" "f"
        "A" "B" "C" "D" "E" "F"
      ];
      empty-strings =
        genList (const "") (length hex-digits);
      is-all-hex =
        replaceStrings hex-digits empty-strings s == "";
    in
      isString s && is-all-hex;

  hex-string-ty = len: mkOptionType {
    name = "hexadecimal string of length ${toString len} or greater";
    check = s:
      is-hex-string s && stringLength s >= len;
    merge = mergeEqualOption;
  };

  hex-string-exact-len-ty = len: mkOptionType {
    name = "hexadecimal string of length ${toString len}";
    check = s:
      is-hex-string s && stringLength s == len;
    merge = mergeEqualOption;
  };

  mk-id-len-option = len: mkOption {
    type = hex-string-exact-len-ty len;
    default =
      let
        d = substring 0 len config.c74d-params.id;
      in
        if stringLength d == len then
          d
        else
          null;
    description = ''
      A string of ${toString len} hexadecimal digits intended as a unique
      identifier for this installation of NixOS.
    '';
  };

  installation-type-ty = mkOptionType {
    name = "installation type";
    check = s:
      isString s && elem s [
        "server"
        "laptop"
        "desktop"
      ];
    merge = mergeEqualOption;
  };

  mk-env-pkg-options = { id, on-by-default ? false }: {
    ${id} = {
      enable = mkOption {
        type = types.bool;
        default = on-by-default;
        description = ''
          Whether to enable ${id}.
        '';
      };
      install = mkOption {
        type = types.bool;
        default = params.${id}.enable;
        description = ''
          Whether to install (but not necessarily enable) ${id}.
        '';
      };
    };
  };

in {

  options.c74d-params = {

    id = mkOption {
      type = hex-string-ty 8;
      description = ''
        A hexadecimal string intended as a unique identifier for this
        installation of NixOS.
      '';
    };

    id5 = mk-id-len-option 5;

    id8 = mk-id-len-option 8;

    installation-type = mkOption {
      type = installation-type-ty;
      description = ''
        What type of installation this is -- "server", "desktop", or "laptop".
      '';
    };

    secure = mkOption {
      type = types.bool;
    };

    lightweight = mkOption {
      type = types.bool;
      default = false;
    };

    personal = mkOption {
      type = types.bool;
      description = ''
        Whether this installation of NixOS is for my personal use, as opposed
        to being for, e.g., a shell-host server intended to be shared with
        others. Setting this to `true` turns on greater system-wide
        customization of things like Git and text editors (and choice of text
        editors).
      '';
    };

    hw.cores.physical = mkOption {
      type = types.int;
      description = ''
        How many physical CPU cores the system has.
      '';
    };

    hw.cores.virtual = mkOption {
      type = types.int;
      description = ''
        How many virtual CPU cores the system has.
      '';
    };

    grsecurity.enable = mkOption {
      type = types.bool;
      default = params.secure;
    };

    X11.enable = mkOption {
      type = types.bool;
      default = params.installation-type != "server";
    };

    enable-all-firmware = mkOption {
      type = types.bool;
      default = !params.lightweight && params.installation-type != "server";
    };

  } // mk-env-pkg-options {
    id = "i3";
    on-by-default = params.X11.enable && !params.KDE.enable;
  } // mk-env-pkg-options {
    id = "KDE";
  };

}