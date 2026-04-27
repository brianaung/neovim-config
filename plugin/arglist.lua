vim.keymap.set("n", "<Leader>a", function()
  vim.cmd "argadd % | argdedupe"
end)

vim.keymap.set("n", "<Leader>e", function()
  local buf = vim.api.nvim_create_buf(false, true)
  vim.bo[buf].filetype = "argseditor"

  local arglist = vim.fn.argv(-1)
  local files = type(arglist) == "table" and arglist or { arglist }
  local lines = vim.tbl_map(function(f) return vim.fn.fnamemodify(f, ":~:.") end, files)

  local rows, cols = vim.o.lines, vim.o.columns
  local height, width = 15, math.ceil(cols * 0.7)
  vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    height = height,
    width = width,
    row = math.ceil(rows / 2 - height / 2),
    col = math.ceil(cols / 2 - width / 2),
    border = "single",
    title = string.format(" arglist (%d) ", #files),
  })

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  local function save_and_close()
    local updated = vim.tbl_filter(function(l) return l:match "%S" end, vim.api.nvim_buf_get_lines(buf, 0, -1, true))
    vim.cmd "%argd"
    if #updated > 0 then vim.cmd.arga(table.concat(updated, " ")) end
    vim.api.nvim_buf_delete(buf, { force = true })
  end

  vim.keymap.set("n", "<CR>", function()
    local file = vim.fn.getline "."
    if file ~= "" then
      vim.api.nvim_buf_delete(buf, { force = true })
      vim.cmd.e(file)
    end
  end, { buffer = buf })

  vim.keymap.set("n", "<Esc>", save_and_close, { buffer = buf })
  vim.keymap.set("n", "q", save_and_close, { buffer = buf })
end)
