{
  id = "chromium";
  desc = "the Web browser Chromium";
  sw = p: with p; let
    script = ''
      #!/bin/sh
      exec '${chromium}/bin/chromium-browser' \
        --no-default-browser-check
    '';
  in [
    (writeScriptBin "chromium" script)
    (writeScriptBin "chromium-browser" script)
  ];
}
