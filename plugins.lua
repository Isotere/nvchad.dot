local overrides = require "custom.configs.overrides"

local plugins = {
    {
        "williamboman/mason.nvim",
        opts = overrides.mason,
        config = function(_, opts)
            dofile(vim.g.base46_cache .. "mason")
            dofile(vim.g.base46_cache .. "lsp")
            require("mason").setup(opts)
            vim.api.nvim_create_user_command("MasonInstallAll", function()
                vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
            end, {})
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            "chrisgrieser/nvim-various-textobjs",
            "filNaj/tree-setter",
            "piersolenski/telescope-import.nvim",
            "LiadOz/nvim-dap-repl-highlights",
            "RRethy/nvim-treesitter-textsubjects",
            "kevinhwang91/promise-async",
        },
        opts = overrides.treesitter,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            { "folke/neodev.nvim", opts = {} },
        },
        config = function ()
            require "plugins.configs.lspconfig"
            require "custom.configs.lspconfig"
        end
    },
    {
        "NvChad/nvterm",
        opts = overrides.nvterm,
    },
    {
        "nvim-tree/nvim-web-devicons",
        opts = overrides.devicons,
    },
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "antosha417/nvim-lsp-file-operations" },
        opts = overrides.nvimtree,
    },
    {
        "m-demare/hlargs.nvim",
        event = "BufWinEnter",
        config = function()
            require("hlargs").setup {
                hl_priority = 200,
            }
        end,
    },
    {
        "mfussenegger/nvim-dap",
        cmd = { "DapContinue", "DapStepOver", "DapStepInto", "DapStepOut", "DapToggleBreakpoint" },
        dependencies = {
            {
                "theHamsta/nvim-dap-virtual-text",
                config = function()
                    require "custom.configs.virtual-text"
                end,
            },
            {
                "rcarriga/nvim-dap-ui",
                config = function()
                    require "custom.configs.dapui"
                end,
            },
        },
    },
    {
        "mawkler/modicator.nvim",
        event = "ModeChanged",
        init = function()
            vim.o.cursorline = true
            vim.o.number = true
            vim.o.termguicolors = true
        end,
        opts = {
            show_warnings = false,
            highlights = {
                defaults = { bold = true },
            },
        },
    },
    {
        "hinell/lsp-timeout.nvim",
        config = function()
            vim.g["lsp-timeout-config"] = {
                -- When focus is lost
                -- wait 5 minutes before stopping all LSP servers
                stopTimeout = 1000 * 60 * 5,
                startTimeout = 1000 * 10,
                silent = true,
            }
        end,
    },
    {
        "0oAstro/dim.lua",
        event = "LspAttach",
        config = function()
            require("dim").setup {}
        end,
    },
    {
        "chikko80/error-lens.nvim",
        ft = "go",
        config = true,
    },
    {
        "weilbith/nvim-code-action-menu",
        cmd = "CodeActionMenu",
        init = function()
            vim.g.code_action_menu_show_details = true
            vim.g.code_action_menu_show_diff = true
            vim.g.code_action_menu_show_action_kind = true
        end,
        config = function()
            dofile(vim.g.base46_cache .. "git")
            dofile(vim.g.base46_cache .. "codeactionmenu")
        end,
    },
    {
        "nvim-neotest/neotest",
        event = "LspAttach",
        dependencies = {
            "nvim-neotest/neotest-go",
            "haydenmeade/neotest-jest",
        },
        config = function()
            require "custom.configs.neotest"
        end,
    },
    {
        "ThePrimeagen/refactoring.nvim",
        event = "BufRead",
        config = function()
            require "custom.configs.refactoring"
        end,
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        ft = "go",
        opts = function ()
            return require "custom.configs.null-ls"
        end
    },
    {
        "smjonas/inc-rename.nvim",
        cmd = "IncRename",
        opts = {
            post_hook = function(results)
                if not results.changes then
                    return
                end

                -- if more than one file is changed, save all buffers
                local filesChang = #vim.tbl_keys(results.changes)
                if filesChang > 1 then
                    vim.cmd.wall()
                end

                -- FIX making the cmdline-history not navigable, pending: https://github.com/smjonas/inc-rename.nvim/issues/40
                vim.fn.histdel("cmd", "^IncRename ")
            end,
        },
    },
    {
        "ray-x/go.nvim",
        ft = { "go", "gomod", "gosum", "gowork" },
        dependencies = {
            {
                "ray-x/guihua.lua",
                build = "cd lua/fzy && make",
            },
            "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require "custom.configs.go"
        end,
        build = ':lua require("go.install").update_all_sync()',
  },
}

return plugins
