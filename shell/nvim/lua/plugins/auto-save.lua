return {
  {
    -- Plugin: auto-save.nvim
    -- URL: https://github.com/okuuva/auto-save.nvim
    -- Description: Automatically saves your changes in Neovim.
    "okuuva/auto-save.nvim",
    version = "^1.0.0",
    cmd   = "ASToggle",
    event = { "InsertLeave", "TextChanged" },
    keys = {
      { "<leader>us", "<cmd>ASToggle<cr>", desc = "Toggle auto-save" },
    },
    opts = {
      debounce_delay = 1000,
      condition = function(buf)
        local excluded_filetypes = {
          "gitcommit", "oil", "prompt", "dashboard",
        }
        if vim.tbl_contains(excluded_filetypes, vim.fn.getbufvar(buf, "&filetype")) then
          return false
        end
        return true
      end,
    },
  },
}
