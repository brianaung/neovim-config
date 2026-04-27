vim.g.mapleader = vim.keycode "<Space>"
vim.g.maplocalleader = vim.keycode "<Space>"

vim.keymap.set("n", "<Esc>", "<Cmd>nohlsearch<CR>")
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")
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

-- builtin plugins
vim.cmd.packadd "nvim.undotree"

-- External plugins
vim.pack.add {
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/saghen/blink.cmp", -- build: `nix run .#build-plugin`
  "https://github.com/ibhagwan/fzf-lua", -- requires fzf
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/tpope/vim-surround",
  "https://github.com/tpope/vim-sleuth",
  "https://github.com/mrjones2014/smart-splits.nvim", -- use with mutliplexer integration
  "https://github.com/sainnhe/gruvbox-material",
}

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("treesitter_highlight", { clear = true }),
  pattern = { "lua", "pug", "javascript", "typescript", "vue", "blade" },
  callback = function(args)
    vim.treesitter.start(args.buf)
    -- vim.bo[args.buf].syntax = "ON" -- only if additional legacy syntax is needed
  end,
})

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
    vim.keymap.set(
      "n",
      "gs",
      "<Cmd>FzfLua diagnostics_document<CR>",
      { buffer = bufnr, desc = "Open diagnostics picker" }
    )
    vim.keymap.set(
      "n",
      "gS",
      "<Cmd>FzfLua diagnostics_workspace<CR>",
      { buffer = bufnr, desc = "Open workspace diagnostics picker" }
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
  "gopls",
}
vim.diagnostic.config { virtual_text = true }
require("blink.cmp").setup()

require("conform").setup {
  formatters_by_ft = {
    lua = { "stylua" },
    -- vue = { "eslint_d" },
    go = { "gofmt" },
  },
  format_on_save = {
    timeout_ms = 500,
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

vim.cmd "colorscheme gruvbox-material"
