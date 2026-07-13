-- ~/.config/nvim/lua/plugins/notebooks.lua

return {
  -- Notebook Navigator: Auto-detects cells, executes them, and navigates
  {
    "GCBallesteros/NotebookNavigator.nvim",
    keys = {
      { "]h", function() require("notebook-navigator").move_cell("d") end, desc = "Next Cell" },
      { "[h", function() require("notebook-navigator").move_cell("u") end, desc = "Prev Cell" },
      { "<leader>X", "<cmd>lua require('notebook-navigator').run_cell()<cr>", desc = "Run Cell" },
      { "<leader>x", "<cmd>lua require('notebook-navigator').run_and_move()<cr>", desc = "Run Cell and Move" },
    },
    dependencies = {
      "echasnovski/mini.comment",
      {
        "hkupty/iron.nvim", -- Use Iron.nvim for REPL
        config = function()
          local iron = require("iron.core")
          iron.setup({
            config = {
              scratch_repl = true,
              repl_definition = {
                python = {
                  command = { "ipython", "--no-autoindent" },
                  format = require("iron.fts.common").bracketed_paste,
                },
              },
              repl_open_cmd = require("iron.view").split.vertical.botright(50),
            },
          })
        end,
      },
      "akinsho/toggleterm.nvim",
    },
    event = "VeryLazy",
    config = function()
      local nn = require("notebook-navigator")
      nn.setup({
        repl_provider = "iron", -- use iron for REPL instead of molten
        setup_hydra = false,
      })
    end,
  },

  -- mini.ai for `ic` (inner cell) and `ac` (around cell) text objects
  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    dependencies = { "GCBallesteros/NotebookNavigator.nvim" },
    opts = function()
      local nn = require("notebook-navigator")
      return {
        custom_textobjects = {
          h = nn.miniai_spec,
        },
      }
    end,
  },

  -- Jupytext: Convert ipynb <-> markdown/python for pretty editing
  -- Uses the python CLI tool to convert seamlessly on read/write
  {
    "goerz/jupytext.vim",
    lazy = false,
    config = function()
      -- The default format that jupytext will use when opening ipynb files
      -- We use 'py:percent' so it opens as a pure Python script with '# %%' cell markers.
      -- This gives perfect LSP support and prevents Markdown comment syntax errors.
      vim.g.jupytext_fmt = "py:percent"
      -- Tell jupytext.vim to use our wrapper that handles empty files automatically
      vim.g.jupytext_command = vim.fn.expand("~/.local/bin/jupytext-wrapper")
    end,
  },

  -- Quarto support (optional, for .qmd files)
  {
    "quarto-dev/quarto-nvim",
    dependencies = { "jmbuhr/otter.nvim" },
    ft = { "quarto", "r" },
    opts = {},
  },
}