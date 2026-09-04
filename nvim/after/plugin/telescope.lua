local builtin = require('telescope.builtin')

-- Telescope shortcuts:
-- <leader>ff -> search files in current working directory
-- <C-p>      -> search files tracked by git
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Find git files' })
-- Dynamically grep text as you type (requires ripgrep)
vim.keymap.set('n', '<leader>ps', function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
