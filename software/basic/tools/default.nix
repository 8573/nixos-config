{
  id = "tools";
  desc = "basic user-facing tools";
  sw = p: with p; [
    apg
    atool
    c74d.vim-pager
    checksec
    file
    gnupg
    htop
    iotop
    jq
    ldns
    lshw
    lsscsi
    openssl
    pciutils
    rsync
    silver-searcher
    smartmontools
    tcpdump
    telnet
    tree
    usbutils
    wdiff
    wget
    whois
  ];
}
