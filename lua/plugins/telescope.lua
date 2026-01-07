-- ~/.config/nvim/lua/plugins/telescope.lua

return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      config = function()
        require('telescope').load_extension('fzf')
      end,
    },
    {
      'nvim-telescope/telescope-ui-select.nvim',
      config = function()
        require('telescope').load_extension('ui-select')
      end,
    },
  },
  config = function()
    local telescope = require('telescope')
    local actions = require('telescope.actions')

    telescope.setup({
      defaults = {
        path_display = { 'truncate' },
        mappings = {
          i = {
            ['<C-k>'] = actions.move_selection_previous, -- move to prev result
            ['<C-j>'] = actions.move_selection_next, -- move to next result
            ['<C-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
            ['<C-x>'] = actions.delete_buffer, -- Added mapping to delete buffer
          },
          n = {
            ['<C-x>'] = actions.delete_buffer, -- Added mapping to delete buffer
          }
        },
      },
      pickers = {
        find_files = {
          theme = "dropdown",
        },
        live_grep = {
          theme = "dropdown",
        },
        buffers = {
          theme = "dropdown",
        },
        help_tags = {
          theme = "dropdown",
        },
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    })

    vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>') -- find files
    vim.keymap.set('n', '<leader>fs', '<cmd>Telescope live_grep<cr>') -- live grep
    vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>') -- find buffers
    vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<cr>') -- help tags
  end,
}