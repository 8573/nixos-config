{
  id = "user-mgmt";
  desc = ''
    tools for user account management whose importance rises above mere
    convenience
  '';
  sw = p: with p; [
    mkpasswd
  ];
}
