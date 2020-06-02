{ config, lib, pkgs, ... }: let

  inherit (config.lib.c74d.vim.utils)
    plugin-from-GitHub;

in {

  imports = [
    ./personal.nix
  ];

  programs.vim = {
    enable = lib.mkDefault (!config.c74d-params.minimal);

    vimrc.text = ''
      source /etc/vim/vimrc
    '';

    plugins = [
      "sensible"
      "vim-plugin-AnsiEsc"
      "vim-repeat"

      (plugin-from-GitHub {
        owner = "bitc";
        repo = "vim-bad-whitespace";
        rev = "v0.3";
        sha256 = "1zxs47pvm217iijbv2jcd54hil2yxrg3jbz2k3nqzlcljl8bz8mn";
      })

      (plugin-from-GitHub {
        owner = "mhinz";
        repo = "vim-hugefile";
        rev = "b62941d12370faa5d0c950ee87d4fb5e771c9386";
        sha256 = "0d9jyaz559264saya90545hdqa6b9bv8y5cpjmrwgjiqdmxn353i";
      })

      (plugin-from-GitHub {
        owner = "ciaranm";
        repo = "securemodelines";
        rev = "9751f29699186a47743ff6c06e689f483058d77a";
        sha256 = "0iv30pdy8gdzjy49xd74a6lyygg6mnrjs2x6q52cz1m84qnimibl";
      })
    ];
  };

}
