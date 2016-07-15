{ config, lib, pkgs, ... }: let

  rev = "8c4429c70c186f9be47121b126c13095793062a1";
  sha256 = "1jb2xb4wk5snglrkql2d2pr9dklcwcbhpzk8sg6vrz91zqcqqk9l";

in {

  environment.etc."vim/vimrc".text = ''
    " sensible.vim, revision ${rev}.
    source /etc/vim/rc/sensible.vim
  '';

  environment.etc."vim/rc/sensible.vim".source = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/tpope/vim-sensible/${rev}/plugin/sensible.vim";
    inherit sha256;
  };

}
