{ config, lib, pkgs, ... }: {

  services.printing = {
    enable = lib.elem config.c74d-params.installation-type [
      "desktop"
      "laptop"
    ];

    #gutenprint = config.services.printing.enable;

    drivers = lib.mkIf config.services.printing.enable (with pkgs; [
      hplip
      #samsung-unified-linux-driver
      #splix
      /*(splix.overrideAttrs (orig: {
        preBuild = lib.replaceStrings ["DISABLE_JBIG=1"] [""] orig.preBuild;
      }))*/
    ]);
  };

}
