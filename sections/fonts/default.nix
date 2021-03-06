{ config, lib, pkgs, ... }: {

  fonts.fontconfig = lib.mkIf config.c74d-params.X11.enable {
    defaultFonts = {
      sansSerif = [
        "Noto Sans"
        "DejaVu Sans"
      ];
      serif = [
        "Noto Serif"
        "DejaVu Serif"
      ];
      monospace = [
        "DejaVu Sans Mono"
        "Noto Mono"
      ];
    };

    includeUserConf = false;
  };

  fonts.fonts = lib.mkIf config.c74d-params.X11.enable (with pkgs; [
    noto-fonts
    noto-fonts-cjk
    dejavu_fonts
    roboto
    roboto-mono
    roboto-slab
    symbola
  ]);

}
