-- ~/.config/nvim/lua/plugins/formatting.lua

return {
  -- Formatter
  {
    'stevearc/conform.nvim',
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    config = function()
      require("conform").setup({
        -- Just an example for web development, you can add more
        -- IMPORTANT: You must install these formatters in Termux yourself!
        -- Example: pkg install stylua
        --          npm install -g prettier
        formatters_by_ft = {
          lua = { "stylua" },
          javascript = { "prettier" },
          typescript = { "prettier" },
          html = { "prettier" },
          css = { "prettier" },
          json = { "prettier" },
          python = { "isort", "black" },
          -- You can add other filetypes here
        },
        -- This is the key part that enables format on save
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true, -- Fallback to LSP formatting if conform fails
        },
      })
    end,
  },
}
