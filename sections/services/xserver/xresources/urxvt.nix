{ config, lib, ... }: {

  services.xserver.xresources = {
    "URxvt*font" =
      lib.concatMapStringsSep
        ","
        (name: "xft:${name}:size=${
          toString config.c74d-params.X11.font-size}")
        (config.fonts.fontconfig.defaultFonts.monospace
          ++ ["Monospace"]);

    "URxvt*scrollBar" = "false";

    "URxvt*pointerBlank" = "true";

    "URxvt*pointerBlankDelay" = "60";

    "URxvt*utmpInhibit" = "true";
  };

}
