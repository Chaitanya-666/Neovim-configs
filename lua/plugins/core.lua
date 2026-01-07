return {


  -- Syntax Highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    event = "VimEnter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "c", "lua", "vim", "vimdoc", "javascript", "typescript", "python", "rust", "go", "bash" },
        highlight = { enable = true },
        indent = { enable = true },
      })
      vim.cmd("TSUpdate")
    end,
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require("mason").setup()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lspconfig = require("lspconfig")
      local mason_lspconfig = require("mason-lspconfig")

      -- This function runs when an LSP server attaches to a buffer.
      local on_attach = function(client, bufnr)
        -- Keymaps can be defined here for LSP-related actions
        -- Example: vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr })
      end

      mason_lspconfig.setup({
        ensure_installed = { "lua_ls", "tsserver", "pyright", "cpptools" },
      })

      mason_lspconfig.setup_handlers({
        function(server_name)
          lspconfig[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach, -- This enables format on save
          })
        end,
      })
    end
  },

  -- For transparency
  {
    "xiyaowong/transparent.nvim",
    config = function ()
      require("transparent").setup({
          extra_groups = {
              "NormalFloat",
              "NvimTreeNormal"
          }
      })
    end
  },
}
