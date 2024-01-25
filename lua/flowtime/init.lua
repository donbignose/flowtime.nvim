local flowtime = require('flowtime.flowtime')
vim.api.nvim_create_user_command(
  'FlowTimeStart',
  flowtime.start_flowtime,
  { desc = 'Start Flowtime' }
)
vim.api.nvim_create_user_command('FlowTimeStop', flowtime.stop_flowtime, {})
vim.api.nvim_create_user_command('FlowTimeStartBreak', flowtime.start_break, {})

return flowtime
