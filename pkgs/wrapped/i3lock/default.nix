{ lib, writeTextFile, i3lock }: let

  name = "${i3lock.name}-configured-${version}";

  version = "0.1.0";

  script = writeTextFile {
    inherit name text;
    executable = true;
    destination = "/bin/i3lock";
  };

  text = ''
    #!/bin/sh
    exec '${i3lock}/bin/i3lock' --color=000000 --ignore-empty-password "$@"
  '';

  meta = {
    description = "A wrapper around i3lock that sets some of its options";
    longDescription = ''
      A wrapper script around i3lock that configures it to use a black
      background and not count a press of the Enter key before one starts
      typing a password as a failed login attempt.
    '';
  };

in lib.recursiveUpdate script {
  inherit meta;
}
