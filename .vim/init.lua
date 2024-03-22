-- Function to replicate noremap feature
local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}

    if opts then options = vim.tbl_extend('force', options, opts) end

    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
        {"vimwiki/vimwiki", branch = "dev"},
        "lervag/vimtex",

        -- Language Packs
        {"sheerun/vim-polyglot",
            init = function() vim.g.polyglot_disabled = {'latex'} end
        },

        -- LSP
        "neovim/nvim-lspconfig",

        -- Git
        'tpope/vim-fugitive',

        -- Rust
        {'rust-lang/rust.vim', ft = {'rust'},},
        {'mrcjkb/rustaceanvim', ft = {'rust'},},

        -- Autoformatting
        'chiel92/vim-autoformat',

        -- NERDTree
        {'preservim/nerdtree', config = function ()
            vim.api.nvim_exec(
                [[
                    nnoremap <silent> <C-n> :NERDTreeToggle<CR>
                ]], true)
            end,
            lazy = false,
        },


        -- Pandoc
        'vim-pandoc/vim-pandoc',
        'vim-pandoc/vim-pandoc-syntax',

        -- Fuzzy search
        {'junegunn/fzf'},
        {'junegunn/fzf.vim'},

        -- Autocompletion plugin
        'hrsh7th/nvim-cmp',

        -- LSP source for nvim-cmp
        'hrsh7th/cmp-nvim-lsp',

        -- Snippets source for nvim-cmp
        {'saadparwaiz1/cmp_luasnip', ft = {'lua'}},

        -- Snippets plugin
        {'L3MON4D3/LuaSnip', ft = {'lua'},},

        -- Base16
        {'chriskempson/base16-vim', config =
            function() vim.api.nvim_exec(
                [[
                    if exists('$BASE16_THEME')
                    \ && (!exists('g:colors_name') || g:colors_name != 'base16-$BASE16_THEME')
                        let base16colorspace=256
                        colorscheme base16-$BASE16_THEME
                    endif
	              ]],
                true)
	          end
        }
    })

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
