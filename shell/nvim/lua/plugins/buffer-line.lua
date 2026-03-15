return {
  {
    -- Plugin: bufferline.nvim
    -- URL: https://github.com/akinsho/bufferline.nvim
    -- Description: A snazzy bufferline for Neovim.
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = { "echasnovski/mini.icons" },
    keys = {
      { "<Tab>",      "<cmd>BufferLineCycleNext<cr>",   desc = "Next buffer" },
      { "<S-Tab>",    "<cmd>BufferLineCyclePrev<cr>",   desc = "Prev buffer" },
      { "<leader>bd", "<cmd>bdelete<cr>",               desc = "Delete buffer" },
      { "<leader>bp", "<cmd>BufferLineTogglePin<cr>",   desc = "Pin buffer" },
      { "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", desc = "Close other buffers" },
    },
    opts = {
      options = {
        diagnostics            = "nvim_lsp",
        always_show_bufferline = false,
        separator_style        = "thin", -- slope | thick | thin | slant
        offsets = {
          {
            filetype  = "oil",
            text      = "Explorer",
            highlight = "Directory",
            text_align = "left",
          },
        },
      },
    },
  },
}
