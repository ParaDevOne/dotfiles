return {
  {
    -- Plugin: mason.nvim
    -- URL: https://github.com/mason-org/mason.nvim
    -- Description: Portable package manager for Neovim (LSP servers, linters, formatters).
    "mason-org/mason.nvim",
    opts = {},
  },

  {
    -- Plugin: mason-lspconfig.nvim
    -- URL: https://github.com/mason-org/mason-lspconfig.nvim
    -- Description: Bridges mason.nvim and nvim-lspconfig for automatic server setup.
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      ensure_installed = { "lua_ls" },
      -- auto-habilita todos los servers instalados via vim.lsp.enable()
      handlers = {
        function(server_name)
          vim.lsp.enable(server_name)
        end,
      },
    },
  },

  {
    -- Plugin: nvim-lspconfig
    -- URL: https://github.com/neovim/nvim-lspconfig
    -- Description: Configs predefinidos para servidores LSP con la API nativa de Neovim.

    "neovim/nvim-lspconfig",
    config = function()
      vim.diagnostic.config({
        underline        = true,
        update_in_insert = false,
        virtual_text     = { spacing = 4, prefix = "●" },
        severity_sort    = true,
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          local buf = args.buf

          -- navic breadcrumbs
          if client and client.server_capabilities.documentSymbolProvider then
            require("nvim-navic").attach(client, buf)
          end

          -- keymaps
          local map = function(lhs, rhs, desc)
            vim.keymap.set("n", lhs, rhs, { buffer = buf, desc = desc })
          end

          map("gd",         function() Snacks.picker.lsp_definitions() end,      "Goto Definition")
          map("gr",         function() Snacks.picker.lsp_references() end,       "References")
          map("gi",         function() Snacks.picker.lsp_implementations() end,  "Goto Implementation")
          map("gt",         function() Snacks.picker.lsp_type_definitions() end, "Goto Type Definition")
          map("gD",         vim.lsp.buf.declaration,                             "Goto Declaration")
          map("K",          vim.lsp.buf.hover,                                   "Hover")
          map("gK",         vim.lsp.buf.signature_help,                          "Signature Help")
          map("<leader>ca", vim.lsp.buf.code_action,                             "Code Action")
          map("<leader>cr", vim.lsp.buf.rename,                                  "Rename")
          map("<leader>cl", function() Snacks.picker.lsp_config() end,           "LSP Info")
          map("<leader>ss", function() Snacks.picker.lsp_symbols() end,          "LSP Symbols")
        end,
      })

      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            workspace  = { checkThirdParty = false },
            telemetry  = { enable = false },
            completion = { callSnippet = "Replace" },
          },
        },
      })
    end,
  },
}

