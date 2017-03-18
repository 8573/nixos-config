{
  id = "cloud-platform";
  desc = "software for interfacing with Google Cloud Platform";
  default = false;
  sw = p: with p; [
    google-cloud-sdk
  ];
}
