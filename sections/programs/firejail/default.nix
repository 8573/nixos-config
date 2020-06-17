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
    # [2019-07-27] Disable for now
    #
    # [2020-06-17] Looking into Firejail again, the very poor image I get
    # through the smoke (...that wasn't meant as a pun) is that it may
    # increase security against malicious code running inside the sandbox and
    # potentially problematically may increase attack surface to malicious
    # code running outside the sandbox. References are
    # - <https://www.openwall.com/lists/oss-security/2017/01/04/1>, et seq.;
    # - <https://github.com/netblue30/firejail/issues/3046>;
    # - etc.
    && false
  ) {
    enable = true;
  };

}
