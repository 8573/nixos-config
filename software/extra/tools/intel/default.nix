{
  id = "intel";
  desc = "tools for Intel systems";
  default = {config, parent, ...}:
    config.c74d-params.hardware.main-CPU-mfr == "Intel"
    && parent.enable;
  sw = p: with p; [
    powertop
  ];
}
