local map = function(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.noremap = opts.noremap ~= false
  opts.silent  = opts.silent ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Lazy / Mason
map("n", "<leader>ll", "<cmd>Lazy<cr>",  { desc = "Lazy" })
map("n", "<leader>lm", "<cmd>Mason<cr>", { desc = "Mason" })

-- Diagnostics
map("n", "<leader>e", function() vim.diagnostic.open_float() end, { desc = "Show Diagnostics" })
