-- ~/.config/nvim/lua/plugins/lualine.lua

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status")

    -- Helper to get active LSP client names attached to current buffer
    local function lsp_status()
      local clients = vim.lsp.get_clients({ bufnr = 0 })
      if #clients == 0 then
        return ""
      end
      local names = {}
      for _, client in ipairs(clients) do
        -- Filter out copilot/formatting if desired
        if client.name ~= "null-ls" then
          table.insert(names, client.name)
        end
      end
      return " " .. table.concat(names, ", ")
    end

    lualine.setup({
      options = {
        theme = "catppuccin",
        globalstatus = true,
        disabled_filetypes = { statusline = { "alpha", "dashboard" } },
        component_separators = "",
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = {
          {
            "mode",
            separator = { left = "", right = "" },
            padding = { left = 1, right = 1 },
            fmt = function(mode_name)
              local mode_icons = {
                ["NORMAL"] = " NORMAL",
                ["INSERT"] = " INSERT",
                ["VISUAL"] = " VISUAL",
                ["V-LINE"] = " V-LINE",
                ["V-BLOCK"] = " V-BLOCK",
                ["COMMAND"] = " COMMAND",
                ["TERMINAL"] = " TERMINAL",
              }
              return mode_icons[mode_name] or mode_name
            end,
          },
        },
        lualine_b = {
          {
            "branch",
            icon = "",
            padding = { left = 1, right = 1 },
          },
          {
            "diff",
            symbols = { added = " ", modified = " ", removed = " " },
            padding = { left = 1, right = 1 },
          },
        },
        lualine_c = {
          {
            "filename",
            file_status = true,
            path = 1, -- Relative path
            symbols = {
              modified = " ●",
              readonly = " ",
              unnamed = "[No Name]",
            },
          },
        },
        lualine_x = {
          {
            lsp_status,
            color = { fg = "#8aadf4", gui = "bold" },
          },
          {
            "diagnostics",
            sources = { "nvim_diagnostic" },
            symbols = { error = " ", warn = " ", info = " ", hint = " " },
          },
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = "#ff9e64" },
          },
        },
        lualine_y = {
          { "filetype", icon_only = false, padding = { left = 1, right = 1 } },
          { "progress", padding = { left = 1, right = 1 } },
        },
        lualine_z = {
          {
            "location",
            separator = { left = "", right = "" },
            padding = { left = 1, right = 1 },
          },
        },
      },
    })
  end,
}