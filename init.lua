-- ~/.config/nvim/init.lua

-- Neovim 0.10 compatibility polyfill for plugins using Neovim 0.11+ vim.validate signature
local orig_validate = vim.validate
vim.validate = function(...)
  local nargs = select("#", ...)
  if nargs == 1 and type(...) == "table" then
    return orig_validate(...)
  end
  local name, val, validator, optional = ...
  if optional and val == nil then
    return true
  end
  return orig_validate({ [name] = { val, validator, optional } })
end

-- Load core modules
require("core.options")
require("core.keymaps")
require("core.autocmds")
require("core.commands")
require("core.performance")

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Setup plugins
local ok, lazy = pcall(require, "lazy")
if not ok then
  vim.api.nvim_echo({{"Lazy.nvim not found! Restart Neovim or check your internet connection.", "ErrorMsg"}}, true, {})
  return
end

lazy.setup('plugins', {
  ui = {
    border = "rounded",
  },
  change_detection = {
    notify = false,
  },
  checker = {
    enabled = true,
    notify = false,
  },
  rocks = {
    enabled = false,
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
