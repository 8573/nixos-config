{ config, lib, pkgs, ... }: let

  inherit (config.lib.c74d.vim.utils)
    plugin-from-GitHub;

in lib.mkIf config.c74d-params.personal {

  programs.vim = {
    plugins = [
      "LanguageClient-neovim"
      "commentary"
      "delimitMate"
      "editorconfig-vim"
      "fugitive"
      "rust-vim"
      "sleuth"
      "surround"
      "undotree"
      "vim-abolish"
      "vim-dispatch"
      "vim-easymotion"
      "vim-endwise"
      "vim-eunuch"
      "vim-racer"
      "vim-snipmate"
      "vim-snippets"
      "vim-speeddating"
      "vim-unimpaired"
      "vim-visualstar"

      (plugin-from-GitHub {
        owner = "dahu";
        repo = "vim-fanfingtastic";
        rev = "f6674e44840172dee5eb7e74be021ccf8403a72b";
        sha256 = "0aivwzaxn9a4dgm210ia3sdxnj6faghdckm4g3c8vgrr785vnb63";
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
