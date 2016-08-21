{ stdenv, tmux }:

stdenv.mkDerivation rec {
  name = "${scriptName}-${version}";
  scriptName = "tmux-open-piped-url";
  version = "1.0.0";

  src = ''
    #!/usr/bin/env bash

    read -rd ${"$'\\0'"} url

    gui_browsers=(chromium-browser firefox)
    tui_browsers=(elinks lynx links)

    tmux="${tmux}/bin/tmux"

    if [[ -n "$DISPLAY" ]]; then
      for b in ''${gui_browsers[@]}; do
        b="/run/current-system/sw/bin/$b"
        if [[ -x "$b" ]]; then
          exec "$tmux" run-shell "'$b' '$url' > /dev/null"
        fi
      done
    fi

    for b in "$BROWSER" ''${tui_browsers[@]}; do
      b="/run/current-system/sw/bin/$b"
      if [[ -x "$b" ]]; then
        exec "$tmux" new-window -a -c "$HOME" "'$b' '$url'"
      fi
    done

    "$tmux" display-message '${scriptName}: error: No browser found.'
  '';

  phases = [
    "installPhase"
    "fixupPhase"
  ];

  installPhase = ''
    cat > "$out" <<'BASH'
    ${src}
    BASH

    chmod +x "$out"
  '';

  dontStrip = true;

  meta = {
    description = "A script for dereferencing a URL from tmux copy mode";
    license = stdenv.lib.licenses.zlib;
    platforms = tmux.meta.platforms;
  };
}
