{
  id = "audio-video";
  desc = "audio- and video-processing tools";
  sw = p: with p; [
    ffmpeg
    libav
  ];
}
