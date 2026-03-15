return {
  {
    -- Plugin: todo-comments.nvim
    -- URL: https://github.com/folke/todo-comments.nvim
    -- Description: Highlight, list and search todo comments like TODO, FIXME, HACK in your codebase.
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    keys = {
      { "]t",         function() require("todo-comments").jump_next() end,                                    desc = "Next Todo Comment" },
      { "[t",         function() require("todo-comments").jump_prev() end,                                    desc = "Prev Todo Comment" },
      { "<leader>xt", "<cmd>Trouble todo toggle<cr>",                                                         desc = "Todo (Trouble)" },
      { "<leader>xT", "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>",                      desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>st", function() Snacks.picker.todo_comments() end,                                           desc = "Todo" },
      { "<leader>sT", function() Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "Todo/Fix/Fixme" },
    },
  },
}
