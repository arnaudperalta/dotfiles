" CocInstall for coc plugins
call plug#begin()
Plug 'tpope/vim-surround' " Classic surround plugin
Plug 'neoclide/coc.nvim', { 'branch': 'release' } " Coc
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
call plug#end()

set encoding=UTF-8
set clipboard+=unnamedplus
set noshowmode
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
colorscheme onedark


let g:indentLine_char = '│'
let g:indentLine_leadingSpaceEnable = 1
let g:indentLine_leadingSpaceChar = "."

let g:blamer_enabled = 1

let g:coc_global_extensions = [
    \ 'coc-explorer',
    \ 'coc-rust-analyzer',
    \ 'coc-phpls',
    \ 'coc-java',
    \ 'coc-java-debug',
    \ 'coc-java-lombok'
\ ]

let g:copilot_filetypes = {
        \ 'rs': v:false,
\ }

" Java Debugger
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

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" coc.nvim suggestions
inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

set termguicolors
hi Normal ctermbg=NONE guibg=NONE

" barbar
nnoremap <silent>    <A-h> :BufferPrevious<CR>
nnoremap <silent>    <A-l> :BufferNext<CR>
nnoremap <silent> <space>w :BufferClose<CR>

" coc
nmap <space>e <Cmd>CocCommand explorer --focus --position right<CR>
nnoremap <space>i <Cmd>CocCommand editor.action.organizeImport

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

" Vimspector
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

" Easymotion
map <space>d <Plug>(easymotion-bd-f)
nmap <space>d <Plug>(easymotion-overwin-f)

"Startup exec
autocmd User CocNvimInit :CocCommand explorer --position right --no-focus

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
EOF

source ~/.vimrc
