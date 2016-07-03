{ config, lib, pkgs, ... }: {

  environment.systemPackages = (with pkgs; [
    # Common applications (that don't require a graphical environment).
    elinks
    vim_configurable
    vlc
    weechat
  ] ++ [
    # Utilities, general.
    aspell
    atool
    dash
    file
    imagemagick
    jq
    libav
    libqalculate
    silver-searcher
    tree
    wdiff
    wget
  ] ++ [
    # Utilities, network.
    ldns
    telnet
    whois
  ] ++ [
    # Utilities, security/cryptographic.
    apg
    checksec
    gnupg
    openssl
  ] ++ [
    # Utilities, monitoring.
    htop
    iotop
    tcpdump
  ] ++ [
    # Utilities, hardware.
    alsaUtils
    lshw
    pciutils
    smartmontools
  ] ++ [
    # Software development, general.
    gdb
    gitAndTools.git-imerge
    gitFull
    gnumake
    llvm
    llvmPackages.lldb
    subversion
    tig
  ] ++ [
    # Software development, C-family.
    clang
    gcc
  ] ++ [
    # Software development, shell scripting.
    shellcheck
  ] ++ [
    # Software development, Web.
    closurecompiler
  ] ++ [
    # Software development, Rust.
    cargo
    rustc
    rustfmt
    rustracer
  ] ++ [
    # Misc. interpreters.
    nodejs
  ] ++ [
    # Nix
    nix-prefetch-scripts
    nix-repl
  ] ++ [
    # Google-related non-graphical software
    drive
  ] ++ [
    # Data.
    aspellDicts.en
    man-pages
    posix_man_pages
  ] ++ lib.optionals (config.environment.noXlibs) [
    # Non-graphical variants of programs with separate packages
    # for no-GUI and (GUI + no-GUI).
    nmap
  ] ++ lib.optionals (!config.environment.noXlibs) [
    # Common graphical applications.
    chromium
    audacity
    nmap_graphical
  ] ++ lib.optionals (!config.environment.noXlibs) [
    # Utilities, X11.
    dmenu
    i3status
    xclip
  ]);

}
