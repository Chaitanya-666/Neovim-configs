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

-- ADD THIS LINE to verify it exists before requiring
local ok, lazy = pcall(require, "lazy")
if not ok then
  vim.api.nvim_echo({{"Lazy.nvim not found! Restart Neovim or check your internet connection.", "ErrorMsg"}}, true, {})
  return
end

lazy.setup('plugins')
