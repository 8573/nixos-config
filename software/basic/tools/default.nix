{
  id = "tools";
  desc = "basic user-facing tools";
  modules = [
    ./X11-on.nix
  ];
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
    par2cmdline
    pciutils
    rsync
    silver-searcher
    smartmontools
    tcpdump
    telnet
    unzip
    usbutils
    wdiff
    wget
    whois
    yq
    zip
  ];
}
