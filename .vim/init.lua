-- Function to replicate noremap feature
local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}

    if opts then options = vim.tbl_extend('force', options, opts) end

    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Ensure packer is installed
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    -- My plugins here

    use {'vimwiki/vimwiki', branch = 'dev'}
    use 'lervag/vimtex'
    vim.g.vimtex_view_method = 'zathura'

    -- Language Packs
    vim.g.polyglot_disabled = {'latex'}
    use 'sheerun/vim-polyglot'

    -- LSP
    use 'neovim/nvim-lspconfig'

    -- Git
    use 'tpope/vim-fugitive'

    -- Rust
    use 'rust-lang/rust.vim'

    -- Autoformatting
    use 'chiel92/vim-autoformat'

    use 'scrooloose/nerdtree'
    map("n", "<silent> <C-n>", ":NERDTreeToggle<CR>")

    -- Pandoc
    use 'vim-pandoc/vim-pandoc'
    use 'vim-pandoc/vim-pandoc-syntax'

    -- Fuzzy search
    use 'junegunn/fzf'

    -- Autocompletion plugin
    use 'hrsh7th/nvim-cmp'

    -- LSP source for nvim-cmp
    use 'hrsh7th/cmp-nvim-lsp'

    -- Snippets source for nvim-cmp
    use 'saadparwaiz1/cmp_luasnip'

    -- Snippets plugin
    use 'L3MON4D3/LuaSnip'

    -- Base16
    use 'chriskempson/base16-vim'
    vim.api.nvim_exec(
        [[
            if filereadable(expand("~/.vimrc_background"))
                let base16colorspace=256
                source ~/.vimrc_background
            endif
        ]],
        true)

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)

-- Remove any trailing whitespace that is in the file
vim.cmd[[autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif]]

-- This shows what you are typing as a command
vim.opt.showcmd = true

-- Needed for syntax highlighting
vim.cmd[[filetype off]]
vim.cmd[[filetype plugin on]]
vim.cmd[[syntax enable]]

-- Latex
vim.g.tex_flavor = "latex"

-- Spaces instead of tab char
vim.opt.expandtab = true
vim.opt.smarttab = true

-- Set tab length
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

-- Set English for spell check, default to on
vim.opt.spl = "en"

-- Tab completion stuff
vim.opt.wildmode = {"list", "longest", "full"}

-- Enable mouse support in console
vim.opt.mouse = "a"

-- Make backspace work like other apps
vim.opt.backspace = {"indent", "eol", "start"}

-- Line numbers -- hybrid
vim.opt.number = true
vim.opt.relativenumber = true

-- Ignoring cases
vim.opt.ignorecase = true

-- Smartcase
vim.opt.smartcase = true

-- jj/jk exits insert mode
map("i", "jj", "<Esc>")
map("i", "jk", "<Esc>")

-- Highlight other parenthesis
vim.cmd[[highlight MatchParen ctermbg=4]]

-- Show matching braces
vim.opt.showmatch = true

-- Keep 5 lines on sides and top and bottom when off screen
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5

-- Search for tags recursively up
vim.opt.tags="tags;/"

-- Function to look for cscope.out in parent directories
vim.api.nvim_exec(
    [[
        function! LoadCscope()
            let db = findfile("cscope.out", ".;")
            if (!empty(db))
                let path = strpart(db, 0, match(db, "/cscope.out$"))
                set nocscopeverbose -- supress 'duplicate connection' error
                exe "cs add " . db . " " . path
                set cscopeverbose
            endif
        endfunction
        au BufEnter /* call LoadCscope()
    ]],
    true)

-- Diff Mode
vim.api.nvim_exec(
    [[
        if &diff
            set diffopt+=iwhite
            set diffexpr=DiffW()
            function DiffW()
                let opt = --"
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
    ]],
    true)

-- Git
vim.cmd[[autocmd FileType gitcommit setlocal spell tw=80]]

-- Latex
vim.cmd[[autocmd FileType tex setlocal spell tw=80]]

-- Txt
vim.cmd[[autocmd FileType text setlocal spell tw=80]]

-- Markdown
vim.cmd[[autocmd FileType markdown setlocal spell tw=80]]

-- Vimwiki
vim.cmd[[autocmd FileType vimwiki setlocal spell tw=80]]

vim.cmd[[filetype plugin indent on]]

-- Column set at 80
vim.opt.colorcolumn = "80"
