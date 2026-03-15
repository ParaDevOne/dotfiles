return {
  {
    -- Plugin: tokyonight.nvim
    -- URL: https://github.com/folke/tokyonight.nvim
    -- Description: A clean, dark Neovim theme with multiple style variants.
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "storm", -- night | storm | moon | day
      })
      vim.cmd("colorscheme tokyonight")
    end,
  },
}
