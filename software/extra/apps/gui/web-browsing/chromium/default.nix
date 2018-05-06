{
  id = "chromium";
  desc = "the Web browser Chromium";
  sw = p: let
    inherit (p)
      chromium lib writeShellScriptBin;

    version = (lib.splitString "." (lib.getVersion chromium));

    major-version = lib.toInt (lib.head version);

    args = [
      ["--no-default-browser-check"]
      (lib.optional (major-version >= 63)
        # Enable this flag as a mitigation of the Spectre/Meltdown
        # vulnerabilities.
        "--site-per-process")
    ];

    script = ''
      exec '${chromium}/bin/chromium-browser' \
        ${lib.concatStringsSep " " (lib.concatLists args)} \
        "$@"
    '';

    wrapper-scripts = map (name: writeShellScriptBin name script) [
      "chromium" "chromium-browser"
    ];
  in wrapper-scripts;
}
