{ config, lib, pkgs, ... }: let

  inherit (config.lib.c74d.vim.utils)
    plugin-from-GitHub;

in lib.mkIf config.c74d-params.personal {

  programs.vim = {
    plugins = [
      "commentary"
      "delimitMate"
      "fugitive"
      "sleuth"
      "surround"
      "undotree"
      "vim-dispatch"
      "vim-eunuch"
      "vim-speeddating"
      "vim-visualstar"

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
    ];
  };

}
