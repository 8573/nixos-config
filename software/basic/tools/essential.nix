{
  id = "essential";
  desc = ''
    system administration tools performing functions whose importance rises
    above mere convenience
  '';
  sw = p: with p; [
    file
    gnupg
    iotop
    jq
    ldns
    lshw
    lsscsi
    openssl
    par2cmdline
    pciutils
    rsync
    smartmontools
    tcpdump
    telnet
    unzip
    usbutils
    wdiff
    whois
    zip
  ];
}
