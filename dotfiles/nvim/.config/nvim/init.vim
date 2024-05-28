if &compatible
    set nocompatible
endif

call plug#begin('~/.local/share/nvim/plugged')
    " vim unimpaired for various shortcuts
    Plug 'tpope/vim-unimpaired'
    " lightweight status line
    Plug 'vim-airline/vim-airline'
    " solarized for true color
    Plug 'frankier/neovim-colors-solarized-truecolor-only'
    " auto detect indent level
    Plug 'tpope/vim-sleuth'
    " automatically `:set paste` when pasting from clipboard
    Plug 'ConradIrwin/vim-bracketed-paste'
    " git status in the gutter
    Plug 'airblade/vim-gitgutter'
    " git manipulation from within vim
    Plug 'tpope/vim-fugitive'
    " unlock undotree
    Plug 'mbbill/undotree'
    " Strip whitespace by command
    Plug 'ntpeters/vim-better-whitespace'
    " fuzzy list searcher integration
    Plug 'junegunn/fzf.vim'
    " fzf
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    " vimwiki
    Plug 'vimwiki/vimwiki'
    " debugger plugin also supports pdb and bashdb
    Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh \| UpdateRemotePlugins' }
    " rust cargo commands
    Plug 'timonv/vim-cargo'
    " toml file highlighting
    Plug 'cespare/vim-toml'
    " cmake file highlighting
    Plug 'nickhutchinson/vim-cmake-syntax'
call plug#end()

set nomodeline

" normal filetype detection
filetype plugin on
filetype plugin indent on

" Enable syntax highlighting
syntax enable
" Enable syntax based code folding
set foldmethod=syntax
" Force groovy syntax for any file named 'Jenkinsfile'
au BufNewFile,BufRead Jenkinsfile setf groovy

" you can have edited buffers that aren't visible in a window
set hidden

" set the width of the dir explorer
let g:netrw_winsize = 25
" tree type (3) was cooler, but buggy, so use long listing type instead
let g:netrw_liststyle = 1
" open a file in the same window
let g:netrw_browse_split = 0
" show hidden files
let g:netrw_hide = 0
" deletes netrw's buffer once it's hidden (using ':q', for example)
autocmd FileType netrw setl bufhidden=delete

" airline displays all open buffer names on top if only one tab open
let g:airline#extensions#tabline#enabled = 1

" :RustFmt on save
let g:rustfmt_autosave = 1

" convert tabs to spaces
set autoindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
" allow toggling between local and default mode
function TabToggle()
  if &expandtab
    set shiftwidth=8
    set tabstop=8
    set softtabstop=0
    set noexpandtab
  else
    set shiftwidth=4
    set tabstop=4
    set softtabstop=4
    set expandtab
  endif
endfunction

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
" silent! makes nvim not choke if solarized isn't installed yet, particularly
" important for calling nvim in batch mode to install all the plugins in this
" file, one of which is solarized itself
silent! colorscheme solarized

" Highlight characters that go over 80 columns (by drawing a border on the 81st)
if exists('+colorcolumn')
    set colorcolumn=81
    highlight ColorColumn ctermbg=160 guibg=#D80000
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
set inccommand=nosplit " live preview for substitutions e.g.: :%s/foo/bar/

" strip whitespace on save
let g:strip_whitespace_on_save = 1
" but only on changed lines
let g:strip_only_modified_lines = 1
" and don't ask for confirmation
let g:strip_whitespace_confirm = 0

au BufRead,BufNewFile *.md setlocal textwidth=80

" show these non-normal whitespace chars as unicode chars
set listchars=eol:⏎,tab:␉·,trail:␠,nbsp:⎵

" vimsplit modifications
" easier navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" more natural split opening
set splitbelow
set splitright
" close a buffer without closing the current split
nnoremap <leader>d :b#\|bd #

" open undo tree with F5
nnoremap <F5> :UndotreeToggle<cr>

" put backups in global dir
set backupdir=~/.vimtmp/tmp/backupdir//,
" put swap files in global dir
set directory=~/.vimtmp/tmp/swapdir//,
" put undo files in global dir
set undodir=~/.vimtmp/tmp/undodir//,
set undofile

" search for tags in this directory or in any parent dir up to ~/
set tags=./tags;~/

function! LoadCscope()
  if has("cscope")
    set csprg=/usr/bin/cscope
    set csto=0
    set cst
    let db = findfile("cscope.out", ".;")
    if (!empty(db))
      let path = strpart(db, 0, match(db, "/cscope.out$"))
      set nocscopeverbose " suppress 'duplicate connection' error
      exe "cs add " . db . " " . path
      set cscopeverbose
    " else add the database pointed to by environment variable
    elseif $CSCOPE_DB != ""
      cs add $CSCOPE_DB
    endif
  endif
endfunction
au BufEnter /* call LoadCscope()


if &diff
    highlight! link DiffText MatchParen
endif

let g:vimwiki_list = [{'path': '~/vimwiki/'}]
let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]
