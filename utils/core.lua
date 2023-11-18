local M = {}

M.remove_mappings = function(section)
    vim.schedule(function()
        local function remove_section_map(section_values)
            if section_values.plugin then
                return
            end

            for mode, mode_values in pairs(section_values) do
                for keybind, _ in pairs(mode_values) do
                    local _, _ = pcall(vim.api.nvim_del_keymap, mode, keybind)
                end
            end
        end

        local mappings = require("core.utils").load_config().mappings

        if type(section) == "string" then
            mappings[section]["plugin"] = nil
            mappings = { mappings[section] }
        end

        for _, sect in pairs(mappings) do
            remove_section_map(sect)
        end
    end)
end

M.dapui = {
    icons = { expanded = "▾", collapsed = "▸" },
    mappings = {
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
    },
    expand_lines = false,
    layouts = {
        {
            elements = {
                { id = "scopes", size = 0.40 },
                { id = "breakpoints", size = 0.20 },
                { id = "stacks", size = 0.20 },
                { id = "watches", size = 0.20 },
            },
            size = 40, -- 40 columns
            position = "left",
        },
        {
            elements = {
                {
                    id = "repl",
                    size = 0.5,
                },
                {
                    id = "console",
                    size = 0.5,
                },
            },
            size = 10, -- 25% of total lines
            position = "bottom",
        },
    },
    floating = {
        max_height = nil,
        max_width = nil,
        border = "rounded", -- Border style. Can be "single", "double" or "rounded"
        mappings = {
            close = { "q", "<Esc>" },
        },
    },
    windows = { indent = 1 },
    render = {
        max_type_length = nil,
    },
}

M.lazy = {
  change_detection = {
    enabled = true,
    notify = false,
  },
  concurrency = 15,
  git = {
    log = { "-8" },
    timeout = 15,
    url_format = "https://github.com/%s.git",
    filter = true,
  },
}

return M
