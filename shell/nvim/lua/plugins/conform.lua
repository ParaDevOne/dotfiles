return {
  {
    -- Plugin: conform.nvim
    -- URL: https://github.com/stevearc/conform.nvim
    -- Description: Lightweight yet powerful formatter plugin for Neovim.
    "stevearc/conform.nvim",
    dependencies = { "mason-org/mason.nvim" },
    event = { "BufWritePre" },
    cmd = "ConformInfo",
    keys = {
      {
        "<leader>cf",
        function() require("conform").format({ async = true }) end,
        mode = { "n", "v" },
        desc = "Format buffer",
      },
      {
        "<leader>cF",
        function() require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 }) end,
        mode = { "n", "v" },
        desc = "Format injected langs",
      },
    },
    opts = {
      default_format_opts = {
        timeout_ms    = 3000,
        async         = false,
        quiet         = false,
        lsp_format    = "fallback",
        undojoin   = true,
      },
      format_on_save = {
        timeout_ms = 3000,
        lsp_format = "fallback",
      },
      formatters_by_ft = {
        lua  = { "stylua" },
        fish = { "fish_indent" },
        sh   = { "shfmt" },
      },
      formatters = {
        injected = { options = { ignore_errors = true } },
      },
    },
  },
}
