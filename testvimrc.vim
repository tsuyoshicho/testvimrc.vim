" test vimrc

let s:vimrc_base       = expand("%:p:h")
let s:dein_dir         = expand(s:vimrc_base . '/cache/dein')
let s:testrc           = expand(s:vimrc_base . '/testvimrc.vim')
let s:dein_testtoml    = expand(s:vimrc_base . '/test.toml')
let s:dein_install_dir = expand(s:dein_dir   . '/repos/github.com/Shougo/dein.vim')

" echomsg 'vimrc base: ' . s:vimrc_base
" echomsg 'dein dir  : ' . s:dein_dir
" echomsg 'test vimrc: ' . s:testrc
" echomsg 'test.toml : ' . s:dein_testtoml
" echomsg 'dein path : ' . s:dein_install_dir

call mkdir(s:dein_dir, 'p')

if !isdirectory(s:dein_install_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . s:dein_install_dir)
endif
let &rtp = s:dein_install_dir . ',' . &rtp

" pre setting
let g:dein#default_options = { 'merged': v:true }

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir, [s:testrc, s:dein_testtoml])

  call dein#load_toml(s:dein_testtoml, {'lazy': 0})

  call dein#end()
  call dein#save_state()
endif

" call source
call dein#call_hook('source')
" set post source at non-lazy plugin
autocmd VimEnter * nested call dein#call_hook('post_source')

if (0 == v:vim_did_enter) && dein#check_install()
  call dein#install()
endif

" add option/settings

syntax on

filetype plugin indent on
