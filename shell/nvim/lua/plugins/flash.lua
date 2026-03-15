return {
  {
    -- Plugin: flash.nvim
    -- URL: https://github.com/folke/flash.nvim
    -- Description: Navigate your code with search labels, enhanced character motions and Treesitter integration.
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      modes = {
        search = { enabled = true },
        char   = { jump_labels = true },
      },
    },
    keys = {
      { "s",         function() require("flash").jump() end,                                                              mode = { "n", "x", "o" }, desc = "Flash" },
      { "S",         function() require("flash").treesitter() end,                                                        mode = { "n", "x", "o" }, desc = "Flash Treesitter" },
      { "r",         function() require("flash").remote() end,                                                            mode = "o",               desc = "Remote Flash" },
      { "R",         function() require("flash").treesitter_search() end,                                                 mode = { "o", "x" },      desc = "Treesitter Search" },
      { "<c-s>",     function() require("flash").toggle() end,                                                            mode = "c",               desc = "Toggle Flash Search" },
      { "<c-space>", function() require("flash").treesitter({ actions = { ["<c-space>"] = "next", ["<BS>"] = "prev" } }) end, mode = { "n", "o", "x" }, desc = "Treesitter Incremental Selection" },
    },
  },
}
