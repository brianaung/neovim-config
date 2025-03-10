for server, server_opts in pairs {
  lua_ls = {
    Lua = { diagnostics = { globals = { "vim" } } },
  },
  nil_ls = {},
  gopls = {},
  pyright = {},
  ts_ls = {},
  tailwindcss = {},
  phpactor = {},
  volar = {},
  markdown_oxide = {},
} do
  require("lspconfig")[server].setup {
    capabilities = vim.lsp.protocol.make_client_capabilities(),

    on_attach = function(_, bufnr)
      local opts = { buffer = bufnr }
      vim.keymap.set("n", "<Leader>gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "<Leader>gr", vim.lsp.buf.references, opts)
      vim.keymap.set("n", "<Leader>gi", vim.lsp.buf.implementation, opts)
      vim.keymap.set("n", "<Leader>gt", vim.lsp.buf.type_definition, opts)
      vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, opts)
      vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, opts)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      vim.keymap.set("n", "<Leader>sh", vim.lsp.buf.signature_help, opts)
      vim.keymap.set("n", "<Leader>se", vim.diagnostic.open_float, opts)
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
    end,

    settings = server_opts,
    filetypes = (server_opts or {}).filetypes,
    init_options = (server_opts or {}).init_options,
  }
end
