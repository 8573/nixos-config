{
  id = "build-basics";
  desc = ''
    packages that `nixos-rebuild` and `nix-shell` seem to need, but that get
    garbage-collected and thus unnecessarily re-downloaded if I don't pin them
    like this
  '';
  global = false;
  filter-outputs = false;
  sw = p: with p; ([
    patchelf
    stdenv.bootstrapTools
  ] ++ map lib.getDev [
    bash
    bashInteractive
    curl
    libssh2
    nghttp2
  ]);
}
