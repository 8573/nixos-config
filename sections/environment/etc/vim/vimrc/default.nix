{ config, lib, pkgs, ... }: {

  environment.etc."vim/vimrc".text = ''
    set runtimepath+=/etc/vim

    " The `desert` colorscheme, beside being my favorite of the standard
    " colorschemes, is decidedly nicer in the Linux kernel console than the
    " default colorscheme, which is why I set it here.
    colorscheme desert

    ${if config.c74d-params.minimal then ''
      " vim-sensible won't get loaded by the plugins mechanism, so load it
      " here.
      source ${pkgs.fetchFromGitHub {
        owner = "tpope";
        repo = "vim-sensible";
        rev = "4b7535921819a5b2e39be68f81109ea684232503";
        sha256 = "0ghds721dawm8mcd8cp23hfqpgiznh811z73zxlqrm1sg2fmdq1s";
      }}/plugin/sensible.vim
    '' else ''
      " Mollify delimitMate, which may check that this is set before
      " vim-sensible sets it.
      set backspace+=eol,start
    ''}
  '';

}
