-- ~/.config/nvim/lua/plugins/ui.lua

return {
  -- Buffers
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers",
          separator_style = "slant",
          diagnostics = "nvim_lsp",
          diagnostics_indicator = function(count, level)
            local icon = level:match("error") and " " or " "
            return " " .. icon .. count
          end,
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              text_align = "left",
              separator = true
            }
          },
          show_buffer_close_icons = true,
          show_close_icon = false,
          color_icons = true,
          modified_icon = "●",
        },
      })
      
      -- Keymaps
      vim.keymap.set('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>', { desc = 'Cycle to next buffer' })
      vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', { desc = 'Cycle to previous buffer' })
      vim.keymap.set('n', '<leader>x', '<Cmd>bdelete<CR>', { desc = 'Close buffer' })
    end,
  },

  -- Key binding help with registered group names
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      spec = {
        { "<leader>a", group = "AI Assistant" },
        { "<leader>c", group = "Code & Diagnostics" },
        { "<leader>d", group = "Debugger" },
        { "<leader>f", group = "Find & Telescope" },
        { "<leader>g", group = "Git" },
        { "<leader>q", group = "Session & Quit" },
        { "<leader>r", group = "Notebook / Run" },
        { "<leader>u", group = "UI & Smart Toggles" },
        { "<leader>x", group = "Trouble Diagnostics" },
      },
    },
  },

  -- Indent guides with active scope highlighting
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      indent = {
        char = "│",
        tab_char = "│",
      },
      scope = {
        enabled = true,
        show_start = true,
        show_end = false,
        highlight = { "Keyword", "Function" },
      },
    },
  },

  -- Better UI for vim.ui.select and input
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
  },

  -- Sleek Cmdline, Floating Palette, and Notifications
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        progress = {
          enabled = true,
          view = "mini",
        },
      },
      notify = {
        enabled = true,
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = true,
        lsp_doc_border = true,
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    }
  },

  -- Floating Notifications with smooth fade
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    opts = {
      timeout = 3000,
      render = "wrapped-compact",
      stages = "fade",
      top_down = false,
    },
  },
}
