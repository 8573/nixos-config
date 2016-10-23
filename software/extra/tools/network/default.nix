{
  id = "network";
  desc = "extra user-facing networking-related tools";
  modules = [
    ./X11-off.nix
    ./X11-on.nix
  ];
}
