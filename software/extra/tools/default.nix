{
  id = "tools";
  desc = "extra user-facing tools";
  modules = [
    ./audio-video
    ./compression
    ./diff
    ./file-mgmt
    ./google
    ./hardware
    ./image
    ./intel
    ./monitoring
    ./network
    ./pdf
    ./security
    ./spellcheck
    ./terminfo
    ./text
  ];
  sw = p: with p; [
    libqalculate
  ];
}
