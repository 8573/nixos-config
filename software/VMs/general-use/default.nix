{
  id = "general-use";
  desc = "virtual machine similar to host for running mildly untrusted software";
  default = {config, parent, ...}:
    { desktop = true;
      laptop = true;
      server = false;
      VM = false; }
    .${config.c74d-params.installation-type}
    && !config.c74d-params.minimal
    && config.c74d-params.personal
    && false
    && parent.enable;
  sw = p: with p; [
    (c74d.build-VM.basic ./pkg.nix)
  ];
}
