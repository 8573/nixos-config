{ stdenv, fetchFromGitLab, vim }:

stdenv.mkDerivation rec {
  name = "c74d-vim-pager-${version}";
  version = "0.3.0";

  src = fetchFromGitLab {
    owner = "c74d";
    repo = "vim-pager";
    rev = "v${version}";
    sha256 = "1qyhnjb6kx2jx3f1b8lxxnwsj89m10cz2zdb0nn6mccccmjk6iac";
  };

  installPhase = ''
    mkdir --parents "$out"/{bin,doc}

    cp "$src/vim-pager" "$out/bin"
    cp "$src/vim-manpager" "$out/bin"
    cp "$src/"*".mkd" "$out/doc"

    chmod +x "$out/bin/vim-pager"
  '';

  postFixup = ''
    substituteInPlace "$out/bin/vim-pager" --replace 'vim=vim' '
      if which '/run/current-system/sw/bin/vim' >/dev/null 2>&1; then
        vim='/run/current-system/sw/bin/vim'
      else
        vim='${vim}/bin/vim'
      fi
      '
  '';

  meta = {
    description = "A shell script for using Vim as a pager";
    homepage = "https://gitlab.com/c74d/vim-pager";
    license = stdenv.lib.licenses.asl20;
    platforms =
      let
        vim-platforms =
          stdenv.lib.platforms.unix;
      in
        assert vim.meta ? platforms ->
         vim.meta.platforms == vim-platforms;
        vim-platforms;
  };
}
