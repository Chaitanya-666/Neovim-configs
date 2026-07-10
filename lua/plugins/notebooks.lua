-- ~/.config/nvim/lua/plugins/notebooks.lua

return {
  -- Molten: Run code cells via Jupyter kernel (native, no external server)
  {
    "benlubas/molten-nvim",
    version = "^1.0.0",
    dependencies = { "3rd/image.nvim" },
    lazy = false,
    build = ":UpdateRemotePlugins",
    config = function()
      vim.g.molten_auto_open_output = false
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_output_win_max_height = 20
      
      -- Auto-init on python/markdown files that act as notebooks
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = { "*.ipynb", "*.py", "*.md" },
        callback = function(e)
          if vim.api.nvim_get_option_value("filetype", { buf = e.buf }) == "quarto" then
            return
          end
          vim.defer_fn(function()
            local status, molten = pcall(require, "molten")
            if status and molten and not molten.is_initialized() then
              vim.cmd("MoltenInit nvim-venv")
            end
          end, 100)
        end,
      })
    end,
  },

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
      "hkupty/iron.nvim", -- fallback repl if molten isn't used
      "akinsho/toggleterm.nvim",
      "benlubas/molten-nvim",
    },
    event = "VeryLazy",
    config = function()
      local nn = require("notebook-navigator")
      nn.setup({
        repl_provider = "molten", -- use molten for REPL instead of iron/toggleterm
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