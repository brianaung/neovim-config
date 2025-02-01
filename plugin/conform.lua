require("conform").setup {
  formatters_by_ft = {
    lua = { "stylua" },
    go = { "gofmt" },
    rust = { "rustfmt" },
    python = { "isort", "black" },
    javascript = { { "eslint_d", "prettierd", "prettier" } },
    typescript = { { "eslint_d", "prettierd", "prettier" } },
    typescriptreact = { { "eslint_d", "prettierd", "prettier" } },
    vue = { { "eslint_d", "prettierd", "prettier" } },
  },
  format_on_save = {
    lsp_fallback = false,
    timeout_ms = 500,
  },
}
