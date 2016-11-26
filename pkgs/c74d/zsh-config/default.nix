{ stdenv, fetchFromGitLab, zsh }:

stdenv.mkDerivation rec {
  name = "c74d-zsh-config-${version}";
  version = "0.7.0";

  src = fetchFromGitLab {
    owner = "c74d";
    repo = "zsh-config";
    rev = "v${version}";
    sha256 = "0x57bsg2g6rb2hjqsggz0s6npfp2rhdfj8bnv2wp3yh8krjfq58y";
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
