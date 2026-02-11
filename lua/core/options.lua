-- ~/.config/nvim/lua/core/options.lua

local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Indentation
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true

-- Appearance
opt.termguicolors = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Clipboard
-- Check if we are in Termux
if os.getenv("TERMUX_VERSION") then
  -- Termux clipboard integration
  vim.g.clipboard = {
    name = "termux-clipboard",
    copy = {
      ["+"] = "termux-clipboard-set",
      ["*"] = "termux-clipboard-set",
    },
    paste = {
      ["+"] = "termux-clipboard-get",
      ["*"] = "termux-clipboard-get",
    },
    cache_enabled = 1,
  }
else
  -- Standard clipboard integration
  opt.clipboard = "unnamedplus"
end

-- Backups & Undo
opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.undofile = true
opt.undolevels = 10000

-- Behavior
opt.updatetime = 200
opt.timeoutlen = 300
opt.splitbelow = true
opt.splitright = true

-- Folding (using Treesitter usually, but good defaults help)
opt.foldmethod = "manual"
opt.foldenable = false

-- Global
vim.g.mapleader = " "
vim.g.maplocalleader = " "