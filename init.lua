local opt = vim.opt

-- Disable underline in diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = false,
  signs = true,
  update_in_insert = false,
})


vim.fn.sign_define("DapBreakpoint", { text = "", numhl = "DapBreakpoint", texthl = "DapBreakpoint" })
vim.fn.sign_define("DagLogPoint", { text = "", numhl = "DapLogPoint", texthl = "DapLogPoint" })
vim.fn.sign_define("DapStopped", { text = "", numhl = "DapStopped", texthl = "DapStopped" })
vim.fn.sign_define("DapBreakpointRejected", { text = "", numhl = "DapBreakpointRejected", texthl = "DapBreakpointRejected" })

require "custom.utils.autocmd"
require "custom.utils.usercmd"
require "custom.utils.options"

return opt

