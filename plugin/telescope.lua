local actions = require "telescope.actions"
local layout = require "telescope.actions.layout"
local telescope = require "telescope"

telescope.setup {
  defaults = require("telescope.themes").get_dropdown {
    mappings = {
      i = {
        ["<Esc>"] = actions.close,
        ["<Tab>"] = layout.toggle_preview,
      },
    },
    preview = {
      hide_on_startup = true,
    },
  },
}

telescope.load_extension "fzf"

vim.keymap.set("n", "<Leader>fd", "<Cmd>Telescope find_files<CR>")
vim.keymap.set("n", "<Leader>fl", "<Cmd>Telescope live_grep<CR>")
vim.keymap.set("n", "<Leader>fb", "<Cmd>Telescope buffers<CR>")
vim.keymap.set("n", "<Leader>fh", "<Cmd>Telescope help_tags<CR>")
