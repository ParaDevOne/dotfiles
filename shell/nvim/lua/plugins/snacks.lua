-- Terminal navigation
local function term_nav(dir)
  return function(self)
    return self:is_floating() and "<c-" .. dir .. ">" or vim.schedule(function()
      vim.cmd.wincmd(dir)
    end)
  end
end

return {
  {
    -- Plugin: snacks.nvim
    -- URL: https://github.com/folke/snacks.nvim
    -- Description: A collection of QoL plugins for Neovim.
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      bigfile      = { enabled = true },
      quickfile    = { enabled = true },
      notifier     = { enabled = true, timeout = 3000 },
      indent       = { enabled = true },
      input        = { enabled = true },
      scope        = { enabled = true },
      words        = { enabled = true },
      scroll       = { enabled = true },
      statuscolumn = { enabled = true },
      picker       = { enabled = true },

      terminal = {
        win = {
          keys = {
            nav_h = { "<C-h>", term_nav("h"), desc = "Go to Left Window",  expr = true, mode = "t" },
            nav_j = { "<C-j>", term_nav("j"), desc = "Go to Lower Window", expr = true, mode = "t" },
            nav_k = { "<C-k>", term_nav("k"), desc = "Go to Upper Window", expr = true, mode = "t" },
            nav_l = { "<C-l>", term_nav("l"), desc = "Go to Right Window", expr = true, mode = "t" },
          },
        },
      },

      dashboard = {
        preset = {
          header = [[
        ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
        ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
        ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
        ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
        ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
        ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
          ]],
          keys = {
            { icon = " ", key = "f", desc = "Find File",    action = function() Snacks.picker.files() end },
            { icon = " ", key = "n", desc = "New File",     action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text",    action = function() Snacks.picker.grep() end },
            { icon = " ", key = "r", desc = "Recent Files", action = function() Snacks.picker.recent() end },
            { icon = " ", key = "c", desc = "Config",       action = function() Snacks.picker.files({ cwd = "~/dotfiles/dots/nvim" }) end },
            { icon = " ", key = "l", desc = "Lazy",         action = ":Lazy" },
            { icon = " ", key = "q", desc = "Quit",         action = ":qa" },
          },
        },
      },
    },

    keys = {
      { "<leader><space>", function() Snacks.picker.smart() end,           desc = "Smart Find Files" },
      { "<leader>,",       function() Snacks.picker.buffers() end,         desc = "Buffers" },
      { "<leader>/",       function() Snacks.picker.grep() end,            desc = "Grep" },
      { "<leader>:",       function() Snacks.picker.command_history() end, desc = "Command History" },
      { "<leader>n",       function() Snacks.picker.notifications() end,   desc = "Notifications" },
      { "<leader>ff",      function() Snacks.picker.files() end,           desc = "Find Files" },
      { "<leader>fr",      function() Snacks.picker.recent() end,          desc = "Recent Files" },
      { "<leader>fg",      function() Snacks.picker.git_files() end,       desc = "Git Files" },
    },
  },
}

