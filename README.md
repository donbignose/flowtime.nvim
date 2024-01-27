# 🕒 FlowTime for NeoVim

FlowTime is a NeoVim plugin implemented in Lua, designed to help you manage your time effectively using the FlowTime/Flowmodoro technique. This approach encourages focused work sessions followed by structured breaks, boosting productivity and maintaining balance. 🚀

## 🌟 Features

- 🕑 Start and stop work timers with simple commands.
- ⏱ Automatically calculates break durations based on work sessions.
- 🚨 Offers reminders to take breaks and the option to continue work sessions.
- ⏳ Tracks work and break durations seamlessly.

## 🔧 Requirements

- NeoVim (version 0.5 or later).

## 🛠 Installation

Install FlowTime using your favorite package manager. For example, with [vim-plug](https://github.com/junegunn/vim-plug):

```vim
Plug 'your_username/flowtime.nvim'
```

## 🚀 Usage

- `:FlowTimeStart`: Starts the work timer. 🟢
- `:FlowTimeStop`: Stops the work timer and starts the break timer. 🔴
- `:FlowTimeStartBreak`: Starts the break timer manually. 🌙

## Format

format use `stylua` and provide `.stylua.toml`.

## Test

use vusted for test install by using `luarocks --lua-version=5.1 install vusted` then run `vusted test`
for your test cases.

create test case in test folder file rule is `foo_spec.lua` with `_spec` more usage please check
[busted usage](https://lunarmodules.github.io/busted/)

## Ci

Ci support auto generate doc from README and integration test and lint check by `stylua`.

## More

Other usage you can look at my plugins

## License

FlowTime is released under the MIT License.
