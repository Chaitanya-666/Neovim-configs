-- ~/.config/nvim/lua/plugins/telescope.lua

local function safe_picker(picker_name, opts)
  return function()
    local current_win = vim.api.nvim_get_current_win()
    local current_buf = vim.api.nvim_win_get_buf(current_win)
    local ft = vim.bo[current_buf].filetype
    
    if ft == "NvimTree" or ft == "neo-tree" or vim.bo[current_buf].buftype == "nofile" then
      -- Try to find a normal window
      local wins = vim.api.nvim_tabpage_list_wins(0)
      local found = false
      for _, win in ipairs(wins) do
        local buf = vim.api.nvim_win_get_buf(win)
        local win_ft = vim.bo[buf].filetype
        local win_bt = vim.bo[buf].buftype
        if win_ft ~= "NvimTree" and win_ft ~= "neo-tree" and win_bt ~= "nofile" then
          vim.api.nvim_set_current_win(win)
          found = true
          break
        end
      end
      if not found then
        vim.cmd("wincmd w")
      end
    end
    
    local resolved_opts = opts
    if type(opts) == "function" then
      resolved_opts = opts()
    end
    require('telescope.builtin')[picker_name](resolved_opts)
  end
end

return {
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    cmd = 'Telescope',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make', -- NOTE: This requires 'make' and 'gcc' to be installed
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
    },
    keys = {
      { '<leader>ff', safe_picker('find_files'), desc = '[F]ind [F]iles' },
      { '<leader>gf', safe_picker('git_files'), desc = 'Search [G]it [F]iles' },
      { '<leader>fs', safe_picker('live_grep'), desc = '[F]ind by [G]rep' },
      { '<leader>fw', safe_picker('grep_string'), desc = '[F]ind current [W]ord' },
      { '<leader>fd', safe_picker('diagnostics'), desc = '[F]ind [D]iagnostics' },
      { '<leader>fr', safe_picker('resume'), desc = '[F]ind [R]esume' },
      { '<leader>fo', safe_picker('oldfiles'), desc = '[F]ind [O]ldfiles' },
      { '<leader>fb', safe_picker('buffers'), desc = '[F]ind [B]uffers' },
      {
        '<leader>/',
        safe_picker('current_buffer_fuzzy_find', function()
          return require('telescope.themes').get_dropdown {
            winblend = 10,
            previewer = false,
          }
        end),
        desc = '[/] Fuzzily search in current buffer',
      },
    },
    config = function()
      local telescope = require('telescope')
      local actions = require('telescope.actions')

      telescope.setup({
        defaults = {
          prompt_prefix = " ",
          selection_caret = " ",
          path_display = { "truncate" },
          mappings = {
            i = {
              ['<C-k>'] = actions.move_selection_previous,
              ['<C-j>'] = actions.move_selection_next,
              ['<C-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
              ["<C-d>"] = actions.preview_scrolling_down,
              ["<C-u>"] = actions.preview_scrolling_up,
            },
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      })

      -- Enable telescope fzf native, if installed
      pcall(telescope.load_extension, 'fzf')
      pcall(telescope.load_extension, 'ui-select')
    end,
  },
}
