{ stdenv, lib, fetchFromGitHub, makeWrapper, perlPackages }:

stdenv.mkDerivation rec {
  name = "git-hub-ingydotnet-${version}";
  version = "git-${git-revision}";
  git-revision = "386844dac3da6ea5293e0a9d71ed91aedf2120a0";

  src = fetchFromGitHub {
    owner = "ingydotnet";
    repo = "git-hub";
    rev = git-revision;
    sha256 = "1mmasn2aqpbg5zwj9dfajfmsjcciz794406y1pwi8gqpjq5ggwsf";
  };

  buildInputs = [
    makeWrapper
  ];

  patches = [
    ./patches/0001-always-use-perl-json-impl.patch
    ./patches/0002-Makefile-paths.patch
    ./patches/0003-Makefile-we-lack-prove.patch
    ./patches/0004-zsh-completion-we-dont-use-GIT_HUB_ROOT.patch
  ];

  dontBuild = true;
  dontStrip = true;

  perl_lib = lib.makePerlPath (with perlPackages; [
    JSONMaybeXS
    JSONXS
  ]);

  postInstall = ''
    wrapProgram "$out/bin/git-hub" --prefix PERL5LIB : "$perl_lib"

    install -Dm 444 'share/completion.bash' "$out/etc/bash_completion.d/git-hub.bash"
    install -Dm 444 'share/zsh-completion/_git-hub' -t "$out/share/zsh/site-functions"
  '';

  meta = {
    description = "A Git sub-command for performing a wide array of GitHub operations";
    homepage = "https://github.com/ingydotnet/git-hub";
    license = stdenv.lib.licenses.mit;
    platforms = perlPackages.JSONXS.meta.platforms;
  };
}
