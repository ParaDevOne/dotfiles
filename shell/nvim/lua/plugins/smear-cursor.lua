return {
  {
    -- Plugin: smear-cursor.nvim
    -- URL: https://github.com/sphamba/smear-cursor.nvim
    -- Description: Animate the cursor with a smear effect in all terminals.
    "sphamba/smear-cursor.nvim",
    event = "VeryLazy",
    opts = {
      smear_between_buffers        = true,
      smear_between_neighbor_lines = true,
      scroll_buffer_space          = true,
      stiffness                    = 0.8,
      trailing_stiffness           = 0.6,
      damping                      = 0.95,
      damping_insert_mode          = 0.95,
    },
    keys = {
      { "<leader>uS", function() require("smear_cursor").toggle() end, desc = "Toggle Smear Cursor" },
    },
  },
}
