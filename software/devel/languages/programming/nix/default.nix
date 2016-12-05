{
  id = "nix";
  desc = "software for working with the Nix scripting language";
  global = true;
  sw = p: with p; [
    nix-generate-from-cpan
    nix-prefetch-scripts
    nix-repl
  ];
}
