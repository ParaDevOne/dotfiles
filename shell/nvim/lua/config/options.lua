local opt = vim.opt

-- Indentation
opt.expandtab    = true
opt.shiftwidth   = 2
opt.tabstop      = 2
opt.softtabstop  = 2
opt.smartindent  = true
opt.fixendofline = true

-- Display
opt.number        = true
opt.relativenumber = false
opt.cursorline    = false
opt.cursorcolumn  = false
opt.signcolumn    = "yes"
opt.wrap          = false
opt.linebreak     = true
opt.breakindent   = true
opt.list          = true
opt.listchars     = "tab:» ,trail:·,nbsp:␣"

-- Search
opt.ignorecase = true
opt.smartcase  = true
opt.hlsearch   = true
opt.incsearch  = true

-- Behavior
opt.mouse        = "a"
opt.clipboard    = "unnamedplus"
opt.undofile     = true
opt.undolevels   = 10000
opt.completeopt  = "menu,menuone,noselect"
opt.pumheight    = 10
opt.timeoutlen   = 300
opt.updatetime   = 200

-- Splits
opt.splitbelow = true
opt.splitright = true

-- Misc
opt.encoding      = "utf-8"
opt.swapfile      = false
opt.backup        = false
opt.writebackup   = false
opt.termguicolors = true
opt.background    = "dark"
opt.scrolloff     = 8
opt.sidescrolloff = 8
opt.inccommand    = "split"
