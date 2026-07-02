return {
  -- 1. CodeCompanion (Sidepanel Chat & Inline Actions)
  -- Supports any Cloud API (OpenAI, Anthropic, Gemini) or Local (Llama.cpp / Ollama)
  {
    "olimorris/codecompanion.nvim",
    version = "9.12.4", -- Pin to last version that supports Neovim 0.10.0
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "hrsh7th/nvim-cmp",
      "nvim-telescope/telescope.nvim",
    },
    cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionCmd", "CodeCompanionActions" },
    keys = {
      { "<leader>ae", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "AI Actions (Explain, etc)" },
      { "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "Toggle AI Chat Sidepanel" },
      { "ga", "<cmd>CodeCompanionChat Add<cr>", mode = "v", desc = "Add code to AI Chat" },
    },
    config = function()
      require("codecompanion").setup({
        display = {
          chat = {
            window = {
              layout = "vertical", -- Renders on the side, like GitHub Copilot
              width = 40,
            },
          },
        },
        -- Set to "llamacpp" to use local, or change to "openai", "anthropic", or "gemini" for cloud APIs
        strategies = {
          chat = { adapter = "llamacpp" },
          inline = { adapter = "llamacpp" },
          agent = { adapter = "llamacpp" },
        },
        adapters = {
          -- Local llamacpp server configuration
          llamacpp = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              env = {
                url = "http://127.0.0.1:8080",
                chat_url = "/v1/chat/completions",
              },
              handlers = {
                form_messages = function(self, messages)
                  local system_content = {}
                  local new_messages = {}
                  for _, msg in ipairs(messages) do
                    if msg.role == "system" then
                      table.insert(system_content, msg.content)
                    else
                      table.insert(new_messages, msg)
                    end
                  end
                  if #system_content > 0 then
                    local combined_system_prompt = table.concat(system_content, "\n\n")
                    -- IMPORTANT FIX for local models: Force them to wrap tools in ```xml
                    combined_system_prompt = combined_system_prompt .. "\n\nCRITICAL: If you use the <tools> XML block to call a tool, you MUST wrap it inside a markdown ```xml codeblock (e.g., ```xml\n<tools>...</tools>\n```). Never output <tools> without the surrounding ```xml backticks!"
                    
                    table.insert(new_messages, 1, {
                      role = "system",
                      content = combined_system_prompt
                    })
                  end
                  return { messages = new_messages }
                end,
              },
              schema = {
                model = {
                  default = "ornith-1.0-9b-uncensored-Q4_K_M.gguf",
                },
                num_ctx = {
                  default = 262144,
                },
                temperature = {
                  default = 0.6,
                },
              },
            })
          end,
          -- Cloud API Example (OpenAI):
          -- To use this, change `adapter = "openai"` in the strategies above, and set the OPENAI_API_KEY env var
          openai = function()
            return require("codecompanion.adapters").extend("openai", {
              env = {
                api_key = os.getenv("OPENAI_API_KEY"),
              },
            })
          end,
          -- Cloud API Example (Anthropic):
          anthropic = function()
            return require("codecompanion.adapters").extend("anthropic", {
              env = {
                api_key = os.getenv("ANTHROPIC_API_KEY"),
              },
            })
          end,
        },
      })
    end,
  },

  -- 2. LLM.nvim (Ghost Text Autocompletion as you type)
  -- Uses your custom model to predict what you're typing next, just like Copilot
  {
    "huggingface/llm.nvim",
    event = "InsertEnter",
    config = function()
      local llm = require("llm")
      
      llm.setup({
        -- Set to "openai" for local llama.cpp compatibility
        backend = "openai", 
        url = "http://127.0.0.1:8080/v1/completions", -- Route to OpenAI-compatible endpoint
        model = "ornith-1.0-9b-uncensored-Q4_K_M.gguf", 
        request_body = {
          -- Additional request params if your model needs them for FIM (Fill-In-Middle)
          temperature = 0.6,
          top_p = 0.95,
        },
        -- The FIM tokens depend on your model. You may need to tweak these if Qwen FIM fails.
        fim = {
          enabled = true,
          prefix = "<|fim_prefix|>",
          middle = "<|fim_middle|>",
          suffix = "<|fim_suffix|>",
        },
        debounce_ms = 150,
        accept_keymap = "<Right>",
        dismiss_keymap = "<S-Tab>",
        tls_skip_verify_insecure = false,
        lsp = {
          bin_path = nil,
          host = nil,
          port = nil,
          cmd_env = nil, -- or { LLM_LOG_LEVEL = "DEBUG" }
          version = "0.5.3",
        },
      })
      
      -- Easy toggle to disable/enable AI autocompletions (ghost text)
      vim.keymap.set("n", "<leader>ct", "<cmd>LLMToggleAutoSuggest<cr>", { desc = "Toggle AI Autocompletion" })
    end,
  },
}
