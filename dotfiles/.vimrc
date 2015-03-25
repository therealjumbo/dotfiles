" get rid of Vi compatibility, SET FIRST!
set nocompatible 

" pathogen stuff
execute pathogen#infect()

" Events
" In makefiles DO NOT use spaces instead of tabs
autocmd FileType make setlocal noexpandtab
" In Ruby files, use 2 spaces instead of 4 for tabs
autocmd FileType ruby setlocal sw=2 ts=2 sts=2

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
augroup markdown
    au!
    au BufnewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END

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
set nohlsearch " don't continue to highlight searched phrases
set incsearch " but do highlight as you type your search
set ignorecase " make searches case-insensitive
set ruler " always show info along bottom
set showmatch
set statusline=%<%f\%h%m%r%=%-20.(line=%l\ \ col=%c%V\ \ totlin=%L%)\ \ \%h%m%r%=%-40(bytval=0x%B,%n%Y%)\%P
set visualbell

" Text formatting/layout
set smartindent
set tabstop=4 " tab spacing
set shiftwidth=4 " indent/outdent by 4 columns
set softtabstop=4 " unify
set expandtab " use spaces instead of tabs
set shiftround " always indent/outdent to the nearest tabstop
set nowrap "don't wrap text

" custom commands
" prettify JSON files making them easier to read
command PrettyJSON %!python -m json.tool

" bug fix for Python Mode error with rope
let g:pymode_rope_lookup_project = 0

" close preview window after selection is made
autocmd CompleteDone * pclose
