-- Switch to the window under the mouse pointer when scrolling.

vim.opt.mouse = 'a'

local function focus_mouse()
  local win = vim.fn.getmousepos().winid
  if win and win ~= vim.api.nvim_get_current_win() then
    vim.api.nvim_set_current_win(win)
  end
end

for _, key in ipairs({ '<ScrollWheelUp>', '<ScrollWheelDown>', '<ScrollWheelLeft>', '<ScrollWheelRight>' }) do
  vim.keymap.set('n', key, function()
    vim.schedule(focus_mouse)
    return key
  end, { expr = true })
end
