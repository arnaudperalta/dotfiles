vim.cmd('source ~/.vimrc')

require('plugins')
require('lsp')
require('tree')
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
require('mini.starter').setup()
require('mini.tabline').setup()
require('mini.comment').setup()
require('mini.indentscope').setup()
require('mini.trailspace').setup()
require('mini.move').setup()
require('mini.completion').setup()
require('gitsigns').setup()
require'lspconfig'.tsserver.setup {}

vim.api.nvim_set_keymap('n', '<space>ff', ':Telescope git_files hidden=true <CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<space>fg', ':Telescope live_grep hidden=true <CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<space>w', ':bp|bd #<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<space>e', ':NvimTreeFindFileToggle <CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<space>gg', ':LazyGit <CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<M-h>', ':bpre <CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<M-l>', ':bnext <CR>', { noremap = true, silent = true })
vim.api.nvim_command([[
    augroup ChangeBackgroudColour
        autocmd colorscheme * :hi normal guibg=#1D1F21
    augroup END
]])
vim.o.termguicolors = true
vim.cmd('colorscheme onedark')
