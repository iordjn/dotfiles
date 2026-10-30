return {
  {
    "abecodes/tabout.nvim",
    lazy = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      tabkey = "",
      backwards_tabkey = "",
      act_as_tab = false,
      completion = false,
      ignore_beginning = true,
    },
  },
}
