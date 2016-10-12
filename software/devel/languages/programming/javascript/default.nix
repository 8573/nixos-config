{
  id = "javascript";
  name = "software for working with JavaScript/ECMAScript";
  sw = p: with p; [
    closurecompiler
    nodePackages.eslint
    nodejs
  ];
}
