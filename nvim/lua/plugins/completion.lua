-- Tab: snippet jump → accept completion → LazyVim AI accept → normal Tab
-- Shift+Tab: previous snippet placeholder → normal fallback

return {
  { "abecodes/tabout.nvim", enabled = false },

  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "super-tab",

        ["<Tab>"] = {
          "snippet_forward",
          "select_and_accept",
          LazyVim.cmp.map({ "ai_nes", "ai_accept" }),
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
