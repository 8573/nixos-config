{
  id = "gui";
  desc = "applications primarily using graphical user-interfaces";
  default = {config, parent, ...}:
    config.services.xserver.enable
    && parent.enable;
  modules = [
    ./audio-video
    ./image
    ./maths
    ./pdf
    ./web-browsing
  ];
}
