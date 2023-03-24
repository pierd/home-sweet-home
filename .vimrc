colorscheme wombat256mod
set autoindent
set smartindent
set nu
set shiftwidth=4
set smarttab
set expandtab
filetype indent on
"autocmd FileType python compiler pylint
autocmd FileType make set noexpandtab
autocmd FileType javascript set shiftwidth=2
set incsearch
set hlsearch
set colorcolumn=80
set ruler
set guifont=Monaco:h13

syntax on

" Syntastic settings
let g:syntastic_auto_loc_list=1
"let g:syntastic_javascript_closure_compiler_path = '/path/to/google-closure-compiler.jar'
