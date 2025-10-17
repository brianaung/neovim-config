vim.g.mapleader = vim.keycode "<Space>"
vim.g.maplocalleader = vim.keycode "<Space>"

vim.keymap.set("n", "<Esc>", "<Cmd>nohlsearch<CR>")
vim.keymap.set("n", "<C-f>", "<Cmd>silent !tmux neww tmux-sessionizer<CR>")
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
vim.opt.shiftwidth = 4
vim.opt.softtabstop = -1
vim.opt.expandtab = true

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

vim.pack.add {
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/saghen/blink.cmp", -- build: `nix run .#build-plugin`
  "https://github.com/folke/snacks.nvim",
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/nvim-mini/mini.base16",
  "https://github.com/christoomey/vim-tmux-navigator",
  "https://github.com/tpope/vim-surround",
}

vim.lsp.config("*", {
  on_attach = function(_, bufnr)
    vim.keymap.set("n", "gd", "<Cmd>lua Snacks.picker.lsp_definitions()<CR>", { buffer = bufnr, desc = "Goto definition" })
    vim.keymap.set("n", "gD", "<Cmd>lua Snacks.picker.lsp_declarations()<CR>", { buffer = bufnr, desc = "Goto declaration" })
    vim.keymap.set("n", "grt", "<Cmd>lua Snacks.picker.lsp_type_definitions()<CR>", { buffer = bufnr, desc = "Goto type definitions" })
    vim.keymap.set("n", "gri", "<Cmd>lua Snacks.picker.lsp_implementations()<CR>", { buffer = bufnr, desc = "Goto implementation" })
    vim.keymap.set("n", "grr", "<Cmd>lua Snacks.picker.lsp_references()<CR>", { buffer = bufnr, desc = "Goto references" })
    vim.keymap.set("n", "gra", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Perform code action" })
    vim.keymap.set("n", "grn", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename symbol" })
    vim.keymap.set("n", "gO", "<Cmd>lua Snacks.picker.lsp_symbols()<CR>", { buffer = bufnr, desc = "Open symbol picker" })
    vim.keymap.set("n", "gW", "<Cmd>lua Snacks.picker.lsp_workspace_symbols()<CR>", { buffer = bufnr, desc = "Open workspace symbol picker" })
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
vim.lsp.enable { "lua_ls", "zls", "rust_analyzer", "terraform_ls", "vue_ls", "vtsls", "tailwindcss", "phpactor", "basedpyright" }
vim.diagnostic.config({ virtual_text = true })
require("blink.cmp").setup()

require("snacks").setup {
    picker = {
        layout = { preset = "ivy" },
        win = { input = { keys = { ["<Esc>"] = { "close", mode = { "n", "i" } } } } }
    },
}
vim.keymap.set("n", "<Leader>f", "<Cmd>lua Snacks.picker.files()<CR>", { desc = "Open file picker" })
vim.keymap.set("n", "<Leader>b", "<Cmd>lua Snacks.picker.buffers()<CR>", { desc = "Open buffer picker" })
vim.keymap.set("n", "<Leader>g", "<Cmd>lua Snacks.picker.grep()<CR>", { desc = "Open grep picker" })
vim.keymap.set("n", "<Leader>h", "<Cmd>lua Snacks.picker.help()<CR>", { desc = "Open help picker" })

require("oil").setup()
vim.keymap.set("n", "-", "<Cmd>Oil<CR>")

vim.cmd "colorscheme minicyan"
