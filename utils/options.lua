local opt = vim.opt
local g = vim.g

vim.wo.statuscolumn = ""

opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.backup = false --- Recommended by coc
opt.swapfile = false
opt.scrolloff = 10 -- always show minimum n lines after current line
opt.relativenumber = true -- Show relative numberline
opt.wrap = false
opt.iskeyword:append "-"
opt.termguicolors = true -- True color support
opt.autoindent = true --- Good auto indent
opt.backspace = "indent,eol,start" --- Making sure backspace works
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4

-- Map in dotyfile
g.mapleader = " "
g.maplocalleader = " "

opt.cursorline = true

if g.neovide then
  -- opt.guifont = "Hack Nerd Font:h12"
  opt.guifont = "JetbrainsMono Nerd Font:h12"
  g.neovide_refresh_rate = 120
  g.neovide_remember_window_size = true
  g.neovide_cursor_antialiasing = true
  g.neovide_input_macos_alt_is_meta = true
  g.neovide_input_use_logo = false
  g.neovide_padding_top = 0
  g.neovide_padding_bottom = 0
  g.neovide_padding_right = 0
  g.neovide_padding_left = 0
  g.neovide_floating_blur_amount_x = 3.0
  g.neovide_floating_blur_amount_y = 3.0
end

