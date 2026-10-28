-- Tab priority (first match wins):
--   1. Active snippet with a forward jump → next placeholder
--   2. Cursor immediately before a closer → move past it (Tab Out)
--   3. Completion menu visible → accept selected / first item
--   4. LazyVim AI ghost-text accept (if an AI extra is enabled)
--   5. Otherwise → normal Tab / indent via blink "fallback"
--
-- Shift+Tab: previous snippet placeholder, else normal fallback.
--
-- tabout.nvim was removed: it depends on Tree-sitter node walks, always
-- reported success to blink (silently eating Tab on failure), and fought
-- the super-tab accept-when-snippet-active handler. A one-char Tab Out is
-- enough for VS Code-style behavior and reports handled/not correctly.

local closers = {
  [")"] = true,
  ["]"] = true,
  ["}"] = true,
  ['"'] = true,
  ["'"] = true,
  ["`"] = true,
}

---If the next character is a supported closer, move past it.
---Uses Neovim's 0-based byte column; never moves past EOL.
---@return boolean|nil true when the key was handled
local function tab_out()
  local line = vim.api.nvim_get_current_line()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local next = line:sub(col + 1, col + 1)
  if not closers[next] then
    return
  end
  local new_col = col + 1
  if new_col > #line then
    return
  end
  vim.api.nvim_win_set_cursor(0, { row, new_col })
  return true
end

return {
  -- Disable the previous Tab Out plugin; blink owns Tab entirely.
  { "abecodes/tabout.nvim", enabled = false },

  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        -- Keep super-tab non-Tab bindings (e.g. <C-e> = cancel).
        -- <Tab> / <S-Tab> below fully replace the preset's Tab handlers.
        preset = "super-tab",

        ["<Tab>"] = {
          -- 1) Snippet jump (only when a forward placeholder exists)
          "snippet_forward",

          -- 2) Tab Out past ) ] } " ' `
          function()
            return tab_out()
          end,

          -- 3) Accept completion (also expands snippet items from the menu)
          "select_and_accept",

          -- 4) LazyVim AI accept hooks when an AI extra is installed
          LazyVim.cmp.map({ "ai_nes", "ai_accept" }),

          -- 5) Indent / insert tab — do not consume the key otherwise
          "fallback",
        },

        ["<S-Tab>"] = {
          "snippet_backward",
          "fallback",
        },
      },
    },
  },
}
