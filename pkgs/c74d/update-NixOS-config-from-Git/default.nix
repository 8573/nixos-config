{ writeShellScriptBin }:

writeShellScriptBin "update-NixOS-config-from-Git" ''
  set -euo pipefail
  cd /etc/nixos
  git checkout master
  git fetch
  git diff --ignore-all-space @ FETCH_HEAD
  git status
''
