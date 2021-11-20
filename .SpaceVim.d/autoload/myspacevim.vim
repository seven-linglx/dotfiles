function! myspacevim#before() abort
  vnoremap v <Esc>
  nnoremap <leader>h ^
  nnoremap <leader>l $
  nnoremap K %
  nnoremap jk <esc>
  let g:neomake_c_enabled_makers = ['clang']
  let g:mapleader = ','
endfunction
