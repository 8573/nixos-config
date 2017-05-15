{

  imports = [
    <nixpkgs/nixos/modules/profiles/hardened.nix>
    ../modules
    ../pkgs
    ../sections
  ];

  config.lib.c74d.generic-configuration-path = ./.;

}
