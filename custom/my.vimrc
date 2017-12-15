""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => The Silver Searcher
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0

  " bind K to grep word under cursor
  nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

  " bind \ (backward slash) to grep shortcut
  command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
  nnoremap \ :Ag<SPACE>
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Path search base
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set path=.,**
set wildignorecase

colorscheme onedark
hi ExtraWhitespace guibg=NONE      guisp=NONE      gui=NONE        ctermfg=248     ctermbg=NONE    cterm=NONE
match ExtraWhitespace /^\s\+/
autocmd BufWinEnter * match ExtraWhitespace /^\s\+/

autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim test
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <C-x> :!npm run test
