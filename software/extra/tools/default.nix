{
  id = "tools";
  name = "extra user-facing tools";
  modules = [
    ./audio-video
    ./compression
    ./google
    ./hardware
    ./image
    ./pdf
    ./spellcheck
    ./text
  ];
  sw = p: with p; [
    libqalculate
  ];
}
