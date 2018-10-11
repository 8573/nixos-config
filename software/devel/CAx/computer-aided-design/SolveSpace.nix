{
  id = "SolveSpace";
  desc = "SolveSpace";
  default = {config, parent, ...}:
    # [2018-10-11] SolveSpace is surprisingly lightweight, at ~9.3 MB, but I
    # don't really have a use for it as it turns out not to know how to import
    # IGES files.
    false
    && parent.enable;
  sw = p: with p; [
    solvespace
  ];
}
