{ stdenv, fetchFromGitLab, zsh }:

stdenv.mkDerivation rec {
  name = "c74d-zsh-config-${version}";
  version = "0.5.2";

  src = fetchFromGitLab {
    owner = "c74d";
    repo = "zsh-config";
    rev = "v${version}";
    sha256 = "0xkm64dkpcay8fbqv0bc54zk1gf423krg45k68swlhk89s963l1y";
  };

  buildInputs = [
    zsh
  ];

  installPhase = ''
    cp -r . "$out"
  '';

  meta = {
    description = "c74d's quite-possibly-overengineered configuration for the Z shell (zsh)";
    homepage = "https://gitlab.com/c74d/zsh-config";
    license = stdenv.lib.licenses.asl20;
    inherit (zsh.meta) platforms;
  };
}
