{ config, lib, pkgs, ... }: {

  environment.etc."gitconfig".text = ''
    [core]
        compression = 9
        pager = less -+FSX
    [diff]
        algorithm = minimal
        compactionHeuristic = yes
        mnemonicPrefix = yes
        renames = copy
    [fetch]
        fsckObjects = yes
    [i18n]
        commitEncoding = utf-8
        logOutputEncoding = utf-8
    [interactive]
        diffFilter = ${pkgs.gitFull}/share/git/contrib/diff-highlight/diff-highlight
    [log]
        date = iso8601
    [pager]
        diff = ${pkgs.gitFull}/share/git/contrib/diff-highlight/diff-highlight | less -+FSX
        log = ${pkgs.gitFull}/share/git/contrib/diff-highlight/diff-highlight | less -+FSX
        show = ${pkgs.gitFull}/share/git/contrib/diff-highlight/diff-highlight | less -+FSX
    [rebase]
        missingCommitsCheck = error
        stat = yes
  '' + lib.optionalString config.c74d-params.personal ''
    [alias]
        vc = commit --verbose
        s = status
        co = checkout
        mwdiff = diff --minimal --word-diff
        gl = log --graph
        sl = log --decorate --source --format=short --encoding=UTF-8 --notes --show-signature --date=iso --graph
        xl = log --decorate --source --format=fuller --encoding=UTF-8 --notes --show-signature --date=iso --graph
        sxl = log --decorate --source --format=fuller --encoding=UTF-8 --notes --show-signature --date=iso --graph --stat --patch
        pxl = log --decorate --source --format=fuller --encoding=UTF-8 --notes --show-signature --date=iso --graph --stat --patch
        wpxl = log --decorate --source --format=fuller --encoding=UTF-8 --notes --show-signature --date=iso --graph --stat --patch --word-diff
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

}
