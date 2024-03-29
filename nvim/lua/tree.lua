-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    width = 50,
    mappings = {
      list = {
        { key = "l", action = "open" },
        { key = "h", action = "open" },
      },
    },
    side = "right"
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
    custom = { '^.git$' }
  },
  diagnostics = {
    enable = true
  },
  git = {
    ignore = false
  }
})
