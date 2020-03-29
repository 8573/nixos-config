{
  id = "audio-video";
  desc = "audio- and video-processing tools";
  global = true;
  sw = p: with p; [
    ffmpeg
    libav
    youtube-dl
  ];
}
