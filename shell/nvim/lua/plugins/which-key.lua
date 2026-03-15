return {
  -- Plugin: which-key.nvim
  -- URL: https://github.com/folke/which-key.nvim
  -- Description: Create key bindings that stick. WhichKey helps you remember your Neovim keymaps, by showing available keybindings in a popup as you type.
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {

    delay = 300,
    preset = "modern", -- "classic" | "modern" | "helix"

    win = {
      border = "rounded",   -- "none"|"single"|"double"|"rounded"
      padding = { 1, 2 },   -- { top/bot, left/right }
      wo = {
        winblend = 10,       -- transparencia 0-100
      },
    },

    layout = {
      width = { min = 20 },
      spacing = 3,
    },

    icons = {
      mappings = true,
      keys = {
        Space = "󱁐 ",
        CR    = "↵ ",
        Esc   = "⎋ ",
      },
    },

    filter = function(mapping)
      return mapping.desc and mapping.desc ~= ""
    end,
  },

  -- Keymaps de which-key
  keys = {
    {
      "<leader>?",
      function() require("which-key").show({ global = false }) end,
      desc = "Buffer keymaps",
    },
  },
}

