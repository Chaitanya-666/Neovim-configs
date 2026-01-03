-- ~/.config/nvim/lua/plugins/nvim-tree.lua

return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("nvim-tree").setup({
      view = {
        width = 30,
        mappings = {
          list = {
            { key = "c", action = "cd" },
          },
        },
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = true,
        custom = { ".git", "node_modules", ".cache" },
      },
    })
    vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>')
  end
}
