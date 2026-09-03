-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'


  use {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.4', -- or use branch = '0.1.x' for latest
  requires = {
    {'nvim-lua/plenary.nvim'},
    {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
  }
}

end)
