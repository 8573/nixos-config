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
    noto-fonts-emoji
    dejavu_fonts
    symbola
  ]);

}
