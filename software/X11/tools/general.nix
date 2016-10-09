{
  id = "general";
  name = "X11 tools not related to any particular DE or WM";
  sw = p: with p; [
    redshift
    xclip
    xorg.xbacklight
    xorg.xev
    xorg.xmodmap
  ];
}
