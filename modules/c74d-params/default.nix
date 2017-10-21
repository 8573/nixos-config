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

  imports = [
    ./software
    ./location.nix
    ./i3.nix
    ./services.nix
  ];

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
      type = types.enum [
        "server"
        "laptop"
        "desktop"
        "VM"
      ];
      description = ''
        What type of installation this is -- "server", "desktop", "laptop", or
        "VM" (a virtual machine hosted by another NixOS installation of mine,
        as which a virtual private server running on someone else's host
        doesn't count).
      '';
    };

    secure = mkOption {
      type = types.bool;
    };

    minimal = mkOption {
      type = types.bool;
      default = ({
        desktop = false;
        laptop = false;
        server = true;
        VM = true;
      }).${params.installation-type};
      description = ''
        Whether this installation is intended to be minimal, such as for a VM
        installation.
      '';
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

    usually-up = mkOption {
      type = types.bool;
      default = ({
        desktop = true;
        laptop = false;
        server = true;
        VM = false;
      }).${params.installation-type};
      description = ''
        Whether this installation is intended to be usually powered on and
        running.
      '';
    };

    usually-on-Internet = mkOption {
      type = types.bool;
      default = ({
        desktop = true;
        laptop = false;
        server = true;
        VM = false;
      }).${params.installation-type};
      description = ''
        Whether this installation is intended to have a persistent,
        low-downtime Internet connection.
      '';
    };

    channel = mkOption {
      type = types.enum [
        "unstable"
        "unstable-small"
        "17.03"
        "17.03-small"
      ];
      default = ({
        desktop = "unstable";
        laptop = "unstable";
        server = "unstable-small";
        VM = params.VM.host.config.c74d-params.channel;
      }).${params.installation-type};
      description = ''
        The nixpkgs channel to use for this installation, with the prefix
        `nixos-` implied.
      '';
    };

    manages-own-store = mkOption {
      type = types.bool;
      default = ({
        desktop = true;
        laptop = true;
        server = true;
        VM = false;
      }).${params.installation-type};
      description = ''
        Whether this installation is intended to manage its own Nix store.
      '';
    };

    system-state-version = mkOption {
      type = types.enum [
        "17.03"
        "16.09"
        "16.03"
      ];
      description = ''
        This option is just used to set the standard option
        `system.stateVersion`. This option exists to necessitate a version to
        be set for each installation, rather than allowing the default value
        to be used.
      '';
    };

    ZFS.enable = mkOption {
      type = types.bool;
      default = ({
        desktop = true;
        laptop = true;
        server = true;
        VM = false;
      }).${params.installation-type};
      description = ''
        Whether to enable ZFS support.
      '';
    };

    VM.host.config = mkOption {
      type = types.attrs;
      description = ''
        The configuration of a NixOS VM's host. Only relevant when the
        `installation-type` is `VM`. Set automatically by the VM-building
        infrastructure.
      '';
    };

    hardware.main-CPU-mfr = mkOption {
      type = types.enum [
        "Intel"
        "AMD"
        "(virtual)"
      ];
      description = ''
        The manufacturer of the system's main CPU(s).
      '';
    };

    hardware.cores.physical = mkOption {
      type = types.int;
      description = ''
        How many physical CPU cores the system has.
      '';
    };

    hardware.cores.virtual = mkOption {
      type = types.int;
      description = ''
        How many virtual CPU cores the system has.
      '';
    };

    hardware.memory.main.gigabytes = mkOption {
      type = types.int;
      description = ''
        How many gigabytes of main memory the system has, rounded down.
      '';
    };

    hardware.memory.swap.gigabytes = mkOption {
      type = types.int;
      description = ''
        How many gigabytes of swap space the system has, rounded down.
      '';
    };

    hardware.battery.present = mkOption {
      type = types.bool;
      default = params.installation-type == "laptop";
      description = ''
        Whether the system has an electric battery that it can use as a
        primary power supply.
      '';
    };

    hardware.Ethernet.present = mkOption {
      type = types.bool;
      description = ''
        Whether the system has Ethernet hardware.
      '';
    };

    hardware.Wi-Fi.present = mkOption {
      type = types.bool;
      description = ''
        Whether the system has Wi-Fi hardware.
      '';
    };

    firmware.type = mkOption {
      type = types.enum [
        "EFI"
        "BIOS"
      ];
      description = ''
        The type of firmware (EFI or BIOS) that this installation has.
      '';
    };

    X11.enable = mkOption {
      type = types.bool;
      default = !params.minimal && lib.elem params.installation-type [
        "desktop"
        "laptop"
      ];
    };

    X11.font-size = mkOption {
      type = types.int;
      default = 11;
      description = ''
        A font size to use by default in X11, for those applications that care
        (e.g., xterm).
      '';
    };

    enable-most-firmware = mkOption {
      type = types.bool;
      default = !params.minimal && lib.elem params.installation-type [
        "desktop"
        "laptop"
      ];
    };

  } // mk-env-pkg-options {
    id = "i3";
    on-by-default = params.X11.enable && !params.KDE.enable;
  } // mk-env-pkg-options {
    id = "KDE";
  };

  config.lib.c74d = {
    auto-build-flag =
      any
        (e:
          e.prefix == "AUTO-BUILD-FLAG"
          && e.path == "/dev/null/AUTO-BUILD-FLAG")
        builtins.nixPath;
  };

}
