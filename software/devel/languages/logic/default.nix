{
  id = "logic";
  desc = "what nixpkgs classifies as 'logic' software (Coq, Lean, etc.)";
  default = {config, parent, ...}:
    { desktop = true;
      laptop = false;
      server = false;
      VM = false; }
    .${config.c74d-params.installation-type}
    && parent.enable;
  global = true;
  modules = [
#    ./coq
#    ./lean
  ];
}
