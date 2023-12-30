-- move selected lines and auto indent
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")

-- zz centers the cursor
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- switch between buffers
vim.keymap.set("n", "<C-j>", "<cmd>bprev<CR>")
vim.keymap.set("n", "<C-k>", "<cmd>bnext<CR>")

-- exit from terminal easily
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
vim.keymap.set("t", "<C-v><Esc>", "<Esc>") -- Verbatim escape (send an esc to underlying program)
