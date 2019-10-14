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

    " git status in the gutter
    Plug 'airblade/vim-gitgutter'

    " git manipulation from within vim
    Plug 'tpope/vim-fugitive'

    " vim unimpaired for various shortcuts
    Plug 'tpope/vim-unimpaired'

    " unlock undotree
    Plug 'mbbill/undotree'

    " bitbake file highlighting
    Plug 'kergoth/vim-bitbake'
    " cmake file highlighting
    Plug 'nickhutchinson/vim-cmake-syntax'

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

    " vimwiki
    Plug 'vimwiki/vimwiki'

    Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

    Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh \| UpdateRemotePlugins' }

call plug#end()

set nomodeline

" normal filetype detection
filetype plugin on
filetype plugin indent on

" Enable syntax highlighting
syntax enable
" Force groovy syntax for any file named 'Jenkinsfile'
au BufNewFile,BufRead Jenkinsfile setf groovy

" you can have edited buffers that aren't visible in a window
set hidden

" hide the netrw banner
let g:netrw_banner = 0
" set the width of the dir explorer
let g:netrw_winsize = 25
" set preferred view type to tree type for netrw
let g:netrw_liststyle = 3
" open a file in the previous window
let g:netrw_browse_split = 4
" open file in a vertical split on the right
let g:netrw_altv = 1
" hide these filetypes in the dir explorer
let g:netrw_list_hide = '.git,.sass-cache,.jpg,.png,.svg'
" Per default, netrw leaves unmodified buffers open. This autocommand
" deletes netrw's buffer once it's hidden (using ':q', for example)
autocmd FileType netrw setl bufhidden=delete

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
set backupdir=~/.vim/tmp/backupdir//,
" put swap files in global dir
set directory=~/.vim/tmp/swapdir//,
" put undo files in global dir
set undodir=~/.vim/tmp/undodir//,
set undofile

" search for tags in this directory or in any parent dir up to ~/
set tags=./tags;~/

if &diff
    highlight! link DiffText MatchParen
endif

" syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let pyenv = $PYENV_ROOT
let g:python_host_prog = pyenv . '/versions/neovim2/bin/python'
let g:python3_host_prog = pyenv . '/versions/neovim3/bin/python'

let g:vimwiki_list = [{'path': '~/vimwiki/'}]
let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]

" LanguageClient-neovim and deoplete settings
" Always draw the signcolumn.
set signcolumn=yes

let g:deoplete#enable_at_startup = 1

function SetLSPShortcuts()
  nnoremap <leader>ld :call LanguageClient#textDocument_definition()<CR>
  nnoremap <leader>lr :call LanguageClient#textDocument_rename()<CR>
  nnoremap <leader>lf :call LanguageClient#textDocument_formatting()<CR>
  nnoremap <leader>lt :call LanguageClient#textDocument_typeDefinition()<CR>
  nnoremap <leader>lx :call LanguageClient#textDocument_references()<CR>
  nnoremap <leader>la :call LanguageClient_workspace_applyEdit()<CR>
  nnoremap <leader>lc :call LanguageClient#textDocument_completion()<CR>
  nnoremap <leader>lh :call LanguageClient#textDocument_hover()<CR>
  nnoremap <leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>
  nnoremap <leader>lm :call LanguageClient_contextMenu()<CR>
endfunction()

augroup LSP
  autocmd!
  autocmd FileType cpp,c call SetLSPShortcuts()
augroup END

let g:LanguageClient_serverCommands = {
  \ 'rust': ['~/.cargo/bin/rustup', 'run', 'nightly', 'rls'],
  \ 'cpp': ['clangd'],
  \ 'python': ['~/.local/bin/pyls'],
  \ }
