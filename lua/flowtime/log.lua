M = {}
local has_notify, notify = pcall(require, 'notify')
if has_notify then
  vim.notify = notify
end

local title = 'Flowtime'

function M.info(message)
  vim.notify(message, vim.log.levels.INFO, { title = title })
end

function M.warn(message)
  vim.notify(message, vim.log.levels.WARN, { title = title })
end

function M.error(message)
  vim.notify(message, vim.log.levels.ERROR, { title = title })
end

function M.debug(message)
  vim.notify(message, vim.log.levels.DEBUG, { title = title })
end

function M.trace(message)
  vim.notify(message, vim.log.levels.TRACE, { title = title })
end

return M
