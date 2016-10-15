{
  id = "version-control";
  desc = "version-control software";
  sw = p: with p; [
    git-hub-ingydotnet
    git-lfs
    gitAndTools.git-imerge
    gitFull
    subversion
    tig
  ];
}
