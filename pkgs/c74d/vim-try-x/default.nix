{ stdenv, vim }:

stdenv.mkDerivation rec {
  name = "${scriptName}-${version}";
  scriptName = "vim-try-x";
  version = "1.0.0";

  src = ''
    #!/bin/sh

    g=

    if [ -n "$DISPLAY" ]; then
      g='-g'
    fi

    exec '${vim}/bin/vim' $g "$@"
  '';

  phases = [
    "installPhase"
    "fixupPhase"
  ];

  installPhase = ''
    mkdir -p "$out/bin"
    echo -E "$src" >> "$out/bin/$scriptName"

    cat >> "$out/bin/${scriptName}-nofork" <<SHELL_SCRIPT
    #!/bin/sh
    '$out/bin/$scriptName' --nofork "\$@"
    SHELL_SCRIPT

    chmod +x "$out/bin/$scriptName"*
  '';

  dontPatchELF = true;
  dontStrip = true;

  meta = {
    description =
      "A wrapper around Vim that has it connect to X if available";
    longDescription = ''
      A wrapper script around Vim that has it connect to an X server if the
      `DISPLAY` environment variable is set, without emitting an error message
      if the variable is unset.
    '';
    license = stdenv.lib.licenses.zlib;
    platforms =
      let
        vim-platforms =
          stdenv.lib.platforms.unix;
      in
        assert vim.meta ? platforms ->
         vim.meta.platforms == vim-platforms;
        vim-platforms;
  };
}
