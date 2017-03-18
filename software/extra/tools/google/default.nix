{
  id = "google";
  desc = "Google-related tools";
  modules = [
    ./cloud-platform.nix
  ];
  sw = p: with p; [
    drive
  ];
}
