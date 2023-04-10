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
require('gitsigns').setup {
  current_line_blame = true
}

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "go", "rust", "graphql", "typescript" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,
    disable = { },
    additional_vim_regex_highlighting = false,
  },
}

local cmp = require('cmp')
local icons = {
  Array = '  ',
  Boolean = '  ',
  Class = '  ',
  Color = '  ',
  Constant = '  ',
  Constructor = '  ',
  Enum = '  ',
  EnumMember = '  ',
  Event = '  ',
  Field = '  ',
  File = '  ',
  Folder = '  ',
  Function = '  ',
  Interface = '  ',
  Key = '  ',
  Keyword = '  ',
  Method = '  ',
  Module = '  ',
  Namespace = '  ',
  Null = ' ﳠ ',
  Number = '  ',
  Object = '  ',
  Operator = '  ',
  Package = '  ',
  Property = '  ',
  Reference = '  ',
  Snippet = '  ',
  String = '  ',
  Struct = '  ',
  Text = '  ',
  TypeParameter = '  ',
  Unit = '  ',
  Value = '  ',
  Variable = '  ',
}

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    end,
  },
  formatting = {
    fields = { 'kind', 'abbr', 'menu' },
    format = function(entry, item)
      item.kind = string.format('%s', icons[item.kind])
      item.menu = ({
        buffer = '[Buffer]',
        luasnip = '[Snip]',
        nvim_lsp = '[LSP]',
        nvim_lua = '[API]',
        path = '[Path]',
        rg = '[RG]',
      })[entry.source.name]
      return item
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
  }, {
    { name = 'buffer' },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require('lspconfig').gopls.setup {
  capabilities = capabilities
}

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
