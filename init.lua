vim.g.mapleader = vim.keycode "<Space>"
vim.g.maplocalleader = vim.keycode "<Space>"

vim.keymap.set("n", "<Esc>", "<Cmd>nohlsearch<CR>")
vim.keymap.set({ "n", "v" }, "<Leader>y", [["+y]], { desc = "Yank to clipboard" })
vim.keymap.set("n", "<Leader>p", [["+p]], { desc = "Paste from clipboard" })

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.scrolloff = 5
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.confirm = true
vim.opt.list = true
vim.opt.listchars = { tab = "→ ", eol = "↲", nbsp = "␣", trail = "~" }

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

vim.pack.add {
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/saghen/blink.cmp", -- build: `nix run .#build-plugin`
  "https://github.com/ibhagwan/fzf-lua", -- requires fzf
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/RRethy/base16-nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/tpope/vim-surround",
  "https://github.com/tpope/vim-sleuth",
  "https://github.com/mrjones2014/smart-splits.nvim", -- use with mutliplexer integration
}

vim.lsp.config("*", {
  on_attach = function(_, bufnr)
    vim.keymap.set("n", "gd", "<Cmd>FzfLua lsp_definitions<CR>", { buffer = bufnr, desc = "Goto definition" })
    vim.keymap.set("n", "gD", "<Cmd>FzfLua lsp_declarations<CR>", { buffer = bufnr, desc = "Goto declaration" })
    vim.keymap.set("n", "grt", "<Cmd>FzfLua lsp_typedefs<CR>", { buffer = bufnr, desc = "Goto type definitions" })
    vim.keymap.set("n", "gri", "<Cmd>FzfLua lsp_implementations<CR>", { buffer = bufnr, desc = "Goto implementation" })
    vim.keymap.set("n", "grr", "<Cmd>FzfLua lsp_references<CR>", { buffer = bufnr, desc = "Goto references" })
    vim.keymap.set("n", "gra", "<Cmd>FzfLua lsp_code_actions<CR>", { buffer = bufnr, desc = "Perform code action" })
    vim.keymap.set("n", "grn", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename symbol" })
    vim.keymap.set("n", "gO", "<Cmd>FzfLua lsp_document_symbols<CR>", { buffer = bufnr, desc = "Open symbol picker" })
    vim.keymap.set(
      "n",
      "gW",
      "<Cmd>FzfLua lsp_workspace_symbols<CR>",
      { buffer = bufnr, desc = "Open workspace symbol picker" }
    )
  end,
})
vim.lsp.config("lua_ls", {
  settings = {
    ["Lua"] = { diagnostics = { globals = { "vim" } } },
  },
})
vim.lsp.config("vtsls", {
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = {
          {
            name = "@vue/typescript-plugin",
            location = "/home/brianaung/.nix-profile/lib/node_modules/@vue/language-server",
            languages = { "vue" },
            configNamespace = "typescript",
          },
        },
      },
    },
  },
  filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
})
vim.lsp.enable {
  "lua_ls",
  "zls",
  "rust_analyzer",
  "terraform_ls",
  "vue_ls",
  "vtsls",
  "tailwindcss",
  "phpactor",
  "basedpyright",
}
vim.diagnostic.config { virtual_text = true }
require("blink.cmp").setup()

require("conform").setup {
  formatters_by_ft = {
    lua = { "stylua" },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback",
  },
}

require("fzf-lua").setup { "borderless-full", fzf_colors = true }
vim.keymap.set("n", "<Leader>f", "<Cmd>FzfLua files<CR>", { desc = "Open file picker" })
vim.keymap.set("n", "<Leader>b", "<Cmd>FzfLua buffers<CR>", { desc = "Open buffer picker" })
vim.keymap.set("n", "<Leader>g", "<Cmd>FzfLua live_grep<CR>", { desc = "Open grep picker" })
vim.keymap.set("n", "<Leader>h", "<Cmd>FzfLua helptags<CR>", { desc = "Open help picker" })

require("oil").setup()
vim.keymap.set("n", "-", "<Cmd>Oil<CR>")

vim.keymap.set("n", "<A-h>", "<Cmd>SmartResizeLeft<CR>")
vim.keymap.set("n", "<A-j>", "<Cmd>SmartResizeDown<CR>")
vim.keymap.set("n", "<A-k>", "<Cmd>SmartResizeUp<CR>")
vim.keymap.set("n", "<A-l>", "<Cmd>SmartResizeRight<CR>")
vim.keymap.set("n", "<C-h>", "<Cmd>SmartCursorMoveLeft<CR>")
vim.keymap.set("n", "<C-j>", "<Cmd>SmartCursorMoveDown<CR>")
vim.keymap.set("n", "<C-k>", "<Cmd>SmartCursorMoveUp<CR>")
vim.keymap.set("n", "<C-l>", "<Cmd>SmartCursorMoveRight<CR>")

vim.cmd "colorscheme base16-everforest-dark-hard"
