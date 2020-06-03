{ stdenv, vim }:

let
  vim-pkg = vim;
in

let
  # NOTE: [2020-06-03] This package now uses the run-time path (not to be
  # confused with 'runtimepath') of Vim, '/run/current-system/sw/bin/vim',
  # rather than the Nix store path "${vim}/bin/vim", because it seems that
  # this package was not consistently picking up the fully configured version
  # of "${vim}" from my Vim module (`config.programs.vim.package`): the
  # version of this package that went into `environment.systemPackages` would
  # have all the configured plugins, but the version of this package that went
  # into `environment.variables.EDITOR` (and `VISUAL`) would have only some
  # plugins.
  vim = throw "Don't use this; see the NOTE";
in

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

    exec '/run/current-system/sw/bin/vim' $g "$@"
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
        assert vim-pkg.meta ? platforms ->
         vim-pkg.meta.platforms == vim-platforms;
        vim-platforms;
  };
}
