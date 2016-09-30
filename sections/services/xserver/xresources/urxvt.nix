{ config, lib, ... }: {

  services.xserver.xresources = {
    "URxvt*font" =
      lib.concatMapStringsSep
        ","
        (name: "xft:${name}:size=${
          toString config.c74d-params.X11.font-size}")
        (config.fonts.fontconfig.defaultFonts.monospace
          ++ ["Monospace"]);

    "URxvt*pointerBlank" = "true";

    "URxvt*pointerBlankDelay" = "60";

    "URxvt*scrollBar" = "false";

    "URxvt*utmpInhibit" = "true";
  };

}
