" Remove any trailing whitespace that is in the file
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

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

" Hide buffers when they are abandoned
set hidden

" Spaces instead of tab char
set expandtab
set smarttab

" Set tab length
set shiftwidth=4
set softtabstop=4

" Set English for spell check, default to on
if !has('nvim')
    if version >= 700
        set spl=en
    endif
else
    set spl=en
endif

" Tab completion stuff
set wildmenu
set wildmode=list:longest,full

" Enable mouse support in console
set mouse=a

" Make backspace work like other apps
set backspace=2

" Line numbers -- hybrid
set number relativenumber

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

" Enable syntax highlighting
syntax enable

" Vim-Plug
call plug#begin('~/.vim/plugged')

Plug 'vimwiki/vimwiki', {
            \ 'branch': 'dev'
            \ }
Plug 'lervag/vimtex'

Plug 'tbabej/taskwiki'

" Language Packs
Plug 'sheerun/vim-polyglot'

" Completion
if has('nvim')
    Plug 'ncm2/ncm2'
    Plug 'roxma/nvim-yarp'

    " enable ncm2 for all buffers
    autocmd BufEnter * call ncm2#enable_for_buffer()

    " IMPORTANT: :help Ncm2PopupOpen for more information
    set completeopt=noinsert,menuone,noselect

    " Specific completion plugins
    Plug 'ncm2/ncm2-bufword'
    Plug 'ncm2/ncm2-tmux'
    Plug 'ncm2/ncm2-path'
    Plug 'ncm2/ncm2-racer'
    Plug 'ncm2/ncm2-pyclang'
endif

" Git
Plug 'tpope/vim-fugitive'

" Rust
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'
Plug 'autozimu/LanguageClient-neovim', {
            \ 'branch': 'next',
            \ 'do': 'bash install.sh',
            \ }

" Base16
Plug 'chriskempson/base16-vim'

Plug 'chiel92/vim-autoformat'

Plug 'scrooloose/nerdtree'
nmap <silent> <C-n> :NERDTreeToggle<CR>

" Pandoc
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

call plug#end()

let g:racer_experimental_completer = 1

let g:LanguageClient_serverCommands = {
            \ 'rust': ['rust-analyzer'],
            \ }

nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

let g:vimtex_view_method = 'zathura'
let g:polyglot_disabled = ['latex']

" Base16
if filereadable(expand("~/.vimrc_background"))
    let base16colorspace=256
    source ~/.vimrc_background
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
autocmd FileType gitcommit setlocal spell tw=80

" Latex
autocmd FileType tex setlocal spell tw=80

" Txt
autocmd FileType text setlocal spell tw=80

" Markdown
autocmd FileType markdown setlocal spell tw=80

" Vimwiki
autocmd FileType vimwiki setlocal spell tw=80

" Omni completion
set omnifunc=syntaxcomplete#Complete

filetype plugin indent on
syntax enable

" Column set at 80
if exists('+colorcolumn')
    set colorcolumn=80
endif

" Toggle the conceal level
function! ToggleConcealLevel()
    if &conceallevel == 0
        setlocal conceallevel=2
    else
        setlocal conceallevel=0
    endif
endfunction

nnoremap <silent> <C-c><C-c> :call ToggleConcealLevel()<CR>
