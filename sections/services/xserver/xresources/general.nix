{ config, ... }: let

  font-size = toString config.c74d-params.X11.font-size;

in {

  services.xserver.xresources = {
    "*locale" = "true";
    "*foreground" = "rgb:A8/A8/A8";
    "*background" = "rgb:00/00/00";
    "*faceName" = "Monospace:size=${font-size}";
  };

}
