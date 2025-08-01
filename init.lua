-- {{{ Keymaps
vim.g.mapleader = vim.keycode "<Space>"
vim.g.maplocalleader = vim.keycode "<Space>"

vim.keymap.set("n", "<Esc>", "<Cmd>nohlsearch<CR>")
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")
vim.keymap.set({ "n", "v" }, "<Leader>y", [["+y]])
vim.keymap.set("n", "<Leader>p", [["+p]])
vim.keymap.set("v", "J", [[:m '>+1<CR>gv=gv]])
vim.keymap.set("v", "K", [[:m '<-2<CR>gv=gv]])
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-f>", "<Cmd>silent !tmux neww tmux-sessionizer<CR>")
-- }}}

-- {{{ Options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.virtualedit = "all"
vim.opt.scrolloff = 5
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.breakindent = true
vim.opt.confirm = true
vim.opt.completeopt = { "fuzzy", "menuone", "noselect", "popup" }
vim.opt.shortmess:append "c"
vim.opt.wildoptions:remove "pum"
vim.opt.list = true
vim.opt.listchars = { tab = "→ ", eol = "↲", nbsp = "␣", trail = "~" }
-- }}}

-- {{{ Autocmds
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = vim.api.nvim_create_augroup("resize_splits", { clear = true }),
  callback = function()
    vim.cmd "tabdo wincmd ="
    vim.cmd("tabnext " .. vim.fn.tabpagenr())
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
  callback = function() vim.highlight.on_yank() end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = vim.api.nvim_create_augroup("format_options", { clear = true }),
  callback = function() vim.opt.formatoptions:remove "o" end,
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
  "rose-pine/neovim",
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  "neovim/nvim-lspconfig",
  "brianaung/compl.nvim",
  "ibhagwan/fzf-lua",
  "tpope/vim-sleuth",
  "tpope/vim-surround",
  "stevearc/oil.nvim",
  "stevearc/conform.nvim",
  "stevearc/quicker.nvim",
  "echasnovski/mini.statusline",
  "mbbill/undotree",
  "christoomey/vim-tmux-navigator",
  "lewis6991/gitsigns.nvim",
  "Exafunction/windsurf.vim",
}
-- }}}

-- {{{ Colorscheme
require("rose-pine").setup {
  styles = { transparency = true },
}
vim.cmd "colorscheme rose-pine"
-- }}}

-- {{{ Treesitter
require("nvim-treesitter.configs").setup {
  highlight = {
    enable = true,
    disable = function(_, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then return true end
    end,
  },
  indent = { enable = true },
}
-- }}}

-- {{{ LSP & Completion
vim.lsp.config("*", {
  on_attach = function(_, bufnr)
    vim.keymap.set("n", "<Leader>gd", vim.lsp.buf.definition, { buffer = bufnr })
    vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, { buffer = bufnr })
    vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, { buffer = bufnr })
    vim.keymap.set("n", "<Leader>se", vim.diagnostic.open_float, { buffer = bufnr })
  end,
})

vim.lsp.config("lua_ls", {
  settings = {
    ["Lua"] = { diagnostics = { globals = { "vim" } } },
  },
})
vim.lsp.enable "lua_ls"
vim.lsp.enable "vue_ls"
vim.lsp.enable "tailwindcss"
vim.lsp.enable "phpactor"

-- vim.opt.runtimepath:append "~/projects/compl.nvim"
require("compl").setup {
  signature = {
    enable = true,
  },
}

vim.keymap.set("i", "<C-y>", function()
  if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info()["selected"] == -1 then return "<C-n><C-y>" end
  return "<C-y>"
end, { expr = true })
-- }}}

-- {{{ FzfLua
require("fzf-lua").setup { "telescope" }
vim.keymap.set("n", "<Leader>fd", "<Cmd>FzfLua files<CR>")
vim.keymap.set("n", "<Leader>fl", "<Cmd>FzfLua live_grep<CR>")
vim.keymap.set("n", "<Leader>fb", "<Cmd>FzfLua buffers<CR>")
vim.keymap.set("n", "<Leader>fh", "<Cmd>FzfLua help_tags<CR>")
-- }}}

-- {{{ Oil
require("oil").setup()
vim.keymap.set("n", "-", "<Cmd>Oil<CR>")
-- }}}

-- {{ Conform
require("conform").setup {
  formatters_by_ft = {
    lua = { "stylua" },
    javascript = { "eslint_d" },
    vue = { "eslint_d" },
    css = { "eslint_d" },
  },
  format_after_save = {
    lsp_fallback = false,
    timeout_ms = 500,
    async = true,
  },
}
-- }}}

-- {{{ Misc
require("quicker").setup()
require("mini.statusline").setup()
require("gitsigns").setup { current_line_blame = true }
--- }}}
