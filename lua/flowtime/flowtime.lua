local M = {}

local start_time = nil
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
    print(
      string.format('Flowtime: Timer already running ', format_time(current_work_duration), '\n')
    )
    return
  end
  start_time = os.time()
  print('Flowtime: Work timer started\n')
end

function M.stop_flowtime()
  if not start_time then
    print('Flowtime: Work timer not running')
    return
  end
  local end_time = os.time()
  work_duration = end_time - start_time
  print(string.format('Flowtime: Work timer stopped after ', format_time(work_duration)))
  start_time = nil
  break_duration = work_duration / 5
end

function M.current_work_duration()
  if not start_time then
    print('Flowtime: Work timer not running')
    return 0
  end
  return os.time() - start_time
end

function M.start_break()
  M.stop_flowtime()
  if break_timer then
    local remaining_ms = vim.fn.timer_info(break_timer)[1].remaining
    local remaining_seconds = remaining_ms / 1000
    print(
      string.format(
        'FlowTime: Break is already running. Time remaining: ',
        format_time(remaining_seconds)
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
  print('Flowtime: Break started, chill for ', format_time(break_duration))
end

function M.reset()
  start_time = nil
  work_duration = nil
  break_duration = nil
  break_timer = nil
end

return M
