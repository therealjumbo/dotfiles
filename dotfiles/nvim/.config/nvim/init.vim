if &compatible
  set nocompatible
endif

call plug#begin('~/.local/share/nvim/plugged')

    " Strip whitespace by command
    Plug 'ntpeters/vim-better-whitespace'

    " solarized for true color
    Plug 'frankier/neovim-colors-solarized-truecolor-only'

    " lightweight status line
    Plug 'vim-airline/vim-airline'

    " auto detect indent level
    Plug 'tpope/vim-sleuth'

    Plug 'kergoth/vim-bitbake'

    " rust cargo commands
    Plug 'timonv/vim-cargo'

    " rust code completion and navigation
    Plug 'racer-rust/vim-racer'

    " generic syntax checker
    Plug 'vim-syntastic/syntastic'

    " rust plugin for syntastic
    Plug 'rust-lang/rust.vim'

    " plugin for toml syntax
    Plug 'cespare/vim-toml'

call plug#end()

" normal filetype detection
filetype plugin indent on

" syntax highlighting
if !exists("g:syntax_on")
    syntax enable
endif

" you can have edited buffers that aren't visible in a window
set hidden

" airline displays all open buffer names on top if only one tab open
let g:airline#extensions#tabline#enabled = 1

" :RustFmt on save
let g:rustfmt_autosave = 1

"convert tabs to spaces
set expandtab
set tabstop=4
set shiftwidth=4

" :e <tab> autocomplete is case insensitive
set wildignorecase

" remap leader key to space
let mapleader = "\<Space>"

" Events
" In makefiles DO NOT use spaces instead of tabs
autocmd FileType make setlocal noexpandtab

" Theme/Colors
" set true color
set termguicolors
" solarized color scheme stuff
set background=dark " or light
colorscheme solarized

" Highlight characters that go over 80 columns (by drawing a border on the 81st)
if exists('+colorcolumn')
    set colorcolumn=81
    highlight ColorColumn ctermbg=red
else
    highlight OverLength ctermbg=red ctermfg=white guibg=#592929
    match OverLength /\%81v.\+/
endif


" Vim UI
set number " show line numbers
set numberwidth=6 " make the number gutter 6 chars wide
set cul " highlight current line
set laststatus=2 " last window always has a statusline
set hlsearch " continue to highlight searched phrases
set incsearch " highlight as you type your search
set ignorecase " make searches case-insensitive
set ruler " always show info along bottom
set showmatch
set statusline=%<%f\%h%m%r%=%-20.(line=%l\ \ col=%c%V\ \ totlin=%L%)\ \ \%h%m%r%=%-40(bytval=0x%B,%n%Y%)\%P
set visualbell
set nowrap " don't wrap text

" strip whitespace from these filetypes on save
autocmd FileType c,h,cpp,hpp,cxx,py,lua,java,sh,bat,ps1,md autocmd BufWritePre <buffer> StripWhitespace

" vimsplit modifications
" easier navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" more natural split opening
set splitbelow
set splitright

" put backups in global dir
set backupdir=~/.vim/tmp//,
" put swap files in global dir
set directory=~/.vim/tmp//,
" put undo files in global dir
set undodir=~/.vim/tmp//,

" search for tags in this directory or in any parent dir up to ~/workspace
set tags=./tags;~/workspace
