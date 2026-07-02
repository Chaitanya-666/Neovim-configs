-- ~/.config/nvim/lua/plugins/lsp.lua

return {
  -- SchemaStore plugin for JSON/YAML schemas (REQUIRED for jsonls/yamlls)
  {
    "b0o/SchemaStore.nvim",
    lazy = true,
    version = false, -- last release is way too old
  },

  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    version = "1.2.0", -- Pin to avoid Neovim 0.10 deprecation warnings in 3.0.0
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "williamboman/mason.nvim", config = true },
      { "williamboman/mason-lspconfig.nvim", version = "v1.32.0" },
      "hrsh7th/cmp-nvim-lsp",
      "b0o/SchemaStore.nvim", -- ADDED: Required for jsonls/yamlls schemas
    },
    config = function()
      require("mason").setup()
      local mason_lspconfig = require("mason-lspconfig")
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      mason_lspconfig.setup({
        ensure_installed = {
          "pyright",
          "ruff",      -- Fast python linter/formatter (AI/ML standard)
          "ts_ls",
          "tailwindcss", -- Fullstack
          "emmet_ls",    -- Fullstack HTML/JSX
          "html",
          "cssls",
          "jsonls",  -- JSON language server (requires schemastore)
          "yamlls",  -- YAML language server (requires schemastore)
          "bashls",
          "lua_ls",
          "clangd",
        },
      })

      -- Default handler for installed servers
      if mason_lspconfig.setup_handlers then
        mason_lspconfig.setup_handlers({
          function(server_name)
            lspconfig[server_name].setup({
              capabilities = capabilities,
            })
          end,
          
          -- Custom handler for jsonls with SchemaStore
          ["jsonls"] = function()
            lspconfig.jsonls.setup({
              capabilities = capabilities,
              settings = {
                json = {
                  schemas = require("schemastore").json.schemas(),
                  validate = { enable = true },
                },
              },
            })
          end,
          
          -- Custom handler for yamlls with SchemaStore
          ["yamlls"] = function()
            lspconfig.yamlls.setup({
              capabilities = capabilities,
              settings = {
                yaml = {
                  schemaStore = {
                    enable = false, -- Disable built-in to use SchemaStore.nvim
                    url = "",
                  },
                  schemas = require("schemastore").yaml.schemas(),
                  validate = true,
                  format = { enable = true },
                },
              },
            })
          end,

          -- Custom handler for lua_ls
          ["lua_ls"] = function()
            lspconfig.lua_ls.setup({
              capabilities = capabilities,
              settings = {
                Lua = {
                  diagnostics = {
                    globals = { "vim" },
                  },
                  workspace = {
                    library = {
                      [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                      [vim.fn.stdpath("config") .. "/lua"] = true,
                    },
                  },
                },
              },
            })
          end,
        })
      end
      -- ~/.config/nvim/lua/plugins/lsp.lua
      -- Add this after lspconfig.lua_ls.setup({...})

      -- texlab for LaTeX (installed via pacman, not Mason)
      lspconfig.texlab.setup({
	      capabilities = capabilities,
	      settings = {
		      texlab = {
			      build = {
				      executable = "latexmk",
				      args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
				      onSave = true,
				      forwardSearchAfter = false, -- We use VimTeX for forward search
			      },
			      chktex = {
				      onOpenAndSave = true,
				      onEdit = true,
			      },
			      diagnostics = {
				      ignoredPatterns = { "Overfull", "Underfull", "specifier changed to" },
			      },
			      formatterLineLength = 80,
		      },
	      },
      })
      -- Keymaps
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local opts = { buffer = ev.buf }
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
          vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
          vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
          vim.keymap.set("n", "<leader>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, opts)
          vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        end,
      })
    end,
  },
  
  -- Linting
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        python = { "pylint", "ruff" },
      }

      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          -- Only run linters if their executable is actually installed
          local names = lint._resolve_linter_by_ft(vim.bo.filetype)
          if #names == 0 then return end
          
          local linters_to_run = {}
          for _, name in ipairs(names) do
            local linter = lint.linters[name]
            if linter then
              local cmd = type(linter.cmd) == "function" and linter.cmd() or linter.cmd
              if vim.fn.executable(cmd) == 1 then
                table.insert(linters_to_run, name)
              end
            end
          end
          
          if #linters_to_run > 0 then
            lint.try_lint(linters_to_run)
          end
        end,
      })
    end,
  },
}
