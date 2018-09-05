func! myspacevim#before() abort
  " let g:neomake_enabled_c_makers = ['clang']
  let g:clang_library_path = '/usr/lib/llvm-5.0/lib/'
  let g:timeoutlen = 100
  let g:mapleader = ","
  vnoremap v <Esc>
  nnoremap <leader>gh ^
  nnoremap <leader>gl $
  nnoremap K %
endf
