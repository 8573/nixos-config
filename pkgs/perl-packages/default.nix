{ config, lib, pkgs, ... }: let

  inherit (config.lib.c74d)
    call-pkg;

in

with pkgs.perlPackages;

rec {

  ModuleBuildPluggable = buildPerlModule rec {
    name = "Module-Build-Pluggable-0.10";
    src = fetchurl {
      url = "mirror://cpan/authors/id/T/TO/TOKUHIROM/${name}.tar.gz";
      sha256 = "e5bb2acb117792c984628812acb0fec376cb970caee8ede57535e04d762b0e40";
    };
    propagatedBuildInputs = [ ClassAccessorLite ClassMethodModifiers DataOptList ModuleBuild TestSharedFork ];
    meta = {
      homepage = https://github.com/tokuhirom/Module-Build-Pluggable;
      description = "Module::Build meets plugins";
      license = with stdenv.lib.licenses; [ artistic1 gpl1Plus ];
    };
  };

}
