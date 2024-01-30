Log = require('flowtime.log')
local M = {}

local start_time = nil
local break_time = nil
local break_timer = nil
local work_duration = nil
local break_duration = nil

local function format_time(duration_in_seconds)
  local minutes = math.floor(duration_in_seconds / 60)
  local seconds = duration_in_seconds % 60
  return string.format('%02d:%02d', minutes, seconds)
end

function M.get_start_time()
  return start_time
end

function M.get_work_duration()
  return work_duration
end

function M.get_break_duration()
  return break_duration
end

function M.get_break_timer()
  return break_timer
end

function M.start_flowtime()
  if start_time then
    local current_work_duration = M.current_work_duration()
    Log.error('Timer already running ' .. format_time(current_work_duration))
    return
  end
  start_time = os.time()
  Log.info('Work timer started')
end

function M.stop_flowtime()
  if not start_time then
    Log.error('No Work timer running')
    return
  end
  work_duration = os.time() - start_time
  Log.info('Work timer stopped after ' .. format_time(work_duration))
  start_time = nil
end

function M.current_work_duration()
  if not start_time then
    Log.error('No Work timer  running')
    return 0
  end
  return os.time() - start_time
end

function M.start_break()
  if break_timer then
    Log.error('Break is already running. Time remaining: ' .. format_time(M.remaining_break()))
    return
  end
  M.stop_flowtime()
  if work_duration then
    break_time = os.time()
    break_duration = work_duration / 5
    break_timer = vim.fn.timer_start(break_duration * 1000, function()
      vim.cmd('echo "Break time is over."')
      local choice = vim.fn.input('Do you want to continue working? (y/n): ')
      if choice == 'y' or choice == 'Y' then
        M.start_flowtime()
      end
      M.reset()
    end)
    Log.info('Break started, chill for ' .. format_time(break_duration))
  end
end

function M.remaining_break()
  local elasped_break_time = os.time() - break_time
  return break_duration - elasped_break_time
end

function M.get_active_timer()
  if start_time then
    return format_time(M.current_work_duration())
  elseif break_time then
    return format_time(M.remaining_break())
  else
    return
  end
end

function M.reset()
  start_time = nil
  work_duration = nil
  break_duration = nil
  break_time = nil
  if break_timer then
    vim.fn.timer_stop(break_timer)
    break_timer = nil
  end
end

return M
