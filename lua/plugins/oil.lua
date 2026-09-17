-- ~/.config/nvim/lua/plugins/oil.lua

return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "-", "<cmd>Oil<cr>", desc = "Open parent directory with Oil" },
    { "<leader>o", "<cmd>Oil --float<cr>", desc = "Open Oil floating file manager" },
  },
  config = function()
    require("oil").setup({
      default_file_explorer = false, -- keep nvim-tree as default explorer, Oil on demand
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      view_options = {
        show_hidden = true,
      },
      float = {
        padding = 2,
        max_width = 90,
        max_height = 30,
        border = "rounded",
      },
    })
  end,
}
