" Remove any trailing whitespace that is in the file
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif
autocmd BufNewFile,BufRead *.cpp set formatprg=astyle\ -s4pA3wYfk1j\ --delete-empty-lines
autocmd BufNewFile,BufRead *.c set formatprg=astyle\ -s4pA3wYfk1j\ --delete-empty-lines
autocmd BufNewFile,BufRead *.py set formatprg=astyle\ -s4pA3wYfk1j\ --delete-empty-lines
autocmd BufNewFile,BufRead *.java set formatprg=astyle\ -s4pA3wYfk1j\ --delete-empty-lines

" Necessary for some vim stuff
set nocompatible

" This shows what you are typing as a command
set showcmd

" Needed for syntax highlighting
filetype off
filetype plugin on
syntax enable
set grepprg=grep\ -nH\ $*

" Latex
let g:tex_flavor = "latex"

" Autoindent
set autoindent

" Hid buffers when they are abandoned
set hidden

" Spaces instead of tab char
set expandtab
set smarttab

" Set tab length
set shiftwidth=4
set softtabstop=4

" Set english for spellcheck, but default to off
if !has('nvim')
    if version >= 700
        set spl=en spell
        set nospell
    endif
endif

" Tab completion stuff
set wildmenu
set wildmode=list:longest,full

" Enable mouse support in console
set mouse=a

" Make backspace work like other apps
set backspace=2

" Line numbers
set number

" Ignoring cases
set ignorecase

" Smartcase
set smartcase

" jj exits insert mode
inoremap jj <Esc>

" Incremental search
set incsearch

" Highlight searches
set hlsearch

" Highlight other parenthesis
highlight MatchParen ctermbg=4

" Personal favorite colorscheme
syntax enable
set background=dark
colorscheme solarized

if has('nvim')
    " Vim-Plug
    call plug#begin('~/.vim/plugged')

    Plug 'vim-scripts/vimwiki'
    Plug 'lervag/vimtex'

    " Language Packs
    Plug 'sheerun/vim-polyglot'

    " Completion
    Plug 'roxma/nvim-completion-manager'
    Plug 'roxma/ncm-clang'
    Plug 'roxma/nvim-cm-racer'

    " Rust
    Plug 'rust-lang/rust.vim'
    Plug 'racer-rust/vim-racer'
    Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
    call plug#end()

    let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'javascript.jsx': ['javascript-typescript-stdio'],
    \ }

    nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
    nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
    nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
else
    " Vundle
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()

    " Plugins
    Plugin 'vimwiki/vimwiki'
    Plugin 'lervag/vimtex'

    " Language Packs
    Plugin 'sheerun/vim-polyglot'

    " let Vundle manage Vundle
    Plugin 'VundleVim/Vundle.vim'
    call vundle#end()
endif

" Show matching braces
set showmatch

" Keep 5 lines on sides and top and bottom when off screen
set scrolloff=5
set sidescrolloff=5

" 1000 undos
set undolevels=1000

let $PAGER=''

" Search for tags recursively up
set tags=tags;/

" Function to look for cscope.out in parent directories
function! LoadCscope()
    let db = findfile("cscope.out", ".;")
    if (!empty(db))
        let path = strpart(db, 0, match(db, "/cscope.out$"))
        set nocscopeverbose " supress 'duplicate connection' error
        exe "cs add " . db . " " . path
        set cscopeverbose
    endif
endfunction
au BufEnter /* call LoadCscope()

" Diff Mode
if &diff
    " Diff options
    set diffopt+=iwhite
    set diffexpr=DiffW()
    function DiffW()
        let opt = ""
        if &diffopt =~ "icase"
            let opt = opt . " -i "
        endif
        if &diffopt =~ "iwhite"
            let opt = opt . " -wbB "
        endif
        call system("diff -a -d --binary " . opt .
            \ v:fname_in . " " . v:fname_new . " > " . v:fname_out)
    endfunction
endif

" Git
autocmd FileType gitcommit setlocal spell tw=72

" Latex
autocmd FileType tex setlocal spell tw=72

" Omni completion
set omnifunc=syntaxcomplete#Complete

filetype plugin indent on
syntax enable
