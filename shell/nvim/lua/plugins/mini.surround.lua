return {
  {
    -- Plugin: mini.surround
    -- URL: https://github.com/echasnovski/mini.surround
    -- Description: Fast and feature-rich surround actions (add, delete, replace, find, highlight).
    "echasnovski/mini.surround",
    event = "VeryLazy",
    opts = {
      mappings = {
        add            = "gsa",
        delete         = "gsd",
        find           = "gsf",
        find_left      = "gsF",
        highlight      = "gsh",
        replace        = "gsr",
        update_n_lines = "gsn",
      },
    },
  },
}
