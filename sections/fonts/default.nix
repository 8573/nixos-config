{ config, lib, pkgs, ... }: {

  fonts.fontconfig = lib.optionalAttrs (!config.environment.noXlibs) {
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
  };

  fonts.fonts = lib.optionals (!config.environment.noXlibs) (with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    dejavu_fonts
  ]);

}
