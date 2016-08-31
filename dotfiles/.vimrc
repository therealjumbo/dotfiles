" get rid of Vi compatibility, SET FIRST!
set nocompatible

" pathogen stuff
execute pathogen#infect()

" you can have edited buffers that aren't visible in a window
set hidden

" open a NERDTree automatically when vim starts up if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" remap ESC to jk
inoremap jk <ESC>

"convert tabs to spaces
set expandtab
set tabstop=4
set shiftwidth=4

" remap leader key to space
let mapleader = "\<Space>"

" Events
" In makefiles DO NOT use spaces instead of tabs
autocmd FileType make setlocal noexpandtab

" Enable omnicompletion (to use, hold Ctrl-X then Ctrl-O while in insert mode)
set ofu=syntaxcomplete#Complete

" Theme/Colors
" solarized color scheme stuff
set background=dark
colorscheme solarized
set t_Co=16

" Prettify JSON files
autocmd BufRead,BufNewFile *.json set filetype=json
autocmd Syntax json sou ~/.vim/syntax/json.vim

" Prettify Vagrantfile
autocmd BufRead,BufNewFile Vagrantfile set filetype=ruby

" Prettify Markdown files
let vim_markdown_preview_github=1
"augroup markdown
"    au!
"    au BufnewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
" augroup END

" Highlight characters that go over 80 columns (by drawing a border on the 81st)
if exists('+colorcolumn')
    set colorcolumn=81
    highlight ColorColumn ctermbg=red
else
    highlight OverLength ctermbg=red ctermfg=white guibg=#592929
    match OverLength /\%81v.\+/
endif

" syntax highlighting
syntax on

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

" bug fix for Python Mode error with rope
let g:pymode_rope = 0

" close preview window after selection is made
autocmd CompleteDone * pclose

" strip whitespace from these filetypes on save
autocmd FileType c,h,cpp,py,lua,java,sh,bat,ps1,md autocmd BufWritePre <buffer> StripWhitespace

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


