call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'vim-airline/vim-airline'
Plug 'ap/vim-css-color'
"Plug 'ryanoasis/vim-devicons'
"Plug 'tc50cal/vim-terminal'

Plug 'mboughaba/i3config.vim'
Plug 'terminalnode/sway-vim-syntax'
Plug 'Fymyte/rasi.vim'

" --- color schemes
"Plug 'tomasr/molokai'
"Plug 'joshdick/onedark.vim'
"Plug 'ErichDonGubler/vim-sublime-monokai'
"Plug 'blueshirts/darcula' 
Plug 'dracula/vim', {'as': 'dracula'}

call plug#end()

command W :execute ':silent w !sudo tee % > /dev/null' | :edit!

syntax on
colorscheme dracula
let g:airline_theme='dracula'
" hi Normal ctermbg=none


set relativenumber
set number
set cursorline
set showcmd
set ignorecase
set nohlsearch

set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab
set showtabline=0

set encoding=utf-8
set nocompatible

"" --- airline configuration
"
"let g:airline_powerline_fonts = 1 "Включить поддержку Powerline шрифтов
"let g:airline#extensions#keymap#enabled = 1 "Не показывать текущий маппинг
"let g:airline_section_z = "\ue0a1:%l/%L Col:%c" "Кастомная графа положения курсора
"let g:Powerline_symbols='unicode' 
"let g:airline#extensions#xkblayout#enabled = 0 
"let g:airline#extensions#tabline#enabled = 1 "Показ всех буферов
"
"if !exists('g:airline_symbols')
"    let g:airline_symbols = {}
"endif
"
"" unicode symbols
"let g:airline_left_sep = '»'
"let g:airline_left_sep = '▶'
"let g:airline_right_sep = '«'
"let g:airline_right_sep = '◀'
"let g:airline_symbols.linenr = '␊'
"let g:airline_symbols.linenr = '␤'
"let g:airline_symbols.linenr = '¶'
"let g:airline_symbols.branch = '⎇'
"let g:airline_symbols.paste = 'ρ'
"let g:airline_symbols.paste = 'Þ'
"let g:airline_symbols.paste = '∥'
"let g:airline_symbols.whitespace = 'Ξ'
"
"" airline symbols
"let g:airline_left_sep = ''
"let g:airline_left_alt_sep = ''
"let g:airline_right_sep = ''
"let g:airline_right_alt_sep = ''
"let g:airline_symbols.branch = ''
"let g:airline_symbols.readonly = ''
"let g:airline_symbols.linenr = ''

" --- key bindings

nmap <C-s> :w <CR>
imap <C-s> <Esc>:w<CR>a

" --- my lua codding
map <C-Return> :bel terminal <CR>
map <C-b> :execute 'bel 10new +set\ nonumber \| 0read !lua' expand('%') <CR>

map <A-h> :bprevious <CR> 
map <A-l> :bnext <CR>

map <F1> :b 1 <CR>
map <F2> :b 2 <CR>
map <F3> :b 3 <CR>
map <F4> :b 4 <CR>
map <F5> :b 5 <CR>
map <F6> :b 6 <CR>
map <F7> :b 7 <CR>
map <F8> :b 8 <CR>
map <F9> :b 9 <CR>
map <F10> :b 10 <CR>

nnoremap <space> za

map ! :!
