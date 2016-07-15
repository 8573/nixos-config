{ config, lib, pkgs, ... }: {

  environment.etc."vim/vimrc".text = ''
    set runtimepath+=/etc/vim

    " The `desert` colorscheme, beside being my favorite of the standard
    " colorschemes, is decidedly nicer in the Linux kernel console than the
    " default colorscheme, which is why I set it here.
    colorscheme desert
  '';

}
