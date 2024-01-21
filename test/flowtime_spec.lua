local helper = require('vusted.helper')
local assert = require('luassert')
local flowtime = require('flowtime')

describe('FlowTime plugin', function()
  before_each(function()
    helper.cleanup() -- Reset NeoVim state
    package.loaded['flowtime'] = nil -- Unload the module to reset its state
    flowtime = require('flowtime')
    -- Mock vim.fn.input to simulate user input
    vim.fn.input = function()
      return 'n'
    end -- Default to 'n' for simplicity
  end)

  describe('start_flowtime', function()
    it('should start the work timer', function()
      flowtime.start_flowtime()
      print(flowtime.start_time)
      assert.is_not_nil(flowtime.start_time)
    end)

    it('should not restart the timer if already running', function()
      flowtime.start_flowtime()
      local first_start_time = flowtime.start_time
      flowtime.start_flowtime()
      print(flowtime.start_time)
      print(first_start_time)
      assert.are.equal(first_start_time, flowtime.start_time)
    end)
  end)

  describe('stop_flowtime', function()
    it('should stop the work timer and calculate durations', function()
      flowtime.start_flowtime()
      helper.wait(2000) -- Simulate 2 seconds
      flowtime.stop_flowtime()
      assert.is_true(flowtime.work_duration >= 2)
      assert.is_true(flowtime.break_duration >= 0.4)
    end)
  end)

  describe('start_break', function()
    it('should start the break timer', function()
      flowtime.start_flowtime()
      helper.wait(2000) -- Simulate 2 seconds
      flowtime.start_break()
      assert.is_not_nil(flowtime.break_timer)
    end)

    it('should handle existing break timer', function()
      flowtime.start_flowtime()
      helper.wait(2000) -- Simulate 2 seconds
      flowtime.start_break()
      local first_break_timer = flowtime.break_timer
      flowtime.start_break() -- Try to start break again
      assert.are.equal(first_break_timer, flowtime.break_timer)
    end)
  end)

  -- Additional tests for current_work_duration and user prompt handling can be added.
end)
