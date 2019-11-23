" ru! defaults.vim
" let g:skip_defaults_vim = 1
set clipboard+=unnamed
set nu "开启行号
set relativenumber "设置为相对行号
set nocompatible "关闭vi兼容模式
set cursorline "突出显示当前行
set noerrorbells "关闭错误信息响铃
set smartindent "开启新行时使用智能自动缩进
set sw=4
set ts=4

" 使用空格代替制表符
set expandtab

set foldenable
set foldmethod=manual "设置折叠方式

set guifont=Source_Code_Pro_for_Powerline:h12

set encoding=utf-8
set smartcase "智能判断搜索时是否大小写敏感，当搜索词中有大写时，则大小写敏感

filetype plugin on
syntax on

let mapleader=","
inoremap jk <esc>
" Insert mode shortcut
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
" imap <C-a> <Home>
" imap <C-e> <End>
" imap <C-d> <Delete>

" 切换buffer
nnoremap [p :bprevious<CR>
nnoremap [n :bnext<CR>

" Normal mode shortcut
nnoremap <space>fs :w<CR>
nmap <leader>h ^
nmap <leader>l $
noremap \ ,
noremap K %
"<C-l>通常用于清除并重绘显示屏（参见 :h CTRL-L）。而新的映射项，是在原有基础之上增加了暂时关闭查找高亮的功能
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

runtime macros/matchit.vim
set background=dark
colorscheme hybrid

" plugin
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree' ", {'on': 'NERDTreeToggle'}
Plug 'mhinz/vim-startify'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline'
Plug 'Yggdroot/indentLine'
call plug#end()

" The NERD Commenter
" 注释符号后面加一个空格
let g:NERDSpaceDelims=1
nmap <space>cl <plug>NERDCommenterToggle

" nerdtree
nmap ,t :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" startify
let g:startify_change_to_dir=0

" airline
let g:airline_powerline_fonts = 1
let g:airline_theme='molokai'
let g:airline#extensions#tabline#enabled = 1 "显示窗口tab和buffer

" IndentLines
let g:indentLine_char_list = ['¦', '┆', '┊']
let g:indentLine_enabled = 1
map <leader>ll :IndentLinesToggle<CR>
