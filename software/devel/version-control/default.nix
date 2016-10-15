{
  id = "version-control";
  name = "version-control software";
  sw = p: with p; [
    git-hub-ingydotnet
    git-lfs
    gitAndTools.git-imerge
    gitFull
    subversion
    tig
  ];
}
