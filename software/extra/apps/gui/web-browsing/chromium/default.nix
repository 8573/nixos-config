{
  id = "chromium";
  desc = "the Web browser Chromium";
  sw = p: with p; [
    wrapped.chromium
  ];
}
