local M = {}

M.mason = {
    ensure_installed = {
        -- lua stuff
        "lua-language-server",
        "stylua",

        -- Spell
        "codespell",
        "marksman",
        "grammarly-languageserver",

        -- Json
        "jsonlint",
        "json-lsp",

        "dockerfile-language-server",
        "yaml-language-server",

        -- golang
        "gopls",
        "goimports",
        "goimports-reviser",
        "gofumpt",
        "gotests",
        "golines",
        "gomodifytags",
        "golangci-lint",
        "impl",
        "iferr",

        -- DAP
        "delve",
    },

    ui = {
        icons = {
            package_pending = " ",
            package_installed = "󰄳 ",
            package_uninstalled = "󰇚 ",
        },

        keymaps = {
            toggle_server_expand = "<CR>",
            install_server = "i",
            update_server = "u",
            check_server_version = "c",
            update_all_servers = "U",
            check_outdated_servers = "C",
            uninstall_server = "X",
            cancel_installation = "<C-c>",
        },
    },
}

M.treesitter = {
    auto_install = true,
    ensure_installed = {
        "vim",
        "lua",
        "bash",
        "json",
        "json5",
        "yaml",
        "dockerfile",
        "regex",
        "toml",

        -- Markdown
        "markdown",
        "markdown_inline",
        -- Go Lang
        "go",
        "gomod",
        "gowork",
        "gosum",
    },
    indent = {
        enable = true,
    },
    playground = {
        enable = true,
    },
    query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = { "BufWrite", "CursorHold" },
    },
    textsubjects = {
        enable = true,
        keymaps = {
            ["."] = "textsubjects-smart",
            [";"] = "textsubjects-container-outer",
            ["i;"] = "textsubjects-container-inner",
        },
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            include_surrounding_whitespace = true,
            keymaps = {
                ["af"] = { query = "@function.outer", desc = "ts: all function" },
                ["if"] = { query = "@function.inner", desc = "ts: inner function" },
                ["ac"] = { query = "@class.outer", desc = "ts: all class" },
                ["ic"] = { query = "@class.inner", desc = "ts: inner class" },
                ["aC"] = { query = "@conditional.outer", desc = "ts: all conditional" },
                ["iC"] = { query = "@conditional.inner", desc = "ts: inner conditional" },
                ["aH"] = { query = "@assignment.lhs", desc = "ts: assignment lhs" },
                ["aL"] = { query = "@assignment.rhs", desc = "ts: assignment rhs" },
            },
        },
    },
    tree_setter = {
        enable = true,
    },
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },
    autotag = {
        enable = true,
    },
}

M.nvterm = {
    terminals = {
        shell = vim.o.shell,
        list = {},
        type_opts = {
            float = {
                relative = "editor",
                row = 0.1,
                col = 0.1,
                width = 0.8,
                height = 0.7,
                border = "single",
            },
            horizontal = { location = "rightbelow", split_ratio = 0.3 },
            vertical = { location = "rightbelow", split_ratio = 0.25 },
        },
    },
    behavior = {
        autoclose_on_quit = {
            enabled = false,
            confirm = true,
        },
        close_on_exit = true,
        auto_insert = true,
    },
}


M.devicons = {
    override_by_filename = {
        ["makefile"] = {
            icon = "",
            color = "#f1502f",
            name = "Makefile",
        },
        ["mod"] = {
            icon = "󰟓",
            color = "#519aba",
            name = "Mod",
        },
        ["yarn.lock"] = {
            icon = "",
            color = "#0288D1",
            name = "Yarn",
        },
        ["sum"] = {
            icon = "󰟓",
            color = "#cbcb40",
            name = "Sum",
        },
        [".gitignore"] = {
            icon = "",
            color = "#e24329",
            name = "GitIgnore",
        },
    }
}

-- git support in nvimtree
M.nvimtree = {
    filters = {
        dotfiles = false,
        custom = {
            "**/node_modules",
            "**/%.git",
            "**/%.github",
        },
    },
    git = {
        enable = true,
        ignore = false,
    },
    hijack_unnamed_buffer_when_opening = true,
    hijack_cursor = true,
    diagnostics = {
        enable = true,
        show_on_dirs = true,
        debounce_delay = 50,
        icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
        },
    },
    sync_root_with_cwd = true,
    renderer = {
        highlight_opened_files = "name",
        highlight_git = true,
        -- root_folder_label = ":~",
        group_empty = true,
        indent_markers = {
            enable = false,
            icons = {
                corner = "└ ",
                edge = "│ ",
                none = "  ",
            },
        },
        icons = {
            show = {
                git = true,
            },
            glyphs = {
                git = {
                    unstaged = "",
                    -- unstaged = "",
                    staged = "",
                    unmerged = "",
                    renamed = "➜",
                    -- untracked = "",
                    untracked = "",
                    deleted = "",
                    ignored = "◌",
                },
            },
        },
    },
    actions = {
        open_file = {
            quit_on_open = true,
            resize_window = false,
        },
    },
    tab = {
        sync = {
            open = true,
            close = true,
        },
    },
}

return M
