{
  id = "file-mgmt";
  desc = "extra user-facing file management tools";
  sw = p: with p; [
    exa
    fd
    jdupes
    renameutils
  ];
}
