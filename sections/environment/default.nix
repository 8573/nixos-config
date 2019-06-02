{ config, lib, pkgs, ... }: {

  imports = [
    ./etc
    ./variables
  ];

  environment.extraInit = ''
    umask 077
  '';

  # [2019-06-02] The hardened profile sets this to "graphene-hardened" by
  # default, but that setting seems---
  #   (1) to make zsh often crash with SIGSEGV if I begin typing into it
  #       shortly after switching focus to it (e.g., switching windows in tmux
  #       to one whose active pane has zsh running), which I find obnoxious
  #       but (barely) tolerable;
  #   (2) to make nixos-rebuild crash (with the message "out of memory" or
  #       "basic_string::_M_construct: null not valid") every time it's run,
  #       which I tolerate because it can be worked around by overriding the
  #       `LD_PRELOAD`ed allocator (`LD_PRELOAD= nixos-rebuild ...`); and,
  #       now, after a system upgrade,
  #   (3) to make the X11 server crash when systemd tries to start it, which
  #       is sufficiently obnoxious for me to disable this feature.
  # It was suggested on GitHub that "scudo" might cause less breakage while
  # still being a security-enhanced allocator, so I'm trying that.
  environment.memoryAllocator.provider = "scudo";

  environment.noXlibs = !config.c74d-params.X11.enable;

}
