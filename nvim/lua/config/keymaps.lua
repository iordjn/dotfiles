-- Keymaps are loaded by LazyVim on the VeryLazy event.
-- Preview saved HTML in your browser, or Markdown with Glow in a floating terminal.
vim.keymap.set("n", "<leader>p", function()
  local file = vim.api.nvim_buf_get_name(0)
  if file == "" then
    vim.notify("Save the file before previewing it", vim.log.levels.WARN)
    return
  end

  vim.cmd.update()
  if vim.bo.filetype == "html" then
    vim.ui.open(file)
  elseif vim.bo.filetype == "markdown" then
    if vim.fn.executable("glow") == 0 then
      vim.notify("Install Markdown previewer: brew install glow", vim.log.levels.WARN)
      return
    end
    Snacks.terminal({ "glow", "-p", file }, { win = { position = "float" } })
  else
    vim.notify("Preview supports HTML and Markdown", vim.log.levels.INFO)
  end
end, { desc = "Preview HTML or Markdown" })

-- Use LazyVim's existing Snacks integration; no separate Lazygit plugin needed.
vim.keymap.set("n", "<leader>gg", function()
  if vim.fn.executable("lazygit") == 0 then
    vim.notify("Install Lazygit: brew install lazygit", vim.log.levels.WARN)
    return
  end
  Snacks.lazygit()
end, { desc = "Lazygit (project changes)" })
