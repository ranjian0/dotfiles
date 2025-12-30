local map = vim.keymap.set

-- file manager
map("n", "<leader>fe", ":Neotree toggle<cr>")
-- lazy
map("n", "<leader>ll", "<cmd>Lazy<cr>", { desc = "Lazy" })
-- mason
map("n", "<leader>cm", "<cmd>Mason<cr>", { desc = "Mason" })
-- virtualenv selector
map("n", "<leader>cv", "<cmd>VenvSelect<cr>", { desc = "Select Virtualenv" })

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


-- Duplicate line up or down
-- map("n", "<C-J>", "yyp", { desc = "Duplicate current line down" })
-- map("n", "<C-K>", "yy1kp", { desc = "Duplicate current line up" })
-- Convert tabs to spaces
map("n", "<leader>cS", "<cmd>:%s/\t/  /g<cr>", { desc = "Convert all tabs into spaces" }) -- note tabs are replaced with 2 spaces
-- Convert spaces to tabs
map("n", "<leader>cT", "<cmd>:%s/  /\t/g<cr>", { desc = "Convert all spaces into tabs" }) -- note tabs are replaced with 2 spaces
-- Strip trailing whitespace
map("n", "<leader>cW", "<cmd>:%s/\\s\\+$//e<cr>", { desc = "Trim all trailing whitespace" })
-- Multiple cursor search (C-d in sublime)
-- Multiple cursor Down
-- Search and replace root dir

-- Telescope
map("n", "<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", { desc = "Switch Buffer" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Grep (Root Dir)" })
map("n", "<leader>fc", "<cmd>Telescope git_commits<cr>", { desc = "Commit History" })
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files (Root Dir)" })
map("n", "<leader>ft", "<cmd>Telescope colorscheme<cr>", { desc = "Colorscheme with Preview" })
map("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Key Maps" })
map("n", "<leader>ffg", "<cmd>Telescope git_files<cr>", { desc = "Find Files (git-files)" })

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

-- git
map("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })
map("n", "<leader>gu", ":Gitsigns undo_stage_hunk<cr>")
map("n", "<leader>gn", ":Gitsigns next_hunk<cr>")
map("n", "<leader>gN", ":Gitsigns next_hunk<cr>")
map("n", "<leader>gc", ":Gitsigns preview_hunk<cr>")
map("n", "<leader>gr", ":Gitsigns reset_hunk<cr>")
map("n", "<leader>gR", ":Gitsigns reset_buffer")
map("n", "<leader>gl", ":Gitsigns blame_line<cr>")
map("n", "<leader>gd", ":Gitsigns diffthis<cr>")
map("n", "<leader>gs", ":<C-U>Gitsigns select_hunk<CR>")

-- LSP
map("n", "<leader>la", ":Lspsaga code_action<cr>")
map("n", "<leader>ld", ":Lspsaga preview_definition<cr>")
map("n", "<leader>lr", ":Lspsaga rename<cr>")
map("n", "<leader>lq", vim.diagnostic.setloclist)
map("n", "<leader>lh", vim.lsp.buf.signature_help)
map("n", "<leader>lf", function() vim.lsp.buf.format { async = true } end)
map("n", "<leader>lk", ":Lspsaga hover_doc<cr>")
map("n", "<leader>lo", ":Lspsaga outline<cr>")
map("n", "<leader>ln", ":Lspsaga diagnostic_jump_next<cr>")
map("n", "<leader>lN", ":Lspsaga diagnostic_jump_prev<cr>")


map("n", "<leader>lgd", ":Glance definitions<CR>")
map("n", "<leader>lgr", ":Glance references<CR>")
map("n", "<leader>lgt", ":Glance type_definitions<CR>")
map("n", "<leader>lgi", ":Glance implementations<CR>")
