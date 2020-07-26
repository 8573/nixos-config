{ lib, runCommand, chromium }: let

  name = "${chromium.name}-configured-${wrapper-version}";

  wrapper-version = "0.1.10";

  chromium-version = (lib.splitString "." (lib.getVersion chromium));

  major-version = lib.toInt (lib.head chromium-version);

  args = lib.concatStringsSep " " (map lib.escapeShellArg (lib.concatLists [
    ["--no-default-browser-check"]
    (lib.optional (major-version >= 63)
      # Enable this flag as a mitigation of the Spectre/Meltdown
      # vulnerabilities.
      "--site-per-process")
    (lib.optional (major-version > 81 && major-version <= 84)
      # Work around <https://github.com/NixOS/nixpkgs/issues/89512>, a.k.a.
      # <https://crbug.com/1087109>.
      "--force-device-scale-factor=1")
  ]));

  chromium-wrapped = runCommand "chromium-wrapped" {} ''
    mkdir -p "$out"

    cd "$out"

    mkdir bin

    cat >> bin/chromium <<'SHELL_SCRIPT'
      #!/bin/sh
      exec '${chromium}/bin/chromium' ${args} "$@"
    SHELL_SCRIPT

    chmod +x bin/chromium

    ln bin/chromium bin/chromium-browser

    ln -s ${chromium}/share
  '';

in chromium-wrapped
