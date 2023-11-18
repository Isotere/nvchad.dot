local M = {}

-- <C> -> Ctrl
-- <leader> -> Space
-- <A> -> alt
-- <S> -> shift
-- <M> -> meta (cmd key on mac)
-- <D> -> super (windows key on windows)
-- <kPoint> -> Keypad Point (.)
-- <kEqual> -> Keypad Equal (=)
-- <kPlus> -> Keypad Plus (+)
-- <kMinus> -> Keypad Minus (-)

---@param key 'h'|'j'|'k'|'l'
local function move_or_create_win(key)
    local fn = vim.fn
    local curr_win = fn.winnr()
    vim.cmd("wincmd " .. key) --> attempt to move

    if curr_win == fn.winnr() then --> didn't move, so create a split
        if key == "h" or key == "l" then
            vim.cmd "wincmd v"
        else
            vim.cmd "wincmd s"
        end

        vim.cmd("wincmd " .. key)
    end
end

---@param direction 'up'|'down'
local function duplicate_lines(direction)
    local startline = vim.fn.line("v")
    local endline = vim.fn.getcurpos()[2]

    -- swap
    if startline > endline then
        startline, endline = endline, startline
    end

    local texts = vim.api.nvim_buf_get_lines(0, startline - 1, endline, true)

    if direction == "up" then
        vim.api.nvim_buf_set_lines(0, endline, endline, true, texts)
    elseif direction == "down" then
        vim.api.nvim_buf_set_lines(0, startline, startline + 1, true, texts)
    end
end

M.nvimtree = {
    n = {
        ["<leader>e"] = {"<CMD>:NvimTreeToggle<CR>", "Toggle Nvim-Tree", opts = {silent = true}}
    }
}

M.development = {
    n = {
        ["gd"] = {
            function()
                vim.lsp.buf.definition()
            end,
            "󰑊 Go to definition",
        },
        ["gi"] = {
            function()
                vim.lsp.buf.implementation()
            end,
            "󰑊 Go to implementation",
        },
    },
}

M.dap = {
    plugin = true,
    n = {
    }
}

M.text = {
    n = {
        -- Renamer
        ["<leader>ra"] = {
            function()
                require("nvchad.renamer").open()
            end,
            "󰑕 LSP rename",
        },
        ["<leader>rn"] = {
            function()
                return ":IncRename " .. vim.fn.expand "<cword>"
            end,
            -- ":IncRename "
            "󰑕 Rename",
            opts = { expr = true },
        },
    },
}

M.go = {
    n = {
        ["<leader>fi"] = { " <CMD>:GoImport<CR>", " Format imports", opts = { silent = true } },
        ["<leader>gif"] = { " <CMD>:GoIfErr<CR>", " Create If Err", opts = { silent = true } },
        ["<leader>gfs"] = { " <CMD>:GoFillStruct<CR>", " Fill struct", opts = { silent = true } },
        ["<leader>gcv"] = { " <CMD>:GoCoverage -p<CR>", " Show coverage", opts = { silent = true } },
        ["<leader>gt"] = { " <CMD>:GoAlt!<CR>", " Go to test", opts = { silent = true } },
        ["<leader>gca"] = { " <CMD>:GoCodeAction<CR>", " Code action", opts = { silent = true } },
        ["<leader>cl"] = { " <CMD>:GoCodeLenAct<CR>", " Code Lens", opts = { silent = true } },
    },
}

M.window = {
    n = {
    },
}

M.general = {
    n = {
        ["<leader>w"] = {
            function()
                require("nvchad.tabufline").close_buffer()
            end,
            " Close buffer",
        },
    },
}

M.treesitter = {
    n = {
    },
}

M.debug = {
    n = {
    },
}

M.git = {
    n = {
        ["<leader>gc"] = { "<CMD>Telescope git_commits<CR>", "  Git commits" },
        ["<leader>gb"] = { "<CMD>Telescope git_branches<CR>", "  Git branches" },
        ["<leader>gs"] = { "<CMD>Telescope git_status<CR>", "  Git status" },
    },
}

M.telescope = {
    n = {
        ["<leader>li"] = { "<CMD>Telescope highlights<CR>", "Highlights" },
        ["<leader>fk"] = { "<CMD>Telescope keymaps<CR>", " Find keymaps" },
        ["<leader>fs"] = { "<CMD>Telescope lsp_document_symbols<CR>", " Find document symbols" },
        ["<leader>fr"] = { "<CMD>Telescope frecency<CR>", " Recent files" },
        ["<leader>fu"] = { "<CMD>Telescope undo<CR>", " Undo tree" },
        ["<leader>fg"] = { "<CMD>Telescope ast_grep<CR>", " Structural Search" },
        ["<leader>fre"] = {
            function()
                require("telescope").extensions.refactoring.refactors()
            end,
            " Structural Search",
        },
        ["<leader>fz"] = {
            "<CMD>Telescope current_buffer_fuzzy_find fuzzy=false case_mode=ignore_case<CR>",
            " Find current file",
        },
        ["<leader>ff"] = {
            function()
                local builtin = require "telescope.builtin"
                -- ignore opened buffers if not in dashboard or directory
                if vim.fn.isdirectory(vim.fn.expand "%") == 1 or vim.bo.filetype == "alpha" then
                    builtin.find_files()
                else
                    local function literalize(str)
                        return str:gsub("[%(%)%.%%%+%-%*%?%[%]%^%$]", function(c)
                            return "%" .. c
                        end)
                    end

                    local function get_open_buffers()
                        local buffers = {}
                        local len = 0
                        local vim_fn = vim.fn
                        local buflisted = vim_fn.buflisted

                        for buffer = 1, vim_fn.bufnr "$" do
                            if buflisted(buffer) == 1 then
                                len = len + 1
                                -- get relative name of buffer without leading slash
                                buffers[len] = "^"
                                .. literalize(string.gsub(vim.api.nvim_buf_get_name(buffer), literalize(vim.loop.cwd()), ""):sub(2))
                                .. "$"
                            end
                        end

                        return buffers
                    end

                    builtin.find_files {
                        file_ignore_patterns = get_open_buffers(),
                    }
                end
            end,
            "Find files",
        },
    },
}

M.tabufline = {
    plugin = true,

    n = {
        -- cycle through buffers
        ["<tab>"] = {
            function()
                require("nvchad.tabufline").tabuflineNext()
            end,
            " Goto next buffer",
        },

        ["<S-tab>"] = {
            function()
                require("nvchad.tabufline").tabuflinePrev()
            end,
        " Goto prev buffer",
        },

        -- close buffer + hide terminal buffer
        ["<C-x>"] = {
            function()
                require("nvchad.tabufline").close_buffer()
            end,
            " Close buffer",
        },

        -- close all buffers
        ["<leader>bx"] = {
            function()
                local current_buf = vim.api.nvim_get_current_buf()
                local all_bufs = vim.api.nvim_list_bufs()

                for _, buf in ipairs(all_bufs) do
                    if buf ~= current_buf and vim.fn.getbufinfo(buf)[1].changed ~= 1 then
                        vim.api.nvim_buf_delete(buf, { force = true })
                    end
                end
            end,
            " Close all but current buffer",
        },
    },
}

M.test = {
    n = {
        ["<leader>nt"] = {
            function()
                require("neotest").run.run(vim.fn.expand "%")
            end,
            "󰤑 Run neotest",
        },
    },
}

M.nvterm = {
        t = {
            -- toggle in terminal mode
            ["C-c"] = { [[<C-\><C-c>]], "󰜺 Send SigInt" },
        },

}


return M
