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

-- {{{ Plugins
vim.pack.add {
  "https://github.com/rose-pine/neovim",
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/brianaung/compl.nvim",
  "https://github.com/ibhagwan/fzf-lua",
  "https://github.com/folke/snacks.nvim",
  "https://github.com/tpope/vim-sleuth",
  "https://github.com/tpope/vim-surround",
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/stevearc/quicker.nvim",
  "https://github.com/echasnovski/mini.statusline",
  "https://github.com/echasnovski/mini.tabline",
  "https://github.com/mbbill/undotree",
  "https://github.com/christoomey/vim-tmux-navigator",
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/Exafunction/windsurf.vim",
}
-- }}}

-- {{{ Colorscheme
require("rose-pine").setup {
  -- styles = { transparency = true },
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
    vim.keymap.set("n", "<Leader>gi", vim.lsp.buf.implementation, { buffer = bufnr })
    vim.keymap.set("n", "<Leader>gr", vim.lsp.buf.references, { buffer = bufnr })
    vim.keymap.set("n", "<Leader>gt", vim.lsp.buf.type_definition, { buffer = bufnr })
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

local vue_plugin = {
  name = "@vue/typescript-plugin",
  location = "/home/brianaung/.nix-profile/lib/node_modules/@vue/language-server",
  languages = { "vue" },
  configNamespace = "typescript",
}
vim.lsp.config("vtsls", {
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = {
          vue_plugin,
        },
      },
    },
  },
  filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
})

vim.lsp.enable { "lua_ls", "vue_ls", "vtsls", "tailwindcss", "phpactor", "terraform_ls" }

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
require("mini.tabline").setup()
require("gitsigns").setup { current_line_blame = true }
require("snacks").setup {
  indent = {},
  statuscolumn = {},
  bigfile = {},
  words = {},
}
--- }}}
