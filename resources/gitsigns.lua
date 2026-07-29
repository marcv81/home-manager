-- Key bindings for the gitsigns plugin.

local gs = require('gitsigns')

vim.keymap.set('n', '<leader>hs', gs.stage_hunk)
vim.keymap.set('n', '<leader>hr', gs.reset_hunk)

local function close_win(prefix)
  local closed = false
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local name = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(win))
    if vim.startswith(name, prefix) then
      pcall(vim.api.nvim_win_close, win, true)
      closed = true
    end
  end
  return closed
end

vim.keymap.set('n', '<leader>gd', function()
  close_win('gitsigns-blame:')
  if not close_win('gitsigns:') then
    gs.diffthis('HEAD')
  end
end)

vim.keymap.set('n', '<leader>gb', function()
  close_win('gitsigns:')
  if not close_win('gitsigns-blame:') then
    gs.blame()
  end
end)
