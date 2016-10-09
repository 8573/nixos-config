{
  id = "i3";
  name = "i3-related tools";
  default = {config, ...}:
    config.c74d-params.i3.enable;
  sw = p: with p; [
    wrapped.i3lock
  ];
}
