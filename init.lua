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
vim.opt.completeopt = { "menuone", "noselect", "noinsert" }
vim.opt.shortmess:append "c"

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
  "https://github.com/brianaung/compl.nvim",
  "https://github.com/echasnovski/mini.pick",
  "https://github.com/echasnovski/mini.extra", -- lsp/diagnostic pickers
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/tpope/vim-surround",
  "https://github.com/tpope/vim-sleuth",
  "https://github.com/mrjones2014/smart-splits.nvim", -- use with mutliplexer integration
  "https://github.com/Shatur/neovim-ayu",
}

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("treesitter_highlight", { clear = true }),
  callback = function(args)
    local ft = vim.bo[args.buf].filetype
    local lang = vim.treesitter.language.get_lang(ft) or ft
    local ts = require "nvim-treesitter"

    local function start()
      if vim.api.nvim_buf_is_valid(args.buf) and pcall(vim.treesitter.start, args.buf) then
        vim.bo[args.buf].syntax = "ON"
      end
    end

    if vim.tbl_contains(ts.get_installed(), lang) then
      start()
    elseif vim.tbl_contains(ts.get_available(), lang) then
      ts.install(lang):await(function(err)
        if not err then vim.schedule(start) end
      end)
    end
  end,
})

vim.lsp.config("*", {
  on_attach = function(_, bufnr)
    local lsp_picker = function(scope)
      return function() require("mini.extra").pickers.lsp { scope = scope } end
    end
    vim.keymap.set("n", "gd", lsp_picker "definition", { buffer = bufnr, desc = "Goto definition" })
    vim.keymap.set("n", "gD", lsp_picker "declaration", { buffer = bufnr, desc = "Goto declaration" })
    vim.keymap.set("n", "grt", lsp_picker "type_definition", { buffer = bufnr, desc = "Goto type definitions" })
    vim.keymap.set("n", "gri", lsp_picker "implementation", { buffer = bufnr, desc = "Goto implementation" })
    vim.keymap.set("n", "grr", lsp_picker "references", { buffer = bufnr, desc = "Goto references" })
    vim.keymap.set("n", "gra", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Perform code action" })
    vim.keymap.set("n", "grn", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename symbol" })
    vim.keymap.set("n", "gO", lsp_picker "document_symbol", { buffer = bufnr, desc = "Open symbol picker" })
    vim.keymap.set("n", "gW", lsp_picker "workspace_symbol", { buffer = bufnr, desc = "Open workspace symbol picker" })
    vim.keymap.set(
      "n",
      "gs",
      function() require("mini.extra").pickers.diagnostic { scope = "current" } end,
      { buffer = bufnr, desc = "Open diagnostics picker" }
    )
    vim.keymap.set(
      "n",
      "gS",
      function() require("mini.extra").pickers.diagnostic { scope = "all" } end,
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
require("compl").setup()

require("conform").setup {
  formatters_by_ft = {
    lua = { "stylua" },
    go = { "gofmt" },
  },
  format_on_save = {
    timeout_ms = 500,
  },
}

require("mini.pick").setup()
require("mini.extra").setup()
vim.keymap.set("n", "<Leader>f", function() require("mini.pick").builtin.files() end, { desc = "Open file picker" })
vim.keymap.set("n", "<Leader>b", function() require("mini.pick").builtin.buffers() end, { desc = "Open buffer picker" })
vim.keymap.set("n", "<Leader>g", function() require("mini.pick").builtin.grep_live() end, { desc = "Open grep picker" })
vim.keymap.set("n", "<Leader>h", function() require("mini.pick").builtin.help() end, { desc = "Open help picker" })

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

vim.cmd "colorscheme ayu-mirage"
