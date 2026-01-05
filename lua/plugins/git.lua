-- ~/.config/nvim/lua/plugins/git.lua

return {
  -- Git integration
  {
    'lewis6991/gitsigns.nvim',
    event = "BufReadPre",
    config = function()
      require('gitsigns').setup({
        signs = {
          add          = { text = '│' },
          change       = { text = '│' },
          delete       = { text = '_' },
          topdelete    = { text = '‾' },
          changedelete = { text = '~' },
        },
        -- You can add keymaps here for navigating hunks, etc.
        -- For example:
        -- on_attach = function(bufnr)
        --   local gs = package.loaded.gitsigns
        --   vim.keymap.set('n', ']c', function()
        --     if vim.wo.diff then return ']c' end
        --     vim.schedule(function() gs.next_hunk() end)
        --     return '<Ignore>'
        --   end, {expr=true, buffer=bufnr, desc="Next Hunk"})
        -- end
      })
    end
  }
}
