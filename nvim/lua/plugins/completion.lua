-- Tab behavior (first match wins):
--   1. Active snippet → jump to next placeholder
--   2. Next char is a closer ()[]{}/quote → tab out past it
--   3. Completion menu open → accept selected item
--   4. Otherwise → insert a real tab
--
-- Why this order: blink often auto-shows the menu inside (), so accepting
-- before tabout would steal Tab. Closers are checked before accept.
--
-- To change later: edit the ["<Tab>"] / ["<S-Tab>"] lists, or the
-- closers pattern / tabouts table below.

---Return true if the character after the cursor is something we can tab out of.
local function next_char_is_closer()
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2] -- 0-based byte index
  local next = line:sub(col + 1, col + 1)
  -- Keep in sync with tabouts below
  return next:find("[]})\"'`]") ~= nil
end

return {
  ---------------------------------------------------------------------------
  -- tabout.nvim — jump out of pairs/quotes
  -- Docs: https://github.com/abecodes/tabout.nvim
  -- Requires a treesitter parser for the current filetype.
  ---------------------------------------------------------------------------
  {
    "abecodes/tabout.nvim",
    event = "InsertEnter",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      -- Empty on purpose: blink owns Tab/S-Tab and calls tabout from the chain.
      tabkey = "",
      backwards_tabkey = "",

      act_as_tab = true, -- if nothing to jump out of, insert a tab
      act_as_shift_tab = false,
      enable_backwards = true,
      completion = false, -- completion is handled by blink, not tabout
      ignore_beginning = true, -- Tab at start of "foo" jumps past the close quote

      -- Add/remove pairs here (and update next_char_is_closer above).
      tabouts = {
        { open = "'", close = "'" },
        { open = '"', close = '"' },
        { open = "`", close = "`" },
        { open = "(", close = ")" },
        { open = "[", close = "]" },
        { open = "{", close = "}" },
      },
      exclude = {}, -- e.g. { "markdown" } to disable tabout in those filetypes
    },
  },

  ---------------------------------------------------------------------------
  -- blink.cmp — Tab accepts completion (LazyVim default is Enter)
  -- Docs: https://cmp.saghen.dev/configuration/keymap.html
  -- Change preset to "enter" to restore Enter-to-accept.
  ---------------------------------------------------------------------------
  {
    "saghen/blink.cmp",
    dependencies = { "abecodes/tabout.nvim" },
    opts = {
      keymap = {
        preset = "super-tab",

        ["<Tab>"] = {
          -- 1) Active snippet session → next placeholder
          function(cmp)
            if cmp.snippet_active() then
              return cmp.accept()
            end
          end,
          function(cmp)
            return LazyVim.cmp.map({ "snippet_forward", "ai_nes", "ai_accept" })(cmp)
          end,

          -- 2) Cursor before ) ] } " ' ` → jump out (even if menu is open)
          function()
            if next_char_is_closer() then
              require("tabout").tabout()
              return true
            end
          end,

          -- 3) Completion menu / ghost text → accept
          function(cmp)
            return cmp.select_and_accept()
          end,

          -- 4) Plain tab (via tabout act_as_tab)
          function()
            require("tabout").tabout()
            return true
          end,
        },

        ["<S-Tab>"] = {
          "snippet_backward",
          function()
            require("tabout").taboutBack()
            return true
          end,
        },
      },
    },
  },
}
