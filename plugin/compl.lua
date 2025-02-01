local set = vim.keymap.set

require("compl").setup()

set("i", "<C-y>", function()
  if vim.fn.complete_info()["selected"] ~= -1 then return "<C-y>" end
  if vim.fn.pumvisible() ~= 0 then return "<C-n><C-y>" end
  return "<C-y>"
end, { expr = true })

set("i", "<CR>", function()
  if vim.fn.complete_info()["selected"] ~= -1 then return "<C-y>" end
  if vim.fn.pumvisible() ~= 0 then return "<C-e><CR>" end
  return "<CR>"
end, { expr = true })

set({ "i", "s" }, "<C-k>", function()
  if vim.snippet.active { direction = 1 } then return "<Cmd>lua vim.snippet.jump(1)<CR>" end
end, { expr = true })

set({ "i", "s" }, "<C-j>", function()
  if vim.snippet.active { direction = -1 } then return "<Cmd>lua vim.snippet.jump(-1)<CR>" end
end, { expr = true })
