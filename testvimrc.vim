" test vimrc
let s:vimrc_base       = expand('%:p:h')
let s:dein_dir         = expand(s:vimrc_base . '/cache/dein')
let s:dein_testtoml    = expand(s:vimrc_base . '/test.toml')
let s:dein_install_dir = expand(s:dein_dir   . '/repos/github.com/Shougo/dein.vim')

call mkdir(s:dein_dir, 'p')

if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_install_dir)
    call system('git clone https://github.com/Shougo/dein.vim ' . s:dein_install_dir)
  endif
  let &runtimepath = s:dein_install_dir . ',' . &runtimepath
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir, [$MYVIMRC, s:dein_testtoml])

  call dein#load_toml(s:dein_testtoml, {'lazy': 0})

  call dein#end()
  call dein#save_state()
endif

if (0 == v:vim_did_enter) && dein#check_install()
  call dein#install()
endif

" add option/settings

syntax on

filetype plugin indent on
