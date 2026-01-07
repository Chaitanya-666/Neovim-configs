return {
  'glepnir/dashboard-nvim',
  event = 'VimEnter',
  config = function()
    require('dashboard').setup({
      theme = 'hyper',
      config = {
        week_header = {
          enable = true,
        },
        shortcut = {
          { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
          { desc = ' New file', group = 'Number', action = 'enew', key = 'n' },
          { desc = ' Find file', group = 'DiagnosticHint', action = 'Telescope find_files', key = 'f' },
          { desc = 'RECENT FILES', group = 'Number', action = 'Telescope oldfiles', key = 'r' },
          { desc = ' Find text', group = 'DiagnosticInfo', action = 'Telescope live_grep', key = 'g' },
        },
      },
    })
  end,
  dependencies = { 'nvim-tree/nvim-web-devicons' }
}
