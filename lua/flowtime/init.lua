local flowtime = require('flowtime.flowtime')
vim.api.nvim_create_user_command(
  'FlowtimeStart',
  flowtime.start_flowtime,
  { desc = 'Start Flowtime' }
)
vim.api.nvim_create_user_command('FlowtimeStop', function()
  flowtime.stop_flowtime()
  flowtime.reset()
end, { desc = 'Stop Flowtime' })
vim.api.nvim_create_user_command(
  'FlowtimeBreak',
  flowtime.start_break,
  { desc = 'Stop Flowtime and start break' }
)

return flowtime
