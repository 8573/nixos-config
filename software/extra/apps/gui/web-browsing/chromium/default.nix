{
  id = "chromium";
  desc = "the Web browser Chromium";
  sw = p: with p; [
    (writeScriptBin "chromium" ''
      #!/bin/sh
      exec '${chromium}/bin/chromium-browser' \
        --no-default-browser-check
    '')
  ];
}
