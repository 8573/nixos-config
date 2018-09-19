{
  id = "convenience";
  desc = ''
    user-facing tools whose functions largely could be replicated less
    conveniently with other tools
  '';
  sw = p: with p; [
    apg
    atool
    c74d.vim-pager
    checksec
    htop
    silver-searcher
    wget
    yq
  ];
}
