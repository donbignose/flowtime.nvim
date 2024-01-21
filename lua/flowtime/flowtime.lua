local M = {}

local start_time = nil
local break_timer = nil
local work_duration = nil
local break_duration = nil

function M.start_flowtime()
  if start_time then
    print('Flowtime: Timer already running ' .. M.current_work_duration() .. ' minutes')
    return
  end
  start_time = os.time()
  print('Flowtime: Work timer started', start_time)
end

function M.stop_flowtime()
  if not start_time then
    print('Flowtime: Work timer not running')
    return
  end
  local end_time = os.time()
  work_duration = end_time - start_time
  local minutes = math.floor(work_duration / 60)
  local seconds = work_duration % 60
  print(string.format('Flowtime: Work timer stopped after %02d:%02d (mm:ss).', minutes, seconds))
  start_time = nil
  break_duration = work_duration / 5
end

function M.current_work_duration()
  if not start_time then
    print('Flowtime: Work timer not running')
    return 0
  end
  return math.floor((os.time() - start_time) / 60)
end

function M.start_break()
  M.stop_flowtime()
  if break_timer then
    local remaining_ms = vim.fn.timer_info(break_timer)[1].remaining
    local remaining_seconds = remaining_ms / 1000
    local minutes = math.floor(remaining_seconds / 60)
    local seconds = remaining_seconds % 60
    print(
      string.format(
        'FlowTime: Break is already running. Time remaining: %02d:%02d (mm:ss).',
        minutes,
        seconds
      )
    )
    return
  end
  break_timer = vim.fn.timer_start(break_duration * 1000, function()
    vim.cmd('echo "FlowTime: Break time is over."')
    local choice = vim.fn.input('Do you want to continue working? (y/n): ')
    if choice == 'y' or choice == 'Y' then
      M.start_flowtime()
    end
    break_timer = nil
  end)
  print('Flowtime: Break started, chill for ' .. break_duration / 60 .. ' minutes')
end

return M
