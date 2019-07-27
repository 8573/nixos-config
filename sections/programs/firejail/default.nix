{ config, lib, pkgs, ... }: {

  programs.firejail = lib.mkIf (
    !config.c74d-params.minimal
    && (
      # Firejail's manual says it should be installed only on "single-user
      # desktop systems" (meaning those used by a single person, not those
      # having only a superuser).
      config.c74d-params.personal
      && !config.environment.noXlibs
      && {
        desktop = true;
        laptop = true;
        server = false;
        VM = false;
      }.${config.c74d-params.installation-type}
    )
    && false # Disable for now
  ) {
    enable = true;
  };

}
