---@diagnostic disable: need-check-nil
local create_cmd = vim.api.nvim_create_user_command
local settings = require("custom.chadrc").settings
local g = vim.g
local fn = vim.fn


create_cmd("DapUiOpen", ":lua require'dapui'.open()", {})
create_cmd("DapUiClose", ":lua require'dapui'.close()", {})
create_cmd("DapUiToggle", ":lua require'dapui'.toggle()", {})
create_cmd("DapUiFloatElement", ":lua require'dapui'.float_element()", {})
create_cmd("DapUiEval", ":lua require'dapui'.eval()", {})

