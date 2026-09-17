-- ~/.config/nvim/lua/plugins/ide.lua

return {
  -- 1. Trouble: Sleek IDE Diagnostics, LSP References, and Quickfix List
  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    opts = {
      modes = {
        preview_float = {
          mode = "diagnostics",
          preview = {
            type = "float",
            relative = "editor",
            border = "rounded",
            title = "Preview",
            title_pos = "center",
            position = { 0, -2 },
            size = { width = 0.4, height = 0.4 },
            zindex = 200,
          },
        },
      },
    },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "IDE: Workspace Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "IDE: Buffer Diagnostics (Trouble)" },
      { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "IDE: Symbols Outline (Trouble)" },
      { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "IDE: LSP Definitions/References (Trouble)" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "IDE: Location List (Trouble)" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "IDE: Quickfix List (Trouble)" },
    },
  },

  -- 2. Aerial: Fast, Clean Code Outline Sidebar (Classes, Methods, Functions)
  {
    "stevearc/aerial.nvim",
    opts = {
      layout = {
        max_width = { 40, 0.25 },
        min_width = 25,
        default_direction = "prefer_right",
      },
      show_guides = true,
      filter_kind = false,
      nerd_font = "auto",
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>co", "<cmd>AerialToggle!<cr>", desc = "IDE: Toggle Code Outline (Aerial)" },
    },
  },

  -- 3. Treesitter Context: Sticky Function/Class headers while scrolling
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      enable = true,
      max_lines = 3,
      min_window_height = 0,
      line_numbers = true,
      multiline_threshold = 20,
      trim_scope = "outer",
      mode = "cursor",
    },
  },

  -- 4. Persistence: Automated Session Management (Restore buffers, tabs, layout)
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = { options = vim.opt.sessionoptions:get() },
    keys = {
      { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Session" },
    },
  },
}
