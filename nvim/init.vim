call plug#begin()
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
 Plug 'honza/vim-snippets'
 Plug 'tpope/vim-surround'
 Plug 'lambdalisue/suda.vim'

"Syntax: 
 Plug 'Valloric/YouCompleteMe'
 Plug 'pangloss/vim-javascript'
 Plug 'w0rp/ale'

 Plug 'mboughaba/i3config.vim'
 Plug 'terminalnode/sway-vim-syntax'

"Appearance:
 Plug 'vim-airline/vim-airline'
 Plug 'vim-airline/vim-airline-themes'
 Plug 'ryanoasis/vim-devicons'
 Plug 'ap/vim-css-color'

"Colorthemes:
 Plug 'tomasr/molokai'
 Plug 'morhetz/gruvbox'
 Plug 'jonathanfilip/vim-lucius'  " nice white colortheme
 Plug 'morhetz/gruvbox'
 Plug 'ghifarit53/tokyonight-vim' "Tokyonight theme
 Plug 'dracula/vim'
 Plug 'joshdick/onedark.vim' "Onedark
call plug#end()

colorscheme onedark
let g:airline_theme = 'onedark'

let mapleader=" "
map <leader>l

set undofile
set undodir=~/.vim/undodir

set nocompatible
set showmatch  
set ignorecase
set smartcase
set mouse=v  
set nohlsearch
set incsearch 
set tabstop=4
set softtabstop=4 
set shiftwidth=4 
set autoindent
set relativenumber
set number       
set wildmode=longest,list
filetype plugin indent on
syntax on               
set mouse=a            
filetype plugin on
set cursorline        
set clipboard=unnamedplus " using system clipboard
" set spell                 " enable spell check (may need to download language package)
" set noswapfile            " disable creating swap file
set backupdir=~/.cache/vim  " Directory to store backup files.


let b:ale_fixers = ['eslint']
let g:ale_fix_on_save = 1

" --- keybindings
command W execute ':SudaWrite'


nmap <C-s> :w <CR>
imap <C-s> <Esc>:w<CR>a

map <A-1> :b 1 <CR>
map <A-2> :b 2 <CR>
map <A-3> :b 3 <CR>
map <A-4> :b 4 <CR>
map <A-5> :b 5 <CR>
map <A-6> :b 6 <CR>
map <A-7> :b 7 <CR>
map <A-8> :b 8 <CR>
map <A-9> :b 9 <CR>
map <A-0> :b 10 <CR>

map <A-h> :bprevious <CR>
map <A-l> :bnext <CR>

nmap ! :!

nnoremap Q <nop>

" --- airline configuration
let g:airline_powerline_fonts = 1
let g:airline#extensions#keymap#enabled = 1
let g:airline_section_z = "\ue0a1:%l/%L Col:%c"
let g:Powerline_symbols='unicode'
let g:airline#extensions#xkblayout#enabled = 0
let g:airline#extensions#tabline#enabled = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" --- force syntax highligting for files
au BufReadPost ~/.config/waybar/config set syntax=json
au BufReadPost ~/.config/sway/config set syntax=i3config
