-- line numbers

vim.o.number = true
vim.o.relativenumber = true

-- show hidden characters
vim.opt.list = true
vim.opt.listchars = { tab = "→ ", trail = "•" }

-- indentation
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true

-- line wrapping
vim.opt.wrap = false

-- undo history
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.local/state/nvim/undodir"
vim.opt.undofile = true
vim.opt.updatetime = 50

-- my brain is backwards
vim.opt.splitright = true
vim.opt.splitbelow = true

-- end search when exiting
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- spellchecking
vim.opt.spelllang = { "en_us", "fr" }
vim.opt.spell = true
vim.opt.spellfile = vim.fn.stdpath("config") .. "/spell/add.utf-8.add"

-- exrc
vim.opt.exrc = true

-- stuff
vim.opt.mousemodel = "extend"

vim.opt.fillchars:append({ eob = " " })

vim.opt.termguicolors = true

vim.opt.scrolloff = 8

vim.opt.colorcolumn = "80"
