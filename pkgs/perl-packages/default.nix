{ config, lib, pkgs, ... }: let

  inherit (config.lib.c74d)
    call-pkg;

in

with pkgs.perlPackages;

rec {

  HTMLEscape = buildPerlModule rec {
    name = "HTML-Escape-1.10";
    src = fetchurl {
      url = "mirror://cpan/authors/id/T/TO/TOKUHIROM/${name}.tar.gz";
      sha256 = "b1cbac4157ad8dedac6914e1628855e05b8dc885a4007d2e4df8177c6a9b70fb";
    };
    buildInputs = [ ModuleBuild ModuleBuildPluggablePPPort TestRequires ];
    meta = {
      homepage = https://github.com/tokuhirom/HTML-Escape;
      description = "Extremely fast HTML escaping";
      license = with stdenv.lib.licenses; [ artistic1 gpl1Plus ];
    };
  };

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

  ModuleBuildPluggablePPPort = buildPerlModule rec {
    name = "Module-Build-Pluggable-PPPort-0.04";
    src = fetchurl {
      url = "mirror://cpan/authors/id/T/TO/TOKUHIROM/${name}.tar.gz";
      sha256 = "44084ba3d8815f343bd391585ac5d8339a4807ce5c0dd84c98db8f310b64c0ea";
    };
    buildInputs = [ ModuleBuild TestRequires ];
    propagatedBuildInputs = [ ClassAccessorLite ModuleBuildPluggable ];
    meta = {
      description = "Generate ppport.h";
      license = with stdenv.lib.licenses; [ artistic1 gpl1Plus ];
    };
  };

  Swim = buildPerlPackage rec {
    name = "Swim-0.1.43";
    src = fetchurl {
      url = "mirror://cpan/authors/id/I/IN/INGY/${name}.tar.gz";
      sha256 = "75a8f4dd4be5979a4330e84499031e04a28a45b9431029440cb9d79349c23069";
    };
    buildInputs = [ FileShareDirInstall ];
    propagatedBuildInputs = [ HTMLEscape HashMerge Pegex TextAutoformat YAMLLibYAML ]
      # XXX: Swim's CPAN package description doesn't mention `IPC::Run`, but
      # it seems to be an undeclared dependency. I've filed an issue report
      # (<https://github.com/ingydotnet/swim-pm/issues/33>) and, pending
      # resolution thereof, am adding `IPCRun` here.
      ++ [ IPCRun ];
    meta = {
      homepage = https://github.com/ingydotnet/swim-pm;
      description = "See What I Mean?!";
      license = with stdenv.lib.licenses; [ artistic1 gpl1Plus ];
    };
  };

}
