{ lib, runCommand, chromium }: let

  name = "${chromium.name}-configured-${wrapper-version}";

  wrapper-version = "0.1.8";

  chromium-version = (lib.splitString "." (lib.getVersion chromium));

  major-version = lib.toInt (lib.head chromium-version);

  args = lib.concatStringsSep " " (map lib.escapeShellArg (lib.concatLists [
    ["--no-default-browser-check"]
    (lib.optional (major-version >= 63)
      # Enable this flag as a mitigation of the Spectre/Meltdown
      # vulnerabilities.
      "--site-per-process")
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
