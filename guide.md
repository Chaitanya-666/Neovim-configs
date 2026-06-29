# Neovim Configuration Guide

Welcome to your completely configured, crisp Neovim setup! This manual explains how the configuration is structured and how to use its main features.

## 📂 File Structure
- `init.lua`: The entry point that loads core settings and the `lazy.nvim` plugin manager.
- `lua/core/`: Contains fundamental Neovim configuration (`options.lua`, `keymaps.lua`, `autocmds.lua`).
- `lua/plugins/`: Contains configurations for all installed plugins.

## 🎨 Theme & Aesthetics
- **Catppuccin Macchiato**: A crisp, dark, and vibrant theme.
- **Line Numbers**: Active line numbers (`CursorLineNr`) are highlighted in **white**, while inactive line numbers (`LineNr`) are a subtle **gray**.
- **Transparent Background**: Enabled by default for a modern look if your terminal supports it.

## 🧠 LSP & Autocompletion
Powered by `mason.nvim`, `nvim-lspconfig`, and `nvim-cmp`.
- **C++ (clangd)** and **JavaScript/TypeScript (ts_ls)** are fully configured with identical capabilities.
- Hit `<C-Space>` in Insert mode to trigger autocompletion manually.
- Use `<Tab>` and `<S-Tab>` to navigate the completion menu.
- `K` for hover documentation, `gd` for go-to-definition, `<leader>rn` to rename variables.

## 🤖 AI Agent
A plug-n-play AI agent setup featuring a sidepanel chat and inline autocompletion.
- `<Space>ct`: Toggle inline AI autocompletions on or off.
- `<Space>aa`: Toggle the AI Chat sidepanel.
- `<Space>ae`: Ask the AI to explain the selected code.

## 🔭 Telescope (Fuzzy Finder)
- `<Space>ff`: Find Files in the project.
- `<Space>fs`: Find text using Grep (Live Grep).
- `<Space>fb`: Find open Buffers.
- `<Space>/`: Fuzzily search within the current buffer.

## 🐞 Debugging
- `<F5>`: Start/Continue debugging.
- `<F10>` / `<F11>` / `<F12>`: Step Over / Step Into / Step Out.
- `<Space>b`: Toggle a breakpoint.
- `<Space>dr`: Toggle the Debugger UI.

## 💡 Pro Tips
- Type `:help <command>` for native documentation.
- Use the `/learn` slash command in Antigravity to persist any memory or context about your custom configurations for future sessions!
