-- Core editor options.
-- Edit values here to change default Neovim behavior.

local opt = vim.opt

-- Show line numbers in the gutter.
opt.number = true

-- Keep relative line numbers off for a simpler view.
opt.relativenumber = false

-- Keep tabs readable and consistent:
-- - Tab key inserts spaces
-- - A tab counts as 2 spaces visually
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2

-- Better split behavior for editing multiple files.
opt.splitbelow = true
opt.splitright = true
