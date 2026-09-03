local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', builtin.find_files,  { desc = 'Find Files' })
vim.keymap.set('n', '<C-p>', builtin.git_files,  { desc = 'Git Files' })
-- Dynamically grep text as you type (requires ripgrep)
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ")})
end)

