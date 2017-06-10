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

    #includeUserConf = false;

    localConf = let
      overridenda = {
        sans-serif = [
          "Arial"
          "Helvetica"
          "Tahoma"
          "Verdana"
        ];
        serif = [
          "Times"
          "Times New Roman"
        ];
        monospace = [
          "Courier New"
        ];
      };
      override = new: old: ''
        <match>
          <test name='family'>
            <string>${old}</string>
          </test>
          <edit name='family' mode='assign' binding='strong'>
            <string>${new}</string>
          </edit>
        </match>
      '';
      overrideList = list: new: map (override new) list;
      overrides = lib.concatLists [
        (overrideList overridenda.sans-serif "Noto Sans")
        (overrideList overridenda.serif "Noto Serif")
        (overrideList overridenda.monospace "DejaVu Mono")
      ];
    in ''
      <?xml version='1.0' encoding='UTF-8'?>
      <!DOCTYPE fontconfig SYSTEM 'fonts.dtd'>
      <fontconfig>
        ${lib.concatStrings overrides}
      </fontconfig>
    '';
  };

  fonts.fonts = lib.mkIf config.c74d-params.X11.enable (with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    dejavu_fonts
    symbola
  ]);

}
