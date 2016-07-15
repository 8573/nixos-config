source "${stdenv}/setup"

echo 'Building Vim spellfile:
  $src: '"${src}"'
  $out: '"${out}"

cat > script.vim <<'VIMSCRIPT'
  set encoding=utf-8
  execute 'mkspell out.utf-8.add.spl' fnameescape($src)
  echo ''
  qall!
VIMSCRIPT

"${vim}/bin/vim" -i NONE -u NONE -V1 -NXensS 'script.vim'

mv 'out.utf-8.add.spl' "${out}"
