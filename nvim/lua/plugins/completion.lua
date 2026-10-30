-- Tab: snippet → completion → AI → tabout → indent
-- Shift+Tab: previous snippet → backwards tabout → fallback

local function tabout(key)
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2]

  -- Allow normal indentation on empty lines or leading whitespace
  if line:sub(1, col):match("^%s*$") then
    return false
  end

  -- Only attempt tabout when a closing delimiter is ahead
  local remaining = line:sub(col + 1)
  if not remaining:find("[%)%]%}\"'`]") then
    return false
  end

  local keys = vim.api.nvim_replace_termcodes(key, true, true, true)
  vim.api.nvim_feedkeys(keys, "m", false)
  return true
end

return {
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "super-tab",

        ["<Tab>"] = {
          "snippet_forward",
          "select_and_accept",
          LazyVim.cmp.map({ "ai_nes", "ai_accept" }),
          function()
            if vim.fn.pumvisible() == 0 then
              return tabout("<Plug>(Tabout)")
            end
            return false
          end,
          "fallback",
        },

        ["<S-Tab>"] = {
          "snippet_backward",
          function()
            if vim.fn.pumvisible() == 0 then
              return tabout("<Plug>(TaboutBack)")
            end
            return false
          end,
          "fallback",
        },
      },
    },
  },
}
