-- ~/.config/nvim/lua/core/commands.lua

-- User defined commands

-- Toggle diagnostics
vim.api.nvim_create_user_command("ToggleDiagnostics", function()
  local enabled = vim.diagnostic.is_disabled()
  if enabled then
    vim.diagnostic.enable()
    print("Diagnostics enabled")
  else
    vim.diagnostic.disable()
    print("Diagnostics disabled")
  end
end, {})

-- Keymap for toggling diagnostics
vim.keymap.set("n", "<leader>td", "<cmd>ToggleDiagnostics<cr>", { desc = "Toggle Diagnostics" })

-- Reload config (experimental)
vim.api.nvim_create_user_command("ReloadConfig", function()
  for name,_ in pairs(package.loaded) do
    if name:match('^core') or name:match('^plugins') then
      package.loaded[name] = nil
    end
  end
  dofile(vim.env.MYVIMRC)
  print("Config reloaded!")
end, {})