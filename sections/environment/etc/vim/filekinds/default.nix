{ config, lib, pkgs, ... }: let

  vim-config-rev = "d7801edf8c7d2cc3b2e30ad4a48bcc7232c45658";

  fk-dir = "lib/filekinds";

  fk-rc-path = "rc/filekinds.vim";

  fkplugin-dir = "${fk-dir}/fkplugin";
  ft-lists-dir = "${fk-dir}/type-lists";

  fk-srcs = [
    { kind = "text";
      fts-list.sha256 = "0cz729xf10lrw014jj2hlbxalgdpahxbg61gdg51jnryx8dqxrmr";
      fkplugin.sha256 = "1arxbp47zsk55qdcrczfgi774yw435v6z73zqm4jl4jliykl1y2m"; }
    { kind = "document";
      fts-list.sha256 = "057y15imz1mfkalmg5h4vwzmiqs1f3f0hg5j2j2j78ky9l438ngw";
      fkplugin.sha256 = "0fnghfv34y7678gl33zydkzjsvqbxfnrh918iq2azmz5mk2r7rrn"; }
    { kind = "message";
      fts-list.sha256 = "1p3n4g04r98nah4p3a0ky788bq1sjnz41w8ipvh3bjc6xnd5rc2n";
      fkplugin.sha256 = "059r1k33q9ysh2aahhy81y648c4l4rzig8d0r4imxq7zyr8hsl85"; }
    { kind = "code";
      fts-list.sha256 = "0zdkvf3mdhbc8jlchdhcqhq85bgp9brx11iiph2dsrc76jfsiw3b";
      fkplugin.sha256 = "02diblgkv8iwimvgpyv0phg93cvcb1zgkx7ay70kz8pln3gl4vxj"; }
    { kind = "program-source";
      fts-list.sha256 = "1w0qc4kpcx1jlmn7lba9ny86nxx6py72qbrdv1w04bngbmfkpz0g";
      fkplugin.sha256 = "1p6ddxqqz65dnb4h3ab88va47a0zhk4fxgv1nwr1r2m3379vlmkd"; }
    { kind = "configuration";
      fts-list.sha256 = "1j2c4bb70yp6gvz8q1519554b95n487hmf6lxdbrv9bis96m7hm4";
      fkplugin.sha256 = "032xfzyp36qh7ykdxszi3sj8dwyqvgkswhyrln7q0j16z8lgn30c"; }
    { kind = "data-storage";
      fts-list.sha256 = "0y7sd3vslbxqb4v2pl3ngzm9mgjqpl9qxn0zj25kdsxl6bqg44ic";
      fkplugin.sha256 = "032xfzyp36qh7ykdxszi3sj8dwyqvgkswhyrln7q0j16z8lgn30c"; }
  ];

  fetch-vim-config-file = {
    path,
    rev ? vim-config-rev,
    sha256,
  }: pkgs.fetchurl {
    url = "https://gitlab.com/c74d/vim-config/raw/${rev}/${path}";
    inherit sha256;
  };

  mk-etc-file = { path, ... } @ args: {
    name = "vim/${path}";
    value.source = fetch-vim-config-file args;
  };

  fk-etc-files = lib.listToAttrs (lib.concatMap ({
    kind,
    fts-list,
    fkplugin,
  }: map mk-etc-file [
    (fkplugin // { path = "${fkplugin-dir}/${kind}.vim"; })
    (fts-list // { path = "${ft-lists-dir}/${kind}"; })
  ]) fk-srcs);

in {

  environment.etc = {
    "vim/vimrc" = lib.optionalAttrs config.c74d-params.personal {
      text = ''
        source /etc/vim/${fk-rc-path}
      '';
    };

    "vim/${fk-rc-path}".text = ''
      ${lib.readFile (fetch-vim-config-file {
        path = fk-rc-path;
        sha256 = "1gkv8qp48m1k54y2fhbwqfx5n707hnqjfxvnfp6c6xsqjz9c8nq4";
      })}

      let s:vim_homedir = '/etc/vim'
      let s:fk_dir = '${fk-dir}'
      let s:fkplugin_dir = '${fkplugin-dir}'
      let s:ft_lists_dir = '${ft-lists-dir}'
    '';

    "vim/${fkplugin-dir}/all.vim".source = fetch-vim-config-file {
      path = "${fkplugin-dir}/all.vim";
      sha256 = "1i2p2gizg4pcnjdabs1bw8fg9f48nsvpnk4wkf5q94ifl2x1ynda";
    };
  } // fk-etc-files;

}
