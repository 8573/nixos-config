{
  id = "FreeCAD";
  desc = "FreeCAD";
  default = {config, parent, ...}:
    # [2018-10-15] FreeCAD is pretty heavy, but it seems to be the only CAD
    # program in nixpkgs that knows how to import IGES files.
    false
    && parent.enable;
  sw = p: with p; [
    freecad
  ];
}
