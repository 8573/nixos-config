{ stdenv, i3lock }:

stdenv.mkDerivation rec {
  name = "${i3lock.name}-configured-${version}";
  version = "0.1.0";

  src = ''
    #!/bin/sh
    exec '${i3lock}/bin/i3lock' --color=000000 --ignore-empty-password "$@"
  '';

  phases = [
    "installPhase"
    "fixupPhase"
  ];

  installPhase = ''
    mkdir -p "$out/bin"
    echo -E "$src" >> "$out/bin/i3lock"
    chmod +x "$out/bin/i3lock"
  '';

  dontPatchELF = true;
  dontStrip = true;

  meta = {
    description = "A wrapper around i3lock that sets some of its options";
    longDescription = ''
      A wrapper script around i3lock that configures it to use a black
      background and not count a press of the Enter key before one starts
      typing a password as a failed login attempt.
    '';
    license = stdenv.lib.licenses.zlib;
    platforms = i3lock.meta.platforms;
  };
}
