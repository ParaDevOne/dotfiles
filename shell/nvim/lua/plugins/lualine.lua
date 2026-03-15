return {
  {
    -- Plugin: lualine.nvim
    -- URL: https://github.com/nvim-lualine/lualine.nvim
    -- Description: A blazing fast and easy to configure Neovim statusline.
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "SmiteshP/nvim-navic" },
    opts = {
      options = {
        theme = "auto",
        globalstatus = true,
        section_separators    = { left = "", right = "" },
        component_separators  = { left = "│", right = "│" },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = {
          { "filename", path = 1 },
          {
            function() return require("nvim-navic").get_location() end,
            cond = function() return require("nvim-navic").is_available() end,
          },
        },
        lualine_x = {
          {
            function()
              local clients = vim.lsp.get_clients({ bufnr = 0 })
              if #clients == 0 then return "󰅚 No LSP" end
              local names = {}
              for _, c in ipairs(clients) do
                table.insert(names, c.name)
              end
              return "󰒍 " .. table.concat(names, ", ")
            end,
          },
          {
            function()
              local indent = vim.bo.expandtab
                and ("spaces: " .. vim.bo.shiftwidth)
                or  ("tabs: "   .. vim.bo.tabstop)
              return "󰌒 " .. indent
            end,
          },
          {
            function()
              local size = vim.fn.getfsize(vim.fn.expand("%:p"))
              if size <= 0 then return "" end
              local units = { "B", "KB", "MB" }
              local i = 1
              while size >= 1024 and i < #units do
                size = size / 1024
                i = i + 1
              end
              return string.format("󰋊 %.1f%s", size, units[i])
            end,
          },
          "encoding",
          "filetype",
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    },
  },

  {
    -- Plugin: nvim-navic
    -- URL: https://github.com/SmiteshP/nvim-navic
    -- Description: Shows current code context in statusline via LSP (breadcrumbs).
    "SmiteshP/nvim-navic",
    lazy = true,
    opts = {
      separator   = " › ",
      highlight   = true,
      depth_limit = 5,
    },
    init = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.server_capabilities.documentSymbolProvider then
            require("nvim-navic").attach(client, args.buf)
          end
        end,
      })
    end,
  },
}

