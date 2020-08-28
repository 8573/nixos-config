{
  id = "VMs";
  desc = "pre-configured virtual machines";
  default = {config, parent, ...}:
    { desktop = true;
      laptop = false;
      server = false;
      VM = false;
    }.${config.c74d-params.installation-type}
    && parent.enable;
  global = false;
  modules = [
    ./examples
    ./general-use
  ];
}
