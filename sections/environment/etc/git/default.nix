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
  '';

}
