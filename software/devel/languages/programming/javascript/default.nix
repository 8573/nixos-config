{
  id = "javascript";
  desc = "software for working with JavaScript/ECMAScript";
  sw = p: with p; [
    closurecompiler
    nodePackages.eslint
    nodejs
  ];
}
