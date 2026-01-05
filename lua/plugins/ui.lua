-- ~/.config/nvim/lua/plugins/ui.lua

return {
  -- IDE-like tabline
  {
    'akinsho/bufferline.nvim',
    version = "v4.5.0",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers", -- set to "tabs" if you want to use vim tabs
          separator_style = "slant",
          indicator = {
            style = 'underline',
          },
          show_buffer_close_icons = true,
          show_close_icon = true,
          -- Use a smaller buffer number font
          numbers = "buffer_id", 
          -- Other options...
        }
      })
      -- Keybindings for bufferline navigation
      vim.keymap.set('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>', { desc = 'Cycle to next buffer' })
      vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', { desc = 'Cycle to previous buffer' })
    end,
  },
  -- Keybinding guide
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section for more details
    }
  },
}
