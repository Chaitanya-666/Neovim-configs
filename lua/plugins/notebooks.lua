-- ~/.config/nvim/lua/plugins/notebooks.lua

return {
  {
    "benlubas/molten-nvim",
    version = "^1.0.0",
    dependencies = { "3rd/image.nvim" },
    build = ":UpdateRemotePlugins",
    init = function()
      vim.g.molten_auto_open_output = false
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_output_win_max_height = 20
      
      -- Auto-detect environment based on CWD
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "*.ipynb",
        callback = function()
          local venv = os.getenv("VIRTUAL_ENV")
          if venv then
            vim.cmd("MoltenInit " .. venv .. "/bin/python3")
          else
            -- Fallback: Check if there's a .venv in current directory
            local local_venv = vim.fn.getcwd() .. "/.venv/bin/python3"
            if vim.fn.executable(local_venv) == 1 then
              vim.cmd("MoltenInit " .. local_venv)
            else
              vim.cmd("MoltenInit python3")
            end
          end
        end,
      })
    end,
  },
  {
    "quarto-dev/quarto-nvim",
    dependencies = { "jmbuhr/otter.nvim" },
    opts = {},
  },
}
