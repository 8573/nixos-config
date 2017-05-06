{ stdenv, fetchFromGitLab, zsh }:

stdenv.mkDerivation rec {
  name = "c74d-zsh-config-${version}";
  version = "0.9.1";

  src = fetchFromGitLab {
    owner = "c74d";
    repo = "zsh-config";
    rev = "v${version}";
    sha256 = "006n31rxkivkz3id6z5aphchjzf2f612hmcd3j5w80bvj7n9qwy8";
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
