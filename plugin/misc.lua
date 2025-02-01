local set = vim.keymap.set

set("n", "<Leader>u", "<Cmd>UndotreeShow | UndotreeFocus<CR>")

set("n", "<C-h>", "<Cmd>TmuxNavigateLeft<CR>")
set("n", "<C-j>", "<Cmd>TmuxNavigateDown<CR>")
set("n", "<C-k>", "<Cmd>TmuxNavigateUp<CR>")
set("n", "<C-l>", "<Cmd>TmuxNavigateRight<CR>")
