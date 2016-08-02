{ config, lib, pkgs, ... }: let

  vim-config-rev = "707fa53fcbf1321cca706b20df40865e2b5e5741";

  spellfile-srcs = [
    { lang = "en";
      sha256 = "08vxah4iz61psnp1ffbrjzbxbv6w4swyv88fnygq4msznnpfxgrp"; }
  ];

  spellfile-name = lang: "${lang}.utf-8.add";
  spellfile-path = lang: "spell/${spellfile-name lang}";

  fetch-spellfile = {
    lang,
    rev ? vim-config-rev,
    sha256,
  }: pkgs.fetchurl {
    url = "https://gitlab.com/c74d/vim-config/raw/${rev}/${spellfile-path lang}";
    inherit sha256;
  };

  compile-spellfile = {
    lang,
    rev ? vim-config-rev,
    ...
  } @ args: pkgs.stdenv.mkDerivation {
    name = "vim-spellfile-${rev}-${spellfile-name lang}.spl";
    builder = ./build-spellfile.bash;
    src = fetch-spellfile args;
    vim = config.programs.vim.package;
  };

  words-etc-files = lib.listToAttrs (lib.concatMap ({
    lang, ...
  } @ args: [
    { name = "vim/${spellfile-path lang}";
      value.source = fetch-spellfile args; }
    { name = "vim/${spellfile-path lang}.spl";
      value.source = compile-spellfile args; }
  ]) spellfile-srcs);

in {

  environment.etc = {
    "vim/vimrc".text = ''
      source /etc/vim/rc/spell.vim
    '';

    "vim/rc/spell.vim".text = ''
      function! s:set_spellfile()
        let l:sf = '/etc/vim/spell/' . &spelllang . '.utf-8.add'

        if !&spellfile && filereadable(l:sf)
          let &l:spellfile = l:sf
        endif
      endfunction

      autocmd BufRead,BufNewFile * call s:set_spellfile()
    '';
  } // words-etc-files;

}
