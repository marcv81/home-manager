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
    vim.keymap.set('n', '<leader>gd', gs.diffthis, { buffer = bufnr })
    vim.keymap.set('n', '<leader>gD', function() gs.diffthis('HEAD') end, { buffer = bufnr })
  end
})

-- Blame toggle
vim.keymap.set('n', '<leader>gb', function()
  local bufname = vim.api.nvim_buf_get_name(0)
  if vim.startswith(bufname, 'gitsigns-blame:') then
    vim.cmd('q')
    return
  end
  local filename = vim.fn.fnamemodify(bufname, ':t')
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local win_name = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(win))
    if vim.startswith(win_name, 'gitsigns-blame:') and win_name:find(filename, 1, true) then
      vim.api.nvim_win_close(win, true)
      return
    end
  end
  require('gitsigns').blame()
end)
