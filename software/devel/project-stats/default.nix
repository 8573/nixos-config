{
  id = "project-stats";
  desc = ''
    software for collecting and/or processing statistics about software
    projects
  '';
  sw = p: with p; [
    #tokei
  ];
}
