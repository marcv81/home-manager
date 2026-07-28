vim.g.mapleader = ' '
vim.opt.number = true
vim.opt.signcolumn = 'yes:2'
vim.opt.termguicolors = true
vim.opt.clipboard = 'unnamedplus'
vim.cmd.colorscheme('github_dark_high_contrast')

vim.keymap.set('n', '<leader>e', '<cmd>Neotree toggle<cr>')

local gs = require('gitsigns')
vim.keymap.set('n', '<leader>hs', gs.stage_hunk)
vim.keymap.set('n', '<leader>hr', gs.reset_hunk)

local function toggle(prefix, action)
  local win_closed = false
  -- If there are multiple windows matching the prefix, close them all.
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local win_name = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(win))
    if vim.startswith(win_name, prefix) then
      vim.api.nvim_win_close(win, true)
      win_closed = true
    end
  end
  -- Only call the action if we didn't find any window to close.
  if not win_closed then
    action()
  end
end

vim.keymap.set('n', '<leader>gd', function()
  toggle('gitsigns:', gs.diffthis)
end)

vim.keymap.set('n', '<leader>gD', function()
  toggle('gitsigns:', function() gs.diffthis('HEAD') end)
end)

vim.keymap.set('n', '<leader>gb', function()
  toggle('gitsigns-blame:', gs.blame)
end)
