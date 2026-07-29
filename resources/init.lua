vim.g.mapleader = ' '

vim.opt.number = true
vim.opt.signcolumn = 'yes:2'
vim.opt.termguicolors = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.timeout = false

vim.cmd.colorscheme('github_dark_high_contrast')

vim.keymap.set('n', '<leader>e', '<cmd>Neotree toggle<cr>')
