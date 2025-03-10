local opt = vim.opt
local set = vim.keymap.set
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

vim.g.mapleader = vim.keycode "<space>"

vim.cmd "colorscheme minicyan"

-- {{{ Options
opt.updatetime = 250
opt.timeoutlen = 300

opt.termguicolors = true
opt.splitright = true
opt.scrolloff = 5
opt.foldenable = false
opt.cursorline = true

opt.number = true
opt.relativenumber = true

opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = false

opt.linebreak = true
opt.breakindent = true
opt.showbreak = "   "

opt.inccommand = "split"

opt.ignorecase = true
opt.smartcase = true

-- Better ins-completion experience
opt.completeopt = { "menuone", "noselect", "noinsert" }
opt.shortmess:append "c"

-- Display hidden characters.
opt.list = true
opt.listchars = {
  tab = "→ ",
  eol = "↲",
  extends = "›",
  precedes = "‹",
  nbsp = "␣",
  trail = "~",
}
-- }}}

-- {{{ Keymaps
set({ "n", "v" }, "<Leader>", "<nop>")
set("n", "j", "gj")
set("n", "k", "gk")

-- Re-center when scrolling.
set("n", "<C-u>", "<C-u>zz")
set("n", "<C-d>", "<C-d>zz")

-- Yank and Paste from system clipboard.
set({ "n", "v" }, "<Leader>y", [["+y]])
set("n", "<Leader>Y", [["+Y]])
set("n", "<Leader>p", [["+p]])

-- Move selected lines.
set("v", "J", [[:m '>+1<CR>gv=gv]])
set("v", "K", [[:m '<-2<CR>gv=gv]])

set("n", "<C-f>", "<Cmd>silent !tmux neww tmux-sessionizer<CR>")

-- Use <CR> to clear hlsearch when active.
set("n", "<CR>", function() return vim.v.hlsearch == 1 and "<Cmd>nohl<CR>" or "<CR>" end, { expr = true })
--- }}}

-- {{{ Autocmds
autocmd({ "VimResized" }, {
  desc = "Resize splits if window got resized.",
  group = augroup("resize_splits", {}),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd "tabdo wincmd ="
    vim.cmd("tabnext " .. current_tab)
  end,
})

autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text.",
  group = augroup("highlight_yank", {}),
  callback = function() vim.highlight.on_yank { higroup = "Visual" } end,
})

autocmd("BufEnter", {
  desc = "Set global format options.",
  group = augroup("set_formatoptions", {}),
  callback = function()
    -- -o: Don't add comment leader when I press 'o' or 'O'.
    opt.formatoptions:remove { "o" }
  end,
})

autocmd("FileType", {
  desc = "Close certain windows with the escape key.",
  group = augroup("close_with_escape", {}),
  pattern = { "help", "qf", "man", "checkhealth" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    set("n", "<Esc>", "<Cmd>bd<CR>", { buffer = event.buf, silent = true })
  end,
})
-- }}}

-- {{{ Plugins
-- opt.runtimepath:append "~/projects/compl.nvim"
-- opt.runtimepath:append "~/projects/yasl.nvim"
-- opt.runtimepath:append "~/projects/fzf.nvim"

local paq_path = vim.fn.stdpath "data" .. "/site/pack/paqs/start/paq-nvim"
local is_installed = vim.fn.empty(vim.fn.glob(paq_path)) == 0
if not is_installed then
  vim.fn.system { "git", "clone", "--depth=1", "https://github.com/savq/paq-nvim.git", paq_path }
end
vim.cmd.packadd "paq-nvim"
require "paq" {
  "savq/paq-nvim",
  "nvim-lua/plenary.nvim",
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  "nvim-treesitter/nvim-treesitter-textobjects",
  "neovim/nvim-lspconfig",
  "brianaung/compl.nvim",
  { "brianaung/yasl.nvim", branch = "v2" },
  { "nvim-telescope/telescope.nvim", tag = "0.1.8" },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  "stevearc/conform.nvim",
  "stevearc/oil.nvim",
  { "echasnovski/mini.diff", branch = "stable" },
  { "echasnovski/mini.base16", branch = "stable" },
  "tpope/vim-sleuth",
  "tpope/vim-fugitive",
  "tpope/vim-surround",
  "mbbill/undotree",
  "christoomey/vim-tmux-navigator",
}

require("mini.diff").setup()
-- }}}
