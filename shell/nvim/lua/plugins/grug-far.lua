return {
  {
    -- Plugin: grug-far.nvim
    -- URL: https://github.com/MagicDuck/grug-far.nvim
    -- Description: Find and replace plugin with ripgrep, feels like editing a buffer.
    "MagicDuck/grug-far.nvim",
    cmd  = { "GrugFar", "GrugFarWithin" },
    opts = {
      headerMaxWidth = 80,
    },
    keys = {
      {
        "<leader>sr",
        function()
          local grug = require("grug-far")
          local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
          grug.open({
            transient = true,
            prefills = {
              filesFilter = ext and ext ~= "" and "*." .. ext or nil,
            },
          })
        end,
        mode = { "n", "x" },
        desc = "Search and Replace",
      },
    },
  },
}
