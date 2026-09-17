return {
  -- CodeCompanion: On-demand AI Chat, Inline Code Assistant, and Workflows
  -- Cleanly integrates with Local (Ollama, llama.cpp) and Online (Claude, GPT, Gemini, OpenRouter)
  {
    "olimorris/codecompanion.nvim",
    version = "9.12.4", -- Pin to version compatible with Neovim 0.10.0
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "hrsh7th/nvim-cmp",
      "nvim-telescope/telescope.nvim",
    },
    cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionCmd", "CodeCompanionActions" },
    keys = {
      { "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "AI: Toggle Chat Sidepanel" },
      { "<leader>ac", "<cmd>CodeCompanion<cr>",             mode = { "n", "v" }, desc = "AI: Inline Code Assistant" },
      { "<leader>ae", "<cmd>CodeCompanion /explain<cr>",    mode = "v",          desc = "AI: Explain Code" },
      { "<leader>ap", "<cmd>CodeCompanionActions<cr>",     mode = { "n", "v" }, desc = "AI: Prompt Actions Picker" },
      { "ga",         "<cmd>CodeCompanionChat Add<cr>",    mode = "v",          desc = "AI: Add selection to Chat" },
    },
    config = function()
      -- Helper to detect which adapter to default to based on available API keys / local servers
      local default_adapter = "ollama"
      if os.getenv("ANTHROPIC_API_KEY") then
        default_adapter = "anthropic"
      elseif os.getenv("OPENAI_API_KEY") then
        default_adapter = "openai"
      elseif os.getenv("GEMINI_API_KEY") then
        default_adapter = "gemini"
      end

      require("codecompanion").setup({
        display = {
          chat = {
            window = {
              layout = "vertical",
              width = 42,
              border = "rounded",
            },
          },
          action_palette = {
            width = 95,
            height = 16,
            prompt = "Prompt Actions  ",
            provider = "telescope",
          },
        },
        strategies = {
          chat = {
            adapter = default_adapter,
            roles = {
              llm = "CodeCompanion",
              user = "You",
            },
          },
          inline = {
            adapter = default_adapter,
          },
          agent = {
            adapter = default_adapter,
            tools = {
              "cmd_runner",
              "editor",
              "rag",
              opts = {
                auto_submit_errors = false,
                auto_submit_success = true,
              },
            },
          },
        },
        adapters = {
          -- 1. Local: Ollama (Recommended local provider)
          ollama = function()
            return require("codecompanion.adapters").extend("ollama", {
              env = {
                url = os.getenv("OLLAMA_HOST") or "http://127.0.0.1:11434",
              },
              schema = {
                model = {
                  default = "qwen2.5-coder:latest",
                },
                num_ctx = {
                  default = 32768,
                },
              },
            })
          end,

          -- 2. Local: llama.cpp server
          llamacpp = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              env = {
                url = os.getenv("LLAMACPP_URL") or "http://127.0.0.1:8000",
                chat_url = "/v1/chat/completions",
              },
              schema = {
                model = {
                  default = "ternary-bonsai",
                },
                num_ctx = {
                  default = 65536,
                },
                temperature = {
                  default = 0.6,
                },
              },
            })
          end,

          -- 3. Online: Anthropic Claude (Claude 3.5 Sonnet)
          anthropic = function()
            return require("codecompanion.adapters").extend("anthropic", {
              env = {
                api_key = os.getenv("ANTHROPIC_API_KEY"),
              },
              schema = {
                model = {
                  default = "claude-3-5-sonnet-latest",
                },
              },
            })
          end,

          -- 4. Online: OpenAI (GPT-4o)
          openai = function()
            return require("codecompanion.adapters").extend("openai", {
              env = {
                api_key = os.getenv("OPENAI_API_KEY"),
              },
              schema = {
                model = {
                  default = "gpt-4o",
                },
              },
            })
          end,

          -- 5. Online: Google Gemini
          gemini = function()
            return require("codecompanion.adapters").extend("gemini", {
              env = {
                api_key = os.getenv("GEMINI_API_KEY"),
              },
              schema = {
                model = {
                  default = "gemini-1.5-pro-latest",
                },
              },
            })
          end,

          -- 6. Online: OpenRouter (Unified API for any cloud model)
          openrouter = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              env = {
                url = "https://openrouter.ai/api",
                chat_url = "/v1/chat/completions",
                api_key = os.getenv("OPENROUTER_API_KEY"),
              },
              schema = {
                model = {
                  default = "anthropic/claude-3.5-sonnet",
                },
              },
            })
          end,
        },
      })
    end,
  },
}
