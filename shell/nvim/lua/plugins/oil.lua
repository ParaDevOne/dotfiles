return {
  {
    -- Plugin: oil.nvim
    -- URL: https://github.com/stevearc/oil.nvim
    -- Description: File explorer that lets you edit the filesystem like a buffer.
    "stevearc/oil.nvim",
    lazy = false,
    keys = {
      { "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
    },
    opts = {
      default_file_explorer = true,
      view_options = {
        show_hidden = true,
      },
    },
    config = function(_, opts)
      require("oil").setup(opts)
      if vim.fn.isdirectory(vim.fn.argv(0)) == 1 then
        require("oil").open(vim.fn.argv(0))
      end
    end,
  },
}
