return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "hrsh7th/nvim-cmp", -- Integrates with your existing autocomplete
    "nvim-telescope/telescope.nvim", -- Integrates with your fuzzy finder
  },
  cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionCmd", "CodeCompanionActions" },
  keys = {
    { "<leader>a", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "AI Agent Actions" },
    { "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "Toggle AI Chat" },
    { "ga", "<cmd>CodeCompanionChat Add<cr>", mode = "v", desc = "Add code to AI Chat" },
  },
  config = function()
    require("codecompanion").setup({
      display = {
        action_palette = {
          width = 95,
          height = 10,
        },
      },
      strategies = {
        chat = {
          adapter = "llamacpp",
        },
        inline = {
          adapter = "llamacpp",
        },
        agent = {
          adapter = "llamacpp",
        },
      },
      adapters = {
        llamacpp = function()
          return require("codecompanion.adapters").extend("llamacpp", {
            env = {
              url = "http://127.0.0.1:8080", -- Default llama.cpp server port
            },
            schema = {
              model = {
                default = "Qwen3.5-9B", -- Placeholder name as llama.cpp server usually serves one model at a time
              },
              num_ctx = {
                default = 8192, -- 8k is safe for your current VRAM/RAM
              },
              seed = {
                default = -1,
              },
              temperature = {
                default = 0, -- Set to 0 for deterministic, consistent responses
              },
            },
          })
        end,
      },
    })
  end,
}
