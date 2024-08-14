local map = vim.keymap.set

-- file manager
map("n", "<leader>fe", ":Neotree toggle<cr>")
-- lazy
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })
-- mason
map("n", "<leader>m", "<cmd>Mason<cr>", { desc = "Mason" })
-- lazygit
map("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })
-- quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })

-- save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Move Lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })

-- d: telescope
local telescope_builtin = require("telescope.builtin")
map("n", "<leader>sf", function() telescope_builtin.find_files() end)
map("n", "<F9>", function() telescope_builtin.find_files() end)
map("n", "<leader>sg", function() telescope_builtin.git_files() end)
map("n", "<F10>", function() telescope_builtin.git_files() end)
map("n", "<leader>sb", function() telescope_builtin.buffers() end)
map("n", "<leader>sc", function() telescope_builtin.colorscheme() end)
map("n", "<leader>sr", function() telescope_builtin.registers() end)
map({ "n", "i" }, "<C-p>", function() telescope_builtin.registers() end)

-- b: buffer
map("n", "<leader>bn", ":bn<cr>")
map("n", "<leader>bp", ":bp<cr>")
map("n", "<leader>bd", ":Bdelete<cr>")

-- t: terminal
-- use <f5> to toggle terminal, this can be set in lua/configs/terminal.lua
-- the default position is also set in lua/configs/terminal.lua
local terminal = require("toggleterm.terminal")
map("t", "<C-g>", "<C-\\><C-n>")
map("n", "<leader>tt", ":ToggleTerm direction=tab<cr>")
map("n", "<leader>tn", function() terminal.Terminal:new():toggle() end)
map("n", "<leader>tf", ":ToggleTerm direction=float<cr>")
map("n", "<leader>th", ":ToggleTerm direction=horizontal<cr>")
map("n", "<leader>tv", ":ToggleTerm direction=vertical<cr>")

-- h: git
map("n", "<leader>hu", ":Gitsigns undo_stage_hunk<cr>")
map("n", "<leader>hn", ":Gitsigns next_hunk<cr>")
map("n", "<leader>hN", ":Gitsigns next_hunk<cr>")
map("n", "<leader>hc", ":Gitsigns preview_hunk<cr>")
map("n", "<leader>hr", ":Gitsigns reset_hunk<cr>")
map("n", "<leader>hR", ":Gitsigns reset_buffer")
map("n", "<leader>hl", ":Gitsigns blame_line<cr>")
map("n", "<leader>hd", ":Gitsigns diffthis<cr>")
map("n", "<leader>hs", ":<C-U>Gitsigns select_hunk<CR>")
