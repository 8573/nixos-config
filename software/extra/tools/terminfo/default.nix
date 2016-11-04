{
  id = "terminfo";
  desc = "tools for working with terminfo (and termcap) data";
  sw = p: with p; [
    (lib.getDev ncurses)
  ];
}
