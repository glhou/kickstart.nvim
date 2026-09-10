-- lua/custom/modules/jj.lua
local M = {}

--- @param cmd string
function cmd(cmd)
  vim.cmd 'botright new'
  vim.cmd(cmd)
  vim.keymap.set('t', 'q', '<C-\\><C-n><cmd>close<CR>', {
    buffer = 0,
    desc = 'Close cmd',
  })
  vim.keymap.set('t', '<Esc>', '<C-\\><C-n><cmd>close<CR>', {
    buffer = 0,
    desc = 'Close cmd',
  })
  vim.keymap.set('n', 'q', '<cmd>close<CR>', {
    buffer = 0,
    desc = 'Close cmd',
  })
  vim.keymap.set('n', '<Esc>', '<cmd>close<CR>', {
    buffer = 0,
    desc = 'Close cmd',
  })
end

function M.setup()
  vim.api.nvim_create_user_command('Jj', function() cmd 'terminal jj log --color=always --no-pager' end, {
    desc = 'Jj logs',
  })
  vim.api.nvim_create_user_command('JjCommit', function(opts) cmd('terminal jj commit -m "' .. table.concat(opts.fargs, ' ') .. '"') end, {
    nargs = '*',
    desc = 'Jj commit with message',
  })
  vim.api.nvim_create_user_command('JjEdit', function(opts) cmd('terminal jj edit "' .. opts.args .. '"') end, {
    nargs = 1,
    desc = 'Jj edit',
  })
  vim.api.nvim_create_user_command('JjNew', function(opts) cmd 'terminal jj new' end, {
    desc = 'Jj new',
  })
  vim.api.nvim_create_user_command('JjBookAdv', function() cmd 'terminal jj bookmark advance' end, {
    desc = 'Jj bookmark advance',
  })
end

return M
