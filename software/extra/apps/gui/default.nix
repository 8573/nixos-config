{
  id = "gui";
  desc = "applications primarily using graphical user-interfaces";
  default = {config, parent, ...}:
    config.services.xserver.enable
    && parent.enable;
  modules = [
    ./audio-video
    ./entertainment
    ./image
    ./maths
    ./office-suites
    ./pdf
    ./web-browsing
  ];
}
