local helper = require('vusted.helper')
local assert = require('luassert')
local flowtime = require('flowtime')

describe('FlowTime plugin', function()
  local original_os_time = os.time
  local mock_time = original_os_time()
  before_each(function()
    os.time = function()
      return mock_time
    end
    flowtime.reset()
    package.loaded['flowtime'] = nil
    flowtime = require('flowtime')
    -- Mock vim.fn.input to simulate user input
    vim.fn.input = function()
      return 'n'
    end
  end)
  after_each(function()
    os.time = original_os_time
    mock_time = original_os_time()
  end)

  describe('start_flowtime', function()
    it('should start the work timer', function()
      flowtime.start_flowtime()
      assert.is_not_nil(flowtime.get_start_time())
    end)

    it('should not restart the timer if already running', function()
      flowtime.start_flowtime()
      local first_start_time = flowtime.get_start_time()
      mock_time = mock_time + 120
      flowtime.start_flowtime()
      assert.are.equal(first_start_time, flowtime.get_start_time())
    end)
  end)

  describe('stop_flowtime', function()
    it('should stop the work timer and calculate durations', function()
      flowtime.start_flowtime()
      mock_time = mock_time + 120
      flowtime.stop_flowtime()
      assert.is_true(flowtime.get_work_duration() >= 120)
      assert.is_nil(flowtime.get_start_time())
      assert.is_nil(flowtime.get_break_duration())
      assert.is_nil(flowtime.get_break_timer())
    end)
  end)

  describe('start_break', function()
    it('should start the break timer', function()
      flowtime.start_flowtime()
      mock_time = mock_time + 120
      flowtime.start_break()
      assert.is_nil(flowtime.get_work_duration())
      assert.is_not_nil(flowtime.get_break_duration())
      assert.is_not_nil(flowtime.get_break_timer())
    end)

    it('should handle existing break timer', function()
      flowtime.start_flowtime()
      mock_time = mock_time + 120
      flowtime.start_break()
      local first_break_timer = flowtime.get_break_timer()
      mock_time = mock_time + 5
      flowtime.start_break()
      assert.are.equal(first_break_timer, flowtime.get_break_timer())
    end)
    it('should do nothing when no work timer is on', function()
      flowtime.start_break()
      assert.is_nil(flowtime.get_break_timer())
      assert.is_nil(flowtime.get_break_duration())
      assert.is_nil(flowtime.get_work_duration())
    end)
  end)
  describe('reset', function()
    it('should reset all timers during break', function()
      flowtime.start_flowtime()
      mock_time = mock_time + 120
      flowtime.start_break()
      flowtime.reset()
      assert.is_nil(flowtime.get_start_time())
      assert.is_nil(flowtime.get_work_duration())
      assert.is_nil(flowtime.get_break_duration())
      assert.is_nil(flowtime.get_break_timer())
    end)
    it('should reset all timers during work', function()
      flowtime.start_flowtime()
      mock_time = mock_time + 120
      flowtime.reset()
      assert.is_nil(flowtime.get_start_time())
      assert.is_nil(flowtime.get_work_duration())
      assert.is_nil(flowtime.get_break_duration())
      assert.is_nil(flowtime.get_break_timer())
    end)
  end)

  -- Additional tests for current_work_duration and user prompt handling can be added.
end)
