return {
  {
    -- Plugin: neogit
    -- URL: https://github.com/NeogitOrg/neogit
    -- Description: An interactive and powerful Git interface for Neovim, inspired by Magit.
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "folke/snacks.nvim",
    },
    cmd = "Neogit",
    opts = {
      graph_style  = "unicode",
      disable_hint = false,
      integrations = { snacks = true, diffview = false },
    },
    keys = {
      { "<leader>gg", "<cmd>Neogit<cr>",                                 desc = "Neogit" },
      { "<leader>gc", "<cmd>Neogit commit<cr>",                          desc = "Neogit Commit" },
      { "<leader>gp", function() require("neogit").open({ "pull" }) end, desc = "Neogit Pull" },
      { "<leader>gP", function() require("neogit").open({ "push" }) end, desc = "Neogit Push" },
    },
  },
}
