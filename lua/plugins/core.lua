return {
  -- Colorscheme
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "storm",
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd.colorscheme "tokyonight"
    end
  },

  -- Syntax Highlighting
  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   build = ":TSUpdate",
  --   lazy = false,
  --   event = "VimEnter",
  --   dependencies = {
  --     "nvim-treesitter/nvim-treesitter-textobjects",
  --   },
  --   config = function()
  --     require("nvim-treesitter.configs").setup({
  --       ensure_installed = { "c", "lua", "vim", "vimdoc", "javascript", "typescript", "python", "rust", "go", "bash" },
  --       highlight = { enable = true },
  --       indent = { enable = true },
  --     })
  --     vim.cmd("TSUpdate")
  --   end,
  -- },

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
        -- Only set up format on save if the server supports it
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = vim.api.nvim_create_augroup("LspFormat." .. bufnr, {}),
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ bufnr = bufnr })
            end,
          })
        end
      end

      mason_lspconfig.setup({
        ensure_installed = { "lua_ls", "tsserver", "pyright" },
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
