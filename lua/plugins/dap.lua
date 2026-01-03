-- ~/.config/nvim/lua/plugins/dap.lua

return {
  -- Debug Adapter Protocol client
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      -- Installs DAP adapters
      "williamboman/mason.nvim",
      -- UI for DAP
      {
        "rcarriga/nvim-dap-ui",
        config = function()
          local dapui = require("dapui")
          dapui.setup({
            layouts = {
              {
                elements = {
                  { id = "scopes", size = 0.25 },
                  { id = "breakpoints", size = 0.25 },
                  { id = "stacks", size = 0.25 },
                  { id = "watches", size = 0.25 },
                },
                size = 40,
                position = "left",
              },
              {
                elements = {
                  { id = "repl", size = 0.5 },
                  { id = "console", size = 0.5 },
                },
                size = 0.25,
                position = "bottom",
              },
            },
          })
        end,
      },
      -- Virtual text for DAP
      {
        "theHamsta/nvim-dap-virtual-text",
        config = function()
          require("nvim-dap-virtual-text").setup()
        end,
      },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- C++ adapter
      dap.adapters.cppdbg = {
        id = "cppdbg",
        type = "executable",
        command = require("mason-registry").get_package("cpptools"):get_install_path() .. "/extension/debugAdapters/bin/OpenDebugAD7",
      }

      -- C++ launch configuration
      dap.configurations.cpp = {
        {
          name = "Launch file",
          type = "cppdbg",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopAtEntry = true,
        },
      }

      -- Keymaps
      vim.keymap.set("n", "<F5>", function() dap.continue() end)
      vim.keymap.set("n", "<F10>", function() dap.step_over() end)
      vim.keymap.set("n", "<F11>", function() dap.step_into() end)
      vim.keymap.set("n", "<F12>", function() dap.step_out() end)
      vim.keymap.set("n", "<leader>b", function() dap.toggle_breakpoint() end)
      vim.keymap.set("n", "<leader>B", function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end)
      vim.keymap.set("n", "<leader>dr", function() dapui.toggle() end)
    end,
  },
}
