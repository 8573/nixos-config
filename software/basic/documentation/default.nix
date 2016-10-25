{
  id = "documentation";
  desc = "basic documentation";
  sw = p: map p.lib.lowPrio (with p; [
    man-pages
    posix_man_pages
  ]);
}
