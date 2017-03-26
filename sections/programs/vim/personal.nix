{ config, lib, pkgs, ... }: let

  inherit (config.lib.c74d.vim.utils)
    plugin-from-GitHub;

in lib.mkIf config.c74d-params.personal {

  programs.vim = {
    plugins = [
      "commentary"
      "fugitive"
      "sleuth"
      "surround"
      "undotree"
      "vim-dispatch"
      "vim-eunuch"
      "vim-speeddating"

      (plugin-from-GitHub {
        owner = "Raimondi";
        repo = "delimitMate";
        rev = "2.7";
        sha256 = "0p7w21hja1a87mic5z488q6bzafx89h54faj7zznb8bfam8h4qpc";
      })

      (plugin-from-GitHub {
        owner = "dahu";
        repo = "vim-fanfingtastic";
        rev = "02493e56ffa8236951d71188b2a5ec7b33b1b18c";
        sha256 = "1r5nirzc975c8408v34ws21cwm4zqfxqwfq9m8i77bh7n8kdp3hp";
      })

      (plugin-from-GitHub {
        owner = "dahu";
        repo = "Nexus";
        rev = "347199ac38dcd3675edc5b070a764b49e5816713";
        sha256 = "0qwrjvir6k6j3561sk3mczkm6pwzar0j4ljinw6i4bl8gg13iwj1";
      })

      (plugin-from-GitHub {
        owner = "thinca";
        repo = "vim-visualstar";
        rev = "a18cd0e7a03311ac709595c1d261ed44b45c9098";
        sha256 = "0yz6ci4i84xxrgazjfa5nsj3q8733p0b6vwcljk1l7ghdfiflvy4";
      })
    ];
  };

}
