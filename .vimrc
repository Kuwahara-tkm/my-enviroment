call plug#begin("~/.vim/plugged")
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-git-status.vim'
Plug 'airblade/vim-gitgutter'
call plug#end()
set background=dark
set number
syntax on
colorscheme molokai
set t_Co=256
let g:airline_theme="simple"
let g:airline#extensions#tabline#enabled = 1
nmap <C-n> <Plug>AirlineSelectNextTab
let g:airline#extensions#default#layout = [[ 'a', 'b', 'c' ], ['z']]
nnoremap <C-f> :Fern . -reveal=% -drawer -toggle -width=40<CR>
highlight Visual ctermfg=black ctermbg=yellow
highlight LineNr ctermbg=NONE guibg=NONE
filetype plugin indent on
inoremap { {}<LEFT> 
inoremap [ []<LEFT> 
inoremap ( ()<LEFT> 
inoremap " ""<LEFT> 
inoremap ' ''<LEFT> 
set encoding=utf-8
set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=4
