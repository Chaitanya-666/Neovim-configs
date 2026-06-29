-- ~/.config/nvim/lua/plugins/treesitter.lua
-- COMPATIBLE WITH nvim-treesitter 1.0+ (main branch)

return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = "0.9.3", -- Pin to v0.9.3 to restore ts_utils for CodeCompanion
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "windwp/nvim-ts-autotag",
    },
    config = function()
      -- Use the older configs.setup API for v0.9.3
      require("nvim-treesitter.configs").setup({
        -- List of parsers to ensure are installed
        ensure_install = {
          "bash",
          "c",
          "cpp",
          "css",
          "diff",
          "html",
          "javascript",
          "jsdoc",
          "json",
          "jsonc",
          "lua",
          "luadoc",
          "luap",
          "markdown",
          "markdown_inline",
          "python",
          "query",
          "regex",
          "rust",
          "toml",
          "tsx",
          "typescript",
          "vim",
          "vimdoc",
          "yaml",
        },
        
        -- Auto-install missing parsers when entering buffer
        auto_install = true,
        
        -- Syntax highlighting module
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        
        -- Indentation module
        indent = {
          enable = true,
        },
        
        -- Incremental selection configuration
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
          },
        },
      })
      
      -- Setup autotag separately (it's a separate plugin)
      require("nvim-ts-autotag").setup({
        opts = {
          enable_close = true,
          enable_rename = true,
          enable_close_on_slash = true,
        },
      })
    end,
  },
}
