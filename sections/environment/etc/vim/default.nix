{ config, lib, pkgs, ... }: {

  environment.etc."vim/vimrc".text = ''
    " The `desert` colorscheme, beside being my favorite of the standard
    " colorschemes, is decidedly nicer in the Linux kernel console than the
    " default colorscheme, which is why I set it here.
    colorscheme desert

    " sensible.vim, revision 8c4429c70c186f9be47121b126c13095793062a1.
    ${builtins.readFile (pkgs.fetchurl {
      url = https://raw.githubusercontent.com/tpope/vim-sensible/8c4429c70c186f9be47121b126c13095793062a1/plugin/sensible.vim;
      sha256 = "1jb2xb4wk5snglrkql2d2pr9dklcwcbhpzk8sg6vrz91zqcqqk9l";
    })}
  '';

}
