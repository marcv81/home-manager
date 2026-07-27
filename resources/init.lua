vim.opt.number = true
vim.opt.signcolumn = 'yes'

require('github-theme').setup({})
vim.cmd.colorscheme("github_dark_high_contrast")

vim.g.mapleader = " "
vim.keymap.set("n", "<Space>", "<Nop>", { silent = true })

vim.keymap.set('n', '<leader>e', '<cmd>Neotree toggle<cr>')

require('gitsigns').setup({
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns
    vim.keymap.set('n', '<leader>hs', gs.stage_hunk, { buffer = bufnr })
    vim.keymap.set('n', '<leader>hr', gs.reset_hunk, { buffer = bufnr })
    vim.keymap.set('n', '<leader>gb', gs.blame, { buffer = bufnr })
    vim.keymap.set('n', '<leader>gd', gs.diffthis, { buffer = bufnr })
    vim.keymap.set('n', '<leader>gD', function() gs.diffthis('HEAD') end, { buffer = bufnr })
end
})
