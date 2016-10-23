{
  id = "common";
  desc = ''
    applications that neither depend on a graphical environment nor are
    non-graphical versions of applications with separate graphical and
    non-graphical packages
  '';
  modules = [
    ./audio-video
    ./communication
    ./web-browsing
  ];
}
