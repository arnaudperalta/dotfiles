" CocInstall for coc plugins
call plug#begin()
Plug 'itchyny/lightline.vim'
Plug 'machakann/vim-sandwich'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'josa42/vim-lightline-coc'
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'romgrk/barbar.nvim'
Plug 'ellisonleao/gruvbox.nvim'
Plug 'github/copilot.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'Yggdroot/indentLine'
Plug 'APZelos/blamer.nvim'
Plug 'kdheepak/lazygit.nvim'
Plug 'easymotion/vim-easymotion'
Plug 'psliwka/vim-smoothie'
Plug 'puremourning/vimspector'
Plug 'airblade/vim-gitgutter'
Plug 'mhinz/vim-startify'
Plug 'numToStr/Comment.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'editorconfig/editorconfig-vim'
call plug#end()
set encoding=UTF-8
set clipboard+=unnamedplus
set noshowmode
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath


let g:indentLine_char = '│'
let g:indentLine_leadingSpaceEnable = 1
let g:indentLine_leadingSpaceChar = "."
let g:indentLine_setConceal = 0
let g:blamer_enabled = 1

let g:coc_global_extensions = [
    \ 'coc-explorer',
    \ 'coc-rust-analyzer',
    \ 'coc-phpls',
    \ 'coc-java',
    \ 'coc-java-debug'
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
colorscheme gruvbox
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

" Easymotion
map <space>d <Plug>(easymotion-bd-f)
nmap <space>d <Plug>(easymotion-overwin-f)

"Startup exec
autocmd User CocNvimInit :CocCommand explorer --position right --no-focus

" Lua config
lua << EOF
require('Comment').setup()
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "java" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF

source ~/.vimrc
