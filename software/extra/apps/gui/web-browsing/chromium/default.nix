{
  id = "chromium";
  desc = "the Web browser Chromium";
  sw = p: let
    inherit (p)
      chromium lib runCommand;

    version = (lib.splitString "." (lib.getVersion chromium));

    major-version = lib.toInt (lib.head version);

    args = [
      ["--no-default-browser-check"]
      (lib.optional (major-version >= 63)
        # Enable this flag as a mitigation of the Spectre/Meltdown
        # vulnerabilities.
        "--site-per-process")
    ];

    chromium-wrapped = runCommand "chromium-wrapped" {} ''
      mkdir -p "$out"

      cd "$out"

      mkdir bin

      cat >> bin/chromium <<'SHELL_SCRIPT'
        #!/bin/sh
        exec '${chromium}/bin/chromium' \
          ${lib.concatStringsSep " " (lib.concatLists args)} \
          "$@"
      SHELL_SCRIPT

      chmod +x bin/chromium

      ln bin/chromium bin/chromium-browser

      ln -s ${chromium}/share
    '';
  in [
    chromium-wrapped
  ];
}
