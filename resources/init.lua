vim.opt.number = true
vim.opt.signcolumn = 'yes'
vim.opt.termguicolors = false

vim.keymap.set('n', '<leader>e', '<cmd>Neotree toggle<cr>')

require('gitsigns').setup({
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns
    vim.keymap.set('n', '<leader>hs', gs.stage_hunk, { buffer = bufnr })
    vim.keymap.set('n', '<leader>hr', gs.reset_hunk, { buffer = bufnr })
  end
})
