{ config, lib, pkgs, ... }: let

  c74d-pkgs = config.lib.c74d.pkgs;

  editor = "${c74d-pkgs.c74d.vim-try-x}/bin/vim-try-x --nofork";

  pager = "${pkgs.less}/bin/less -+FSX";

  diff-highlight-dir =
    "${pkgs.gitFull}/share/git/contrib/diff-highlight";

  diff-highlight =
    "${pkgs.perl}/bin/perl -I${diff-highlight-dir} -mDiffHighlight ${diff-highlight-dir}/diff-highlight.perl";

  very-common-personal-log-alias-options =
    "--encoding=UTF-8 --notes --date=iso";

  common-personal-log-alias-options =
    "${very-common-personal-log-alias-options} --source --graph --decorate";

  git-config-base = ''
    [core]
        compression = 9
        pager = ${pager}
    [diff]
        algorithm = histogram
        compactionHeuristic = yes
        mnemonicPrefix = yes
        renames = copy
    [fetch]
        fsckObjects = yes
    [gpg]
        program = ${pkgs.gnupg}/bin/gpg2
    [i18n]
        commitEncoding = utf-8
        logOutputEncoding = utf-8
    [interactive]
        diffFilter = ${diff-highlight}
    [log]
        date = iso8601
    [pager]
        diff = ${diff-highlight} | ${pager}
        log = ${diff-highlight} | ${pager}
        show = ${diff-highlight} | ${pager}
    [rebase]
        missingCommitsCheck = error
        stat = yes
    [alias]
        diff-highlight = !${diff-highlight}
  '';

  git-config-personal = ''
    [core]
        editor = ${editor}
    [alias]
        vc = commit --verbose
        vci = commit --verbose --interactive
        vcp = commit --verbose --patch
        s = status
        co = checkout
        ai = add --interactive
        ap = add --patch
        d = diff
        dw = diff --word-diff
        mwdiff = diff --minimal --word-diff
        gl = log --graph
        sl = log ${common-personal-log-alias-options} --format=short
        xl = log ${common-personal-log-alias-options} --format=fuller
        sxl = log ${common-personal-log-alias-options} --format=fuller --stat
        pxl = log ${common-personal-log-alias-options} --format=fuller --stat --patch
        wpxl = log ${common-personal-log-alias-options} --format=fuller --stat --patch --word-diff
        ll = log ${very-common-personal-log-alias-options} --format=fuller --stat --patch --decorate=no --reverse
        authors = "!f() { git log --format='%aN <%aE>' \"$@\" | sort -u; }; f"
        ffmerge = merge --ff-only
        noffmerge = merge --no-ff
        ffpull = pull --ff-only
        noffpull = pull --no-ff
        ir = rebase --interactive
        dry-merge = "!f() { grep -Fqm 1 'changed in both' <<< $(git merge-tree $(git merge-base $1 $2) $2 $1) && echo 'Merge conflict detected' || echo 'Merged cleanly'; }; f"
        fgrep = grep --fixed-strings
        egrep = grep --extended-regexp
        pgrep = grep --perl-regexp
        lsmergeconflicts = ls-files --unmerged
        gca = gc --aggressive
        xfsck = fsck --full --strict --unreachable --dangling
  '';

  git-config = ''
    ${git-config-base}
    ${lib.optionalString config.c74d-params.personal git-config-personal}
  '';

in
{
  environment.etc."gitconfig".text = lib.mkIf
    config.c74d-params.software.devel.version-control.enable
    git-config;
}
