require("oil").setup {
  keymaps = {
    ["<esc>"] = "actions.close",
  },
}

vim.keymap.set("n", "-", "<Cmd>Oil<CR>")
