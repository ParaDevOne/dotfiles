return {
  {
    -- Plugin: lazydev.nvim
    -- URL: https://github.com/folke/lazydev.nvim
    -- Description: Faster LuaLS setup for Neovim config with type hints and docs.
    "folke/lazydev.nvim",
    ft  = "lua",
    cmd = "LazyDev",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "lazy.nvim",          words = { "lazy" } },
      },
    },
  },
}
