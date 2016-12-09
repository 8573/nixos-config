{
  id = "tools";
  desc = "extra user-facing tools";
  modules = [
    ./audio-video
    ./compression
    ./google
    ./hardware
    ./image
    ./intel
    ./monitoring
    ./network
    ./pdf
    ./spellcheck
    ./terminfo
    ./text
  ];
  sw = p: with p; [
    libqalculate
  ];
}
