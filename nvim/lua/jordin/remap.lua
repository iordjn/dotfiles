-- Leader key: this is the prefix for custom shortcuts (Space + key).
vim.g.mapleader = " "

-- Open netrw file explorer.
-- Change "<leader>pv" if you want a different explorer shortcut.
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Open file explorer" })
