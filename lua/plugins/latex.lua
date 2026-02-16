-- ~/.config/nvim/lua/plugins/latex.lua
-- VimTeX configuration for LaTeX editing with Zathura

return {
  {
    "lervag/vimtex",
    lazy = false,
    config = function()
      -- PDF viewer: Zathura with sync support
      vim.g.vimtex_view_method = "zathura"
      vim.g.vimtex_view_zathura_options = "-x 'nvim --servername " .. vim.v.servername .. " --remote +%{line} %{input}'"
      
      -- Forward search configuration
      vim.g.vimtex_view_forward_search_on_start = true
      
      -- Compiler: latexmk with continuous compilation
      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_compiler_latexmk = {
        build_dir = "build",
        callback = 1,
        continuous = 1,
        executable = "latexmk",
        options = {
          "-shell-escape",      -- For minted syntax highlighting
          "-synctex=1",         -- Enable source-PDF synchronization
          "-interaction=nonstopmode",
          "-file-line-error",
          "-verbose",
        },
      }
      
      -- Enable conceal for better readability (shows rendered symbols)
      vim.g.vimtex_syntax_conceal = {
        accents = 1,
        cites = 1,
        fancy = 1,
        greek = 1,
        math_bounds = 1,
        math_delimiters = 1,
        math_symbols = 1,
        sections = 0,  -- Keep \section visible for editing
        styles = 1,
      }
      
      -- TOC settings
      vim.g.vimtex_toc_config = {
        split_pos = "leftabove",
        split_width = 30,
        show_help = 0,
        show_numbers = 1,
      }
      
      -- Disable default mappings (we define our own)
      vim.g.vimtex_mappings_enabled = 0
      
      -- Enable folding for document structure
      vim.g.vimtex_fold_enabled = 1
      vim.g.vimtex_fold_types = {
        sections = { enabled = 1 },
        envs = { enabled = 1 },
      }
      
      -- Quickfix settings
      vim.g.vimtex_quickfix_mode = 2  -- Auto-open on errors
      vim.g.vimtex_quickfix_open_on_warning = 0  -- Don't open on warnings
    end,
    keys = {
      -- Compilation
      { "<leader>lc", "<cmd>VimtexCompile<cr>", desc = "Compile LaTeX", ft = "tex" },
      { "<leader>lC", "<cmd>VimtexCompileSS<cr>", desc = "Compile once", ft = "tex" },
      -- Viewing
      { "<leader>lv", "<cmd>VimtexView<cr>", desc = "View PDF", ft = "tex" },
      { "<leader>ls", "<cmd>VimtexSyncView<cr>", desc = "Sync to PDF", ft = "tex" },
      -- Errors and info
      { "<leader>le", "<cmd>VimtexErrors<cr>", desc = "Show errors", ft = "tex" },
      { "<leader>li", "<cmd>VimtexInfo<cr>", desc = "VimTeX info", ft = "tex" },
      -- Navigation
      { "<leader>lt", "<cmd>VimtexTocToggle<cr>", desc = "Toggle TOC", ft = "tex" },
      -- Cleanup
      { "<leader>lg", "<cmd>VimtexClean<cr>", desc = "Clean aux files", ft = "tex" },
      { "<leader>lG", "<cmd>VimtexClean!<cr>", desc = "Clean all", ft = "tex" },
      -- Motion (go to section/environment)
      { "<leader>[[", "<plug>(vimtex-[m)", desc = "Prev environment", ft = "tex", remap = true },
      { "<leader>]]", "<plug>(vimtex-]m)", desc = "Next environment", ft = "tex", remap = true },
    },
  },
}
