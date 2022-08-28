" CocInstall for coc plugins
call plug#begin()
Plug 'tpope/vim-surround' " Classic surround plugin
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}} " Coc
Plug 'kyazdani42/nvim-web-devicons' " Cool icons
Plug 'romgrk/barbar.nvim' " Buffer bar
Plug 'nvim-lua/plenary.nvim' " Telescope dependency
Plug 'nvim-telescope/telescope.nvim' " Fuzzy finder + grep
Plug 'Yggdroot/indentLine' " Indention indicators
Plug 'APZelos/blamer.nvim' " Git blame
Plug 'kdheepak/lazygit.nvim' " LG integration
Plug 'easymotion/vim-easymotion' "Easy motion
Plug 'psliwka/vim-smoothie' " Smooth scrolling
Plug 'puremourning/vimspector' " Debugger
Plug 'airblade/vim-gitgutter' " Git line informations
Plug 'mhinz/vim-startify' " Start menu
Plug 'numToStr/Comment.nvim' " Comments
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " Code parsing
Plug 'nvim-lualine/lualine.nvim'
Plug 'apalmer1377/factorus' " Class / Methods refactoring
Plug 'rafi/awesome-vim-colorschemes' " Colorschemes
Plug 'scalameta/nvim-metals'
call plug#end()

set encoding=UTF-8
set clipboard+=unnamedplus
set noshowmode
set runtimepath^=~/.vim runtimepath+=~/.vim/after
set signcolumn=yes
let &packpath=&runtimepath
colorscheme onedark
set termguicolors
hi Normal ctermbg=NONE guibg=NONE

let g:indentLine_char = '│'
let g:indentLine_leadingSpaceEnable = 1
let g:indentLine_leadingSpaceChar = "."

let g:blamer_enabled = 1
let g:startify_change_to_dir = 0

" Vimspector
let g:vimspector_adapters = {
            \ "java-debug-server": {
                \ "name": "vscode-java",
                \ "port": "${AdapterPort}"
            \ }
\ }

let g:vimspector_configurations = {
            \ "Java Attach": {
                \ "default": "true",
                \ "adapter": "java-debug-server",
                \ "configuration": {
                    \ "request": "attach",
                    \ "host": "127.0.0.1",
                    \ "port": "5005"
                \ },
                \ "breakpoints": {
                    \ "exception": {
                        \ "caught": "N",
                        \ "uncaught": "N"
                    \ }
                \ }
            \ }
\ }
nmap <F1> :CocCommand java.debug.vimspector.start<CR>
nmap <F2> <Plug>VimspectorToggleBreakpoint
nmap <F3> <Plug>VimspectorContinue
nmap <F4> :VimspectorReset<CR>

let g:vimspector_sign_priority = {
            \    'vimspectorBP':         999,
            \    'vimspectorBPCond':     999,
            \    'vimspectorBPLog':      999,
            \    'vimspectorBPDisabled': 999,
            \    'vimspectorPC':         999,
            \ }


" barbar
nnoremap <silent>    <A-h> :BufferPrevious<CR>
nnoremap <silent>    <A-l> :BufferNext<CR>
nnoremap <silent> <space>w :BufferClose<CR>

" telescope
nnoremap <space>ff :Telescope git_files hidden=true <CR>
nnoremap <space>fg :Telescope live_grep hidden=true <CR>

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" lazygit
nnoremap <silent> <space>gg :LazyGit<CR>

" Prettier
nnoremap <silent> <space>pf :CocCommand prettier.formatFile<CR>

" Easymotion
map <space>d <Plug>(easymotion-bd-f)
nmap <space>d <Plug>(easymotion-overwin-f)

" Lua config
lua << EOF
require('Comment').setup()
require'nvim-treesitter.configs'.setup {
    ensure_installed = { "java" },
    sync_install = false,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = false,
  },
  sections = {

    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}
-- Scala Metals
vim.opt_global.shortmess:remove("F")
local metals_config = require("metals").bare_config()
local api = vim.api
local cmd = vim.cmd
metals_config.settings = {
  showImplicitArguments = true
}
metals_config.init_options.statusBarProvider = "on"

local nvim_metals_group = api.nvim_create_augroup("nvim-metals", { clear = true })
api.nvim_create_autocmd("FileType", {
  pattern = { "scala", "sbt" },
  callback = function()
    require("metals").initialize_or_attach(metals_config)
  end,
  group = nvim_metals_group,
})
EOF

source ~/.config/nvim/coc.vim
source ~/.vimrc
