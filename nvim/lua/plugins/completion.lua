-- Tab: snippet → completion → AI → tabout → fallback
-- Shift+Tab: previous snippet → backwards tabout → fallback

local function tabout(key)
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
