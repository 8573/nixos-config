{ config, lib, pkgs, ... }: {

  environment.systemPackages = lib.mkIf config.services.xserver.enable (with pkgs; [
    audacity
    chromium
    gimp
    inkscape
    nmap_graphical

    (config.lib.c74d.call-pkg "own/vim-try-x" {
      vim = config.programs.vim.package;
    })
  ]);

}
