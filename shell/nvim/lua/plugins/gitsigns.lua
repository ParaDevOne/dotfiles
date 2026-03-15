return {
  {
    -- Plugin: gitsigns.nvim
    -- URL: https://github.com/lewis6991/gitsigns.nvim
    -- Description: Git decorations for buffers: signs, blame, diff, hunk navigation.
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    opts = {
      signs                        = {
        add          = { text = "▎" },
        change       = { text = "▎" },
        delete       = { text = "" },
        topdelete    = { text = "" },
        changedelete = { text = "▎" },
        untracked    = { text = "▎" },
      },
      signs_staged                 = {
        add          = { text = "▎" },
        change       = { text = "▎" },
        delete       = { text = "" },
        topdelete    = { text = "" },
        changedelete = { text = "▎" },
        untracked    = { text = "▎" },
      },
      signs_staged_enable          = true,
      attach_to_untracked          = true,
      current_line_blame           = false,
      current_line_blame_opts      = {
        virt_text     = true,
        virt_text_pos = "eol",
        delay         = 100,
      },
      current_line_blame_formatter = "<author>, <author_time:%R> · <summary>",
      word_diff                    = false,
      watch_gitdir                 = { follow_files = true },
    },
    keys = {
      {
        "]h",
        function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            require("gitsigns").nav_hunk("next")
          end
        end,
        desc = "Next Hunk",
      },
      {
        "[h",
        function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            require("gitsigns").nav_hunk("prev")
          end
        end,
        desc = "Prev Hunk",
      },
      { "]H",          function() require("gitsigns").nav_hunk("last") end,            desc = "Last Hunk" },
      { "[H",          function() require("gitsigns").nav_hunk("first") end,           desc = "First Hunk" },
      { "<leader>ghs", ":Gitsigns stage_hunk<CR>",                                     desc = "Stage Hunk",         mode = { "n", "x" } },
      { "<leader>ghr", ":Gitsigns reset_hunk<CR>",                                     desc = "Reset Hunk",         mode = { "n", "x" } },
      { "<leader>ghS", function() require("gitsigns").stage_buffer() end,              desc = "Stage Buffer" },
      { "<leader>ghu", function() require("gitsigns").undo_stage_hunk() end,           desc = "Undo Stage Hunk" },
      { "<leader>ghR", function() require("gitsigns").reset_buffer() end,              desc = "Reset Buffer" },
      { "<leader>ghp", function() require("gitsigns").preview_hunk_inline() end,       desc = "Preview Hunk Inline" },
      { "<leader>ghb", function() require("gitsigns").blame_line({ full = true }) end, desc = "Blame Line" },
      { "<leader>ghB", function() require("gitsigns").blame() end,                     desc = "Blame Buffer" },
      { "<leader>ghd", function() require("gitsigns").diffthis() end,                  desc = "Diff This" },
      { "<leader>ghD", function() require("gitsigns").diffthis("~") end,               desc = "Diff This ~" },
      { "<leader>ghT", function() require("gitsigns").toggle_current_line_blame() end, desc = "Toggle Line Blame" },
      { "<leader>ghW", function() require("gitsigns").toggle_word_diff() end,          desc = "Toggle Word Diff" },
      { "ih",          ":<C-U>Gitsigns select_hunk<CR>",                               desc = "Select Hunk",        mode = { "o", "x" } },
    },
  },
}
