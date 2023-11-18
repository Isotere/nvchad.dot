---@type ChadrcConfig
local M = {}

local core = require "custom.utils.core"

M.lazy_nvim = core.lazy

M.ui = {
    theme = 'chadracula',
    lsp_semantic_tokens = false,

    cmp = {
        icons = true,
        lspkind_text = true,
        style = "default", -- default/flat_light/flat_dark/atom/atom_colored
        border_color = "grey_fg", -- only applicable for "default" style, use color names from base30 variables
        selected_item_bg = "colored", -- colored / simple
    },

    telescope = { style = "bordered" },

    extended_integrations = {
        "dap",
        "codeactionmenu",
    },
}

M.plugins = "custom.plugins"
M.mappings = require "custom.mappings"

return M
