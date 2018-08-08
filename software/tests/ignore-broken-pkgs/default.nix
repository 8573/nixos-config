{
  id = "ignore-broken-pkgs";
  desc = ''
    a package that should cause evaluation to fail if the `ignore-broken-pkgs`
    attribute stops working
  '';
  ignore-broken-pkgs = true;
  sw = p: [
    (p.stdenv.mkDerivation {
      name = "a-broken-pkg";
      meta.broken = true;
    })
  ];
}
