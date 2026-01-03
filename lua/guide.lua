-- ~/.config/nvim/lua/guide.lua

local M = {}

function M.show_guide()
  local lines = {
    "~ My Neovim Keymap Guide ~",
    "",
    " General",
    "  <Space>       - Leader Key",
    "  :q            - Quit",
    "  :w            - Write (Save)",
    "  :wq           - Write & Quit",
    "",
    " File Explorer (NvimTree)",
    "  <Space>e      - Toggle File Explorer",
    "  c             - Change Directory to selected folder",
    "  a             - Add file/folder",
    "  r             - Rename",
    "  d             - Delete",
    "",
    " Super Search (Telescope)",
    "  <Space>ff     - Find Files",
    "  <Space>fs     - Find Text in Project (Grep)",
    "  <Space>fb     - Find Buffers (Open Files)",
    "  <Space>fh     - Find Help Tags",
    "",
    " Debugging (DAP)",
    "  <F5>          - Start/Continue Debugging",
    "  <F10>         - Step Over",
    "  <F11>         - Step Into",
    "  <F12>         - Step Out",
    "  <Space>b      - Toggle Breakpoint",
    "  <Space>dr     - Toggle Debugger UI",
    "",
    " Editing",
    "  yy, dd, p     - Yank, Delete, Paste",
    "  v + motion    - Visually select, then 'd' or 'y'",
    "  u / <C-r>     - Undo / Redo",
  }

  -- Create a new buffer
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  -- Set buffer options
  vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
  vim.api.nvim_buf_set_option(buf, "filetype", "markdown")
  vim.api.nvim_buf_set_option(buf, "readonly", true)

  -- Calculate floating window dimensions
  local width = vim.api.nvim_get_option("columns")
  local height = vim.api.nvim_get_option("lines")
  local win_width = math.floor(width * 0.6)
  local win_height = #lines + 2
  local row = math.floor((height - win_height) / 2)
  local col = math.floor((width - win_width) / 2)

  -- Create a floating window
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = win_width,
    height = win_height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
  })
end

return M