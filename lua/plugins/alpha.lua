-- ~/.config/nvim/lua/plugins/alpha.lua

return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  config = function()
    local dashboard = require("alpha.themes.dashboard")

    -- Modern stylized Neovim art banner
    dashboard.section.header.val = {
      [[                               __                ]],
      [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
      [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
      [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
      [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
      [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
      [[                                                 ]],
      [[           ⚡ R I C E D   E D I T I O N ⚡          ]],
    }
    dashboard.section.header.opts.hl = "Keyword"

    dashboard.section.buttons.val = {
      dashboard.button("f", "  Find File", "<cmd>Telescope find_files<cr>"),
      dashboard.button("r", "󰈚  Recent Files", "<cmd>Telescope oldfiles<cr>"),
      dashboard.button("g", "  Live Grep", "<cmd>Telescope live_grep<cr>"),
      dashboard.button("e", "  File Explorer", "<cmd>NvimTreeToggle<cr>"),
      dashboard.button("o", "󰏇  Oil File Manager", "<cmd>Oil --float<cr>"),
      dashboard.button("a", "󱁤  AI Assistant", "<cmd>CodeCompanionChat Toggle<cr>"),
      dashboard.button("s", "󰦛  Restore Session", "<cmd>lua require('persistence').load()<cr>"),
      dashboard.button("l", "󰒲  Lazy Plugins", "<cmd>Lazy<cr>"),
      dashboard.button("q", "  Quit Neovim", "<cmd>qa<cr>"),
    }

    for _, button in ipairs(dashboard.section.buttons.val) do
      button.opts.hl = "Normal"
      button.opts.hl_shortcut = "Number"
      button.opts.width = 44
      button.opts.cursor = 4
    end

    -- Dynamic footer with plugin count and stats
    local function get_footer()
      local stats = require("lazy").stats()
      local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
      return "󰂖 " .. stats.loaded .. "/" .. stats.count .. " plugins loaded in " .. ms .. "ms"
    end

    dashboard.section.footer.val = get_footer()
    dashboard.section.footer.opts.hl = "Comment"

    dashboard.opts.layout[1].val = 6 -- top padding

    require("alpha").setup(dashboard.config)
  end,
}
