-- ~/.config/nvim/lua/core/commands.lua

vim.api.nvim_create_user_command('UserGuide', function()
  vim.cmd('e ~/.config/nvim/lua/guide.lua')
end, {})

vim.api.nvim_create_user_command('Profile', function()
  local file = io.open("startup.log", "w")
  if file then
    file:write(vim.fn.execute("profile start startup.log | profile file * | profile func *"))
    file:close()
    vim.cmd("e startup.log")
  end
end, {})

-- Command to show the keymap guide
vim.api.nvim_create_user_command('KeymapGuide', function()
  require('guide').show_guide()
end, {})

-- Keymap to open the guide
vim.keymap.set('n', '<leader>g', '<cmd>KeymapGuide<cr>', { noremap = true, silent = true, desc = "Show keymap guide" })
