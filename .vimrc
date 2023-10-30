syntax on
filetype off                  " required
set nocompatible              " be iMproved, required
set encoding=UTF-8
set tabstop=2
set paste


filetype plugin indent on    " required

call plug#begin()
Plug 'rbong/vim-flog'
Plug 'preservim/nerdtree' |
            \ Plug 'Xuyuanp/nerdtree-git-plugin' |
            \ Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'tpope/vim-fugitive'
Plug 'wincent/command-t'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'preservim/tagbar'
Plug 'flazz/vim-colorschemes'
Plug 'ap/vim-css-color'
"Plug 'ycm-core/YouCompleteMe'
Plug 'preservim/tagbar'
call plug#end()

let g:airline_theme = 'cool'
let g:airline_powerline_fonts = 1
"let g:airline_statusline_ontop = 1
"let g:airline#extensions#tabline#enabled = 1
"let g:airline_section_b = '%-{getcwd()}'
let g:rainbow_active = 1


colorscheme blugrine 

" Start NERDTree, unless a file or session is specified, eg. vim -S session_file.vim.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') && v:this_session == '' | NERDTree | endif

let NERDTreeIgnore = [ '__pycache__', '\.pyc$', '\.o$', '\.swp',  '*\.swp',  'node_modules/' ]
let NERDTreeShowHidden=1
let g:indent_blankline_char_highlight_list = ['Error', 'Function']
