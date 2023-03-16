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
vim.api.nvim_set_keymap('i', '<Tab>',   [[pumvisible() ? "\<C-n>" : "\<Tab>"]],   { noremap = true, expr = true })
vim.api.nvim_set_keymap('i', '<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { noremap = true, expr = true })
local keys = {
  ['cr']        = vim.api.nvim_replace_termcodes('<CR>', true, true, true),
  ['ctrl-y']    = vim.api.nvim_replace_termcodes('<C-y>', true, true, true),
  ['ctrl-y_cr'] = vim.api.nvim_replace_termcodes('<C-y><CR>', true, true, true),
}
_G.cr_action = function()
  if vim.fn.pumvisible() ~= 0 then
    -- If popup is visible, confirm selected item or add new line otherwise
    local item_selected = vim.fn.complete_info()['selected'] ~= -1
    return item_selected and keys['ctrl-y'] or keys['ctrl-y_cr']
  else
    -- If popup is not visible, use plain `<CR>`. You might want to customize
    -- according to other plugins. For example, to use 'mini.pairs', replace
    -- next line with `return require('mini.pairs').cr()`
    return keys['cr']
  end
end
vim.api.nvim_set_keymap('i', '<CR>', 'v:lua._G.cr_action()', { noremap = true, expr = true })
vim.o.termguicolors = true
vim.cmd('colorscheme onedark')
