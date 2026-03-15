return {
  {
    -- Plugin: blink.cmp
    -- URL: https://github.com/saghen/blink.cmp
    -- Description: Performant, batteries-included completion plugin with LSP, snippets and cmdline.
    "saghen/blink.cmp",
    version      = "1.*",
    lazy         = false,
    dependencies = {
      "rafamadriz/friendly-snippets",
      {
        -- Plugin: LuaSnip
        -- URL: https://github.com/L3MON4D3/LuaSnip
        -- Description: Snippet engine for Neovim written in Lua.
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build   = "make install_jsregexp",
        opts = {
          history             = true,
          delete_check_events = "TextChanged",
        },
      },
    },
    opts = {
      keymap = {
        preset  = "enter",
        ["<Tab>"]   = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
        ["<C-b>"]   = { "scroll_documentation_up", "fallback" },
        ["<C-f>"]   = { "scroll_documentation_down", "fallback" },
        ["<C-e>"]   = { "hide", "fallback" },
      },

      appearance = {
        nerd_font_variant = "mono",
      },

      completion = {
        documentation = {
          auto_show       = true,
          auto_show_delay_ms = 200,
        },
        accept = {
          auto_brackets = { enabled = true },
        },
      },

      snippets = {
        preset = "luasnip",
      },

      sources = {
        default = { "lsp", "buffer", "snippets", "path" },
      },

      fuzzy = {
        implementation = "lua",
      },
    },
  },
}
