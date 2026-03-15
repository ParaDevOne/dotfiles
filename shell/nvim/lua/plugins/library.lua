return {
  {
    -- Plugin: plenary.nvim
    -- URL: https://github.com/nvim-lua/plenary.nvim
    -- Description: Full Lua utility library for Neovim. Functions for async, files, paths, and more.
    "nvim-lua/plenary.nvim",
    lazy = true,
  },

  {
    -- Plugin: nui.nvim
    -- URL: https://github.com/MunifTanjim/nui.nvim
    -- Description: UI component library for Neovim.
    "MunifTanjim/nui.nvim",
    lazy = true,
  },

  {
    -- Plugin: mini.icons
    -- URL: https://github.com/echasnovski/mini.icons
    -- Description: Icon provider from mini.nvim. Mocks nvim-web-devicons for compatibility.
    "echasnovski/mini.icons",
    lazy = true,
    opts = {},
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },
}
