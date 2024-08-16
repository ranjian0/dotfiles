local map = vim.keymap.set

-- file manager
map("n", "<leader>fe", ":Neotree toggle<cr>")
-- lazy
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })
-- mason
map("n", "<leader>cm", "<cmd>Mason<cr>", { desc = "Mason" })
-- lazygit
map("n", "<leader>g", "<cmd>LazyGit<cr>", { desc = "LazyGit" })
-- virtualenv selector 
map("n", "<leader>cv", "<cmd>VenvSelect<cr>", { desc = "Select Virtualenv" })

-- quit
map("n", "<leader>q", "<cmd>qa<cr>", { desc = "Quit All" })

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

-- s: telescope
map("n", "<leader>,", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", { desc = "Switch Buffer", })
map("n",  "<leader>/", "<cmd>Telescope live_grep<cr>", { desc = "Grep (Root Dir)" })
map("n",  "<leader>:", "<cmd>Telescope command_history<cr>", { desc = "Command History" })
map("n",  "<leader><space>", "<cmd>Telescope find_files<cr>", { desc = "Find Files (Root Dir)" })
-- find
map("n",  "<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", { desc = "Buffers" })
map("n",  "<leader>fg", "<cmd>Telescope git_files<cr>", { desc = "Find Files (git-files)" })
map("n",  "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent" })
-- git
map("n",  "<leader>gc", "<cmd>Telescope git_commits<CR>", { desc = "Commits" })
map("n",  "<leader>gs", "<cmd>Telescope git_status<CR>", { desc = "Status" })
-- search
map("n",  "<leader>sa", "<cmd>Telescope autocommands<cr>", { desc = "Auto Commands" })
map("n",  "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "Buffer" })
map("n",  "<leader>sc", "<cmd>Telescope command_history<cr>", { desc = "Command History" })
map("n",  "<leader>sC", "<cmd>Telescope commands<cr>", { desc = "Commands" })
map("n",  "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", { desc = "Document Diagnostics" })
map("n",  "<leader>sD", "<cmd>Telescope diagnostics<cr>", { desc = "Workspace Diagnostics" })
map("n",  "<leader>sh", "<cmd>Telescope help_tags<cr>", { desc = "Help Pages" })
map("n",  "<leader>sH", "<cmd>Telescope highlights<cr>", { desc = "Search Highlight Groups" })
map("n",  "<leader>sj", "<cmd>Telescope jumplist<cr>", { desc = "Jumplist" })
map("n",  "<leader>sk", "<cmd>Telescope keymaps<cr>", { desc = "Key Maps" })
map("n",  "<leader>sl", "<cmd>Telescope loclist<cr>", { desc = "Location List" })
map("n",  "<leader>sM", "<cmd>Telescope man_pages<cr>", { desc = "Man Pages" })
map("n",  "<leader>sm", "<cmd>Telescope marks<cr>", { desc = "Jump to Mark" })
map("n",  "<leader>so", "<cmd>Telescope vim_options<cr>", { desc = "Options" })
map("n",  "<leader>sR", "<cmd>Telescope resume<cr>", { desc = "Resume" })
map("n",  "<leader>sq", "<cmd>Telescope quickfix<cr>", { desc = "Quickfix List" })
map("n",  "<leader>uC", "<cmd>Telescope colorscheme<cr>", { desc = "Colorscheme with Preview" })

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

-- l/g/w: language
-- l: general
-- g: goto
-- w: workspace
-- e: diagnostics
map("n", "<leader>ee", ":Lspsaga show_line_diagnostics<cr>")
map("n", "<leader>ef", ":Lspsaga show_cursor_diagnostics<cr>")
map("n", "<leader>el", ":TroubleToggle<cr>") -- Show list of diagnostics across the workspace
map("n", "<leader>et", ":Trouble<cr>") -- Focus onto the trouble window
map("n", "<leader>lq", vim.diagnostic.setloclist)
map("n", "<leader>lk", ":Lspsaga hover_doc<cr>")
map("n", "<leader>ld", ":Lspsaga preview_definition<cr>")
map("n", "<leader>lr", ":Lspsaga rename<cr>")
map("n", "<leader>lh", vim.lsp.buf.signature_help)
map("n", "<leader>lf", function() vim.lsp.buf.format { async = true } end)
map("n", "<leader>la", ":Lspsaga code_action<cr>")
map("n", "<F12>", ":Lspsaga code_action<cr>")

map("n", "<leader>gd", ":Glance definitions<CR>")
map("n", "<F4>", ":Glance references<CR>")
map("n", "<leader>gt", ":Glance type_definitions<CR>")
map("n", "<leader>gi", ":Glance implementations<CR>")
map("n", "<leader>gp", ":Lspsaga diagnostic_jump_prev<cr>")
map("n", "<leader>gn", ":Lspsaga diagnostic_jump_next<cr>")

map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder)
map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder)
map("n", "<leader>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end)
