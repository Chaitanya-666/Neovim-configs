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
          -- FIXED: Changed from "nvim_lsp" to false to avoid segments error
          -- You can re-enable after updating noice.nvim or bufferline
          diagnostics = false, -- Temporarily disabled - set to "nvim_lsp" when fixed
          diagnostics_update_in_insert = false,
          -- Alternative: use this custom indicator function instead
          -- diagnostics_indicator = function(count, level, diagnostics_dict, context)
          --   return "("..count..")"
          -- end,
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              text_align = "left",
              separator = true
            }
          },
          -- FIXED: Ensure these are properly typed as lists
          groups = {
            options = {
              toggle_hidden_on_enter = true
            },
            items = {}, -- Empty list required
          },
          custom_areas = {
            right = function()
              -- FIXED: Must return a list/table of segments
              return {}
            end,
          },
        },
        -- FIXED: Explicitly define highlights to avoid nil segments
        highlights = {
          fill = {
            bg = {
              attribute = "bg",
              highlight = "Normal"
            }
          },
        },
      })
      
      -- Keymaps
      vim.keymap.set('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>', { desc = 'Cycle to next buffer' })
      vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', { desc = 'Cycle to previous buffer' })
      vim.keymap.set('n', '<leader>x', '<Cmd>bdelete<CR>', { desc = 'Close buffer' })
    end,
  },

  -- Key binding help
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {}
  },

  -- Indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
    config = function()
      require("ibl").setup({
        scope = { enabled = false },
      })
    end,
  },

  -- Better UI for vim.ui.select and input
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
  },

  -- Cmdline and notifications
  -- NOTE: If bufferline still errors, try disabling noice temporarily
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
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = false,
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    }
  },

  -- Notifications
  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 3000,
      background_colour = "#000000",
    },
  },
}
