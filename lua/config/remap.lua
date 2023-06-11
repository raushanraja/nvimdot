vim.g.mapleader = " "

local opts = { noremap = true, silent = true }
local nonopts = { noremap = true, silent = false }
local keymap = vim.api.nvim_set_keymap

keymap("", "j", "h", opts)
keymap("", ";", "l", opts)
keymap("", "k", "k", opts)
keymap("", "l", "j", opts)

-- keymap("n", "<leader>pv", ":Ex<cr>", opts)
keymap("n", "<C-j>", "<C-w>h", opts)
keymap("n", "<C-;", "<C-w>l", opts)
keymap("n", "<C-l>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<leader>u", ":UndotreeToggle<cr>", opts)

keymap("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], opts)
keymap("i", "jk", "<esc>", opts)

-- Save FIle
keymap("n", "<leader>w", ":w<cr>", opts)

-- Move Selected line up/down
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)
keymap("v", "L", ":m '>+1<CR>gv=gv", opts)

-- Move next line to the line where cursor is present
keymap("n", "J", "mzJ`z", opts)

-- Scrolling UP - DOWN
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)

-- Keeping the search centered
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- Paste without replacing the current paste buffer
keymap("x", "<leader>p", [["_dP]], nonopts)

-- Copy to systemclipboard vs nvim clipboard only
keymap("v", "<leader>y", [["+y]], nonopts)
keymap("n", "<leader>y", [["+y]], nonopts)
keymap("n", "<leader>Y", [["+Y]], nonopts)

keymap("n", "<leader>ps", [["+p]], nonopts)
keymap("v", "<leader>ps", [["+p]], nonopts)

-- Set Captial Q no operation, Format using Space-j
keymap("n", "Q", "<nop>", nonopts)
keymap("n", "<leader>j", ":LspZeroFormat<cr>", nonopts)


-- NVIMTreeToggle
keymap("n", "<leader>e", ":NvimTreeToggle<cr>", opts)
-- Lazygit Toggle
keymap("n", "<leader>gg", ":LazyGit<cr>", opts)

-- Comment Plugin
keymap("n", "<leader>/", "<ESC><cmd>lua require('Comment.api').toggle.linewise.current()<cr>", opts)
keymap("v", "<leader>/", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", opts)

-- DAP
keymap("n", "<leader>db", "<cmd> DapToggleBreakpoint <cr>", opts)
keymap("n", "<leader>dpr", "<cmd>lua require('dap-python').test_method()<cr>", opts)
