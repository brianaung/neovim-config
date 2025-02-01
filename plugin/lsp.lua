local set = vim.keymap.set

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
      set("n", "<Leader>gd", vim.lsp.buf.definition, opts)
      set("n", "<Leader>gr", vim.lsp.buf.references, opts)
      set("n", "<Leader>gi", vim.lsp.buf.implementation, opts)
      set("n", "<Leader>gt", vim.lsp.buf.type_definition, opts)
      set("n", "<Leader>ca", vim.lsp.buf.code_action, opts)
      set("n", "<Leader>rn", vim.lsp.buf.rename, opts)
      set("n", "K", vim.lsp.buf.hover, opts)
      set("n", "<Leader>sh", vim.lsp.buf.signature_help, opts)
      set("n", "<Leader>se", vim.diagnostic.open_float, opts)
      set("n", "[d", vim.diagnostic.goto_prev, opts)
      set("n", "]d", vim.diagnostic.goto_next, opts)
    end,

    settings = server_opts,
    filetypes = (server_opts or {}).filetypes,
    init_options = (server_opts or {}).init_options,
  }
end
