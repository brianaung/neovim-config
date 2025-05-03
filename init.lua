vim.cmd "colorscheme lunaperche"

-- {{{ Keymaps
vim.g.mapleader = vim.keycode "<Space>"
vim.g.maplocalleader = vim.keycode "<Space>"

vim.keymap.set("n", "<Esc>", "<Cmd>nohlsearch<CR>", { desc = "Clear search highlights" })

vim.keymap.set({ "n", "v" }, "<Leader>y", [["+y]], { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<Leader>p", [["+p]], { desc = "Paste from system clipboard" })

vim.keymap.set("v", "J", [[:m '>+1<CR>gv=gv]], { desc = "Move selected lines down" })
vim.keymap.set("v", "K", [[:m '<-2<CR>gv=gv]], { desc = "Move selected lines up" })

vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Re-center when scrolling up" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Re-center when scrolling down" })

vim.keymap.set("n", "<C-f>", "<Cmd>silent !tmux neww tmux-sessionizer<CR>")
-- }}}

-- {{{ Options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.breakindent = true

vim.opt.confirm = true

vim.opt.completeopt = { "fuzzy", "menuone", "noselect", "popup" }
vim.opt.shortmess:append "c"

vim.opt.list = true
vim.opt.listchars = { tab = "→ ", eol = "↲", nbsp = "␣", trail = "~" }
-- }}}

-- {{{ Autocmds
vim.api.nvim_create_autocmd({ "VimResized" }, {
  desc = "Resize splits if window got resized",
  group = vim.api.nvim_create_augroup("resize_splits", { clear = true }),
  callback = function()
    vim.cmd "tabdo wincmd ="
    vim.cmd("tabnext " .. vim.fn.tabpagenr())
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
  callback = function() vim.highlight.on_yank() end,
})
-- }}}

-- {{{ Paq
local paq_path = vim.fn.stdpath "data" .. "/site/pack/paqs/start/paq-nvim"
if vim.fn.empty(vim.fn.glob(paq_path)) then
  vim.fn.system { "git", "clone", "--depth=1", "https://github.com/savq/paq-nvim.git", paq_path }
end
vim.cmd.packadd "paq-nvim"
require "paq" {
  "savq/paq-nvim",
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  "neovim/nvim-lspconfig",
  "ibhagwan/fzf-lua",
  "stevearc/oil.nvim",
  "stevearc/conform.nvim",
  "tpope/vim-fugitive",
  "tpope/vim-sleuth",
  "mbbill/undotree",
  "christoomey/vim-tmux-navigator",
}
-- }}}

-- {{{ Treesitter
require("nvim-treesitter.configs").setup {
  highlight = {
    enable = true,
    disable = function(lang, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then return true end
    end,
  },
}
-- }}}

-- {{{ LSP
vim.lsp.config("*", {
  on_attach = function(client, bufnr)
    vim.keymap.set("n", "<Leader>gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Jump to definition" })
    vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Get available code actions" })
    vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename all references" })
    vim.keymap.set("n", "<Leader>se", vim.diagnostic.open_float, { buffer = bufnr, desc = "Show diagnostics window" })

    if client:supports_method "textDocument/completion" then
      local chars = {}
      for i = 32, 126 do
        table.insert(chars, string.char(i))
      end
      client.server_capabilities.completionProvider.triggerCharacters = chars
      vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
    end
  end,
})

vim.lsp.config("lua_ls", {
  settings = {
    ["Lua"] = { diagnostics = { globals = { "vim" } } },
  },
})
vim.lsp.enable "lua_ls"
-- }}}

-- {{{ FzfLua
vim.keymap.set("n", "<Leader>fd", "<Cmd>FzfLua files<CR>", { desc = "Search files" })
vim.keymap.set("n", "<Leader>fl", "<Cmd>FzfLua live_grep<CR>", { desc = "Search for strings/regexes" })
vim.keymap.set("n", "<Leader>fb", "<Cmd>FzfLua buffers<CR>", { desc = "Search buffers" })
vim.keymap.set("n", "<Leader>fh", "<Cmd>FzfLua help_tags<CR>", { desc = "Search help tags" })
-- }}}

-- {{{ Oil
require("oil").setup()
vim.keymap.set("n", "-", "<Cmd>Oil<CR>", { desc = "Open files drawer" })
-- }}}

-- {{ Conform
require("conform").setup {
  formatters_by_ft = {
    lua = { "stylua" },
  },
  format_after_save = {
    lsp_fallback = false,
    timeout_ms = 500,
    async = true,
  },
}
-- }}}

-- {{{ TmuxNavigator
vim.keymap.set("n", "<C-h>", "<Cmd>TmuxNavigateLeft<CR>", { desc = "Navigate left to vim/tmux window" })
vim.keymap.set("n", "<C-j>", "<Cmd>TmuxNavigateDown<CR>", { desc = "Navigate down to vim/tmux window" })
vim.keymap.set("n", "<C-k>", "<Cmd>TmuxNavigateUp<CR>", { desc = "Navigate up to vim/tmux window" })
vim.keymap.set("n", "<C-l>", "<Cmd>TmuxNavigateRight<CR>", { desc = "Navigate right to vim/tmux window" })
-- }}}
