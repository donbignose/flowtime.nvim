# 🕒 Flowtime for NeoVim

Flowtime is a NeoVim plugin implemented in Lua, designed to help you manage your time effectively using the FlowTime/Flowmodoro technique. This approach encourages focused work sessions followed by structured breaks, boosting productivity and maintaining balance. 🚀

## 🌟 Features

- 🕑 Start and stop work timers with simple commands.
- ⏱ Automatically calculates break durations based on work sessions.
- 🚨 Offers reminders to take breaks and the option to continue work sessions.
- ⏳ Tracks work and break durations seamlessly.

## 🔧 Requirements

- NeoVim (version 0.5 or later).

## 🛠 Installation

Install Flowtime using your favorite package manager. For example, with lazy:

```lua
{
  "donbignose/flowtime.nvim",
  config = function()
    require("flowtime")
  end,
}
```

## 🚀 Usage

- `:FlowtimeStart`: Starts the work timer. 🟢
- `:FlowtimeBreak`: Stops the work timer and starts the break timer. 🌙
- `:FlowtimeStop`: Stops the active timer. 🔴

### Integrate with Lualine

To display the active timer in your statusline, add the following to your lualine configuration:

```lua
"require'flowtime'.get_active_timer()"
```

For instance in lazy:

```lua
return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function(_, opts)
    table.insert(opts.sections.lualine_x, "require'flowtime'.get_active_timer()")
  end,
}
```

## Format

format use `stylua` and provide `.stylua.toml`.

## Test

use vusted for test install by using `luarocks --lua-version=5.1 install vusted` then run `vusted test`
for your test cases.

create test case in test folder file rule is `foo_spec.lua` with `_spec` more usage please check
[busted usage](https://lunarmodules.github.io/busted/)

## Ci

Ci support auto generate doc from README and integration test and lint check by `stylua`.

## License

Flowtime is released under the MIT License.
