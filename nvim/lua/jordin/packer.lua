-- Plugin manager bootstrap.
-- If packer is installed as an optional package, load it first.
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Let packer manage itself.
  use 'wbthomason/packer.nvim'

  -- Telescope: fuzzy finder for files, git files, and text search.
  use {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.4', -- Use branch = '0.1.x' if you want latest compatible updates.
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    },
  }

end)
