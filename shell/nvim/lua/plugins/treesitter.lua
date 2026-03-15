return {
  -- Plugin: nvim-treesitter
  -- URL: https://github.com/nvim-treesitter/nvim-treesitter
  -- Description: Treesitter configurations and abstraction layer for Neovim.
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
    opts = {
      highlight = { enable = true },
      indent    = { enable = true },
      ensure_installed = {
        "bash", "c", "diff", "html",
        "javascript", "json", "lua",
        "markdown", "markdown_inline",
        "python", "regex", "toml",
        "tsx", "typescript",
        "vim", "vimdoc", "xml", "yaml",
      },
    },
    config = function(_, opts)
      require("nvim-treesitter").setup(opts)
    end,
  },
  -- Plugin: nvim-treesitter-textobjects
  -- URL: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  -- Description: Syntax-aware text objects, select, move, swap and peek support.
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      move = {
        enable    = true,
        set_jumps = true,
        goto_next_start = {
          ["]f"] = "@function.outer",
          ["]c"] = "@class.outer",
          ["]a"] = "@parameter.inner",
        },
        goto_next_end = {
          ["]F"] = "@function.outer",
          ["]C"] = "@class.outer",
          ["]A"] = "@parameter.inner",
        },
        goto_previous_start = {
          ["[f"] = "@function.outer",
          ["[c"] = "@class.outer",
          ["[a"] = "@parameter.inner",
        },
        goto_previous_end = {
          ["[F"] = "@function.outer",
          ["[C"] = "@class.outer",
          ["[A"] = "@parameter.inner",
        },
      },
    },
    config = function(_, opts)
      require("nvim-treesitter-textobjects").setup(opts)
    end,
  },
  -- Plugin: nvim-ts-autotag
  -- URL: https://github.com/windwp/nvim-ts-autotag
  -- Description: Auto close and rename HTML/JSX tags using Treesitter.
  {
    "windwp/nvim-ts-autotag",
    event        = "VeryLazy",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {},
  },
}

