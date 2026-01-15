local map = vim.keymap.set

-- file manager
map("n", "<leader>fe", "<cmd>Neotree toggle<cr>", { desc = "File Explorer" })
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
map("n", "<leader>fu", "<cmd>Telescope frecency workspace=CWD<cr>", { desc = "Recent Files" })
map("n", "<leader>fw", "<cmd>Telescope undo<cr>", { desc = "Undo History" })
map("n", "<leader>fp", "<cmd>Telescope projects<cr>", { desc = "Projects" })

-- b: buffer
map("n", "<leader>bn", "<cmd>bn<cr>", { desc = "Next Buffer" })
map("n", "<leader>bp", "<cmd>bp<cr>", { desc = "Previous Buffer" })
map("n", "<leader>bd", "<cmd>Bdelete<cr>", { desc = "Delete Buffer" })

-- t: terminal
-- use <f5> to toggle terminal, this can be set in lua/configs/terminal.lua
-- the default position is also set in lua/configs/terminal.lua
local terminal = require("toggleterm.terminal")
map("t", "<C-g>", "<C-\\><C-n>", { desc = "Exit Terminal Mode" })
map("n", "<leader>tt", "<cmd>ToggleTerm direction=tab<cr>", { desc = "Terminal Tab" })
map("n", "<leader>tn", function() terminal.Terminal:new():toggle() end, { desc = "Terminal New" })
map("n", "<leader>tF", "<cmd>ToggleTerm direction=float<cr>", { desc = "Terminal Float" })
map("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", { desc = "Terminal Horizontal" })
map("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", { desc = "Terminal Vertical" })

-- git
map("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })
map("n", "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<cr>", { desc = "Undo Stage Hunk" })
map("n", "<leader>gn", "<cmd>Gitsigns next_hunk<cr>", { desc = "Next Hunk" })
map("n", "<leader>gN", "<cmd>Gitsigns prev_hunk<cr>", { desc = "Previous Hunk" })
map("n", "<leader>gc", "<cmd>Gitsigns preview_hunk<cr>", { desc = "Preview Hunk" })
map("n", "<leader>gD", "<cmd>DiffviewOpen<cr>", { desc = "Git Diff" })
map("n", "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>", { desc = "Reset Hunk" })
map("n", "<leader>gR", "<cmd>Gitsigns reset_buffer<cr>", { desc = "Reset Buffer" })
map("n", "<leader>gl", "<cmd>Gitsigns blame_line<cr>", { desc = "Blame Line" })
map("n", "<leader>gd", "<cmd>Gitsigns diffthis<cr>", { desc = "Diff This" })
map("n", "<leader>gs", "<cmd>Gitsigns select_hunk<cr>", { desc = "Select Hunk" })

-- LSP
map("n", "<leader>la", "<cmd>Lspsaga code_action<cr>", { desc = "Code Action" })
map("n", "<leader>ld", "<cmd>Lspsaga preview_definition<cr>", { desc = "Preview Definition" })
map("n", "<leader>lr", "<cmd>Lspsaga rename<cr>", { desc = "Rename" })
map("n", "<leader>lq", vim.diagnostic.setloclist, { desc = "Diagnostics to Loclist" })
map("n", "<leader>lh", vim.lsp.buf.signature_help, { desc = "Signature Help" })
map("n", "<leader>lf", function() vim.lsp.buf.format { async = true } end, { desc = "Format" })
map("n", "<leader>lk", "<cmd>Lspsaga hover_doc<cr>", { desc = "Hover Doc" })
map("n", "<leader>lo", "<cmd>Lspsaga outline<cr>", { desc = "Outline" })
map("n", "<leader>ln", "<cmd>Lspsaga diagnostic_jump_next<cr>", { desc = "Next Diagnostic" })
map("n", "<leader>lN", "<cmd>Lspsaga diagnostic_jump_prev<cr>", { desc = "Previous Diagnostic" })

-- quickfix
map("n", "[q", "<cmd>cprev<cr>", { desc = "Previous quickfix" })
map("n", "]q", "<cmd>cnext<cr>", { desc = "Next quickfix" })
map("n", "[Q", "<cmd>cfirst<cr>", { desc = "First quickfix" })
map("n", "]Q", "<cmd>clast<cr>", { desc = "Last quickfix" })
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Open quickfix" })
map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Open loclist" })

-- search and replace
map("n", "<leader>sr", "<cmd>Spectre<cr>", { desc = "Search and Replace" })
map("n", "<leader>sw", "<cmd>Spectre open_file_cwd<cr>", { desc = "Search in Current File" })
map("n", "<leader>sp", "<cmd>Spectre open_visual<cr>", { desc = "Search in Selection" })

-- testing
map("n", "<leader>tr", "<cmd>lua require('neotest').run.run()<cr>", { desc = "Run Test" })
map("n", "<leader>tf", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", { desc = "Run File Tests" })
map("n", "<leader>td", "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", { desc = "Debug Test" })
map("n", "<leader>ts", "<cmd>lua require('neotest').summary.toggle()<cr>", { desc = "Test Summary" })
map("n", "<leader>to", "<cmd>lua require('neotest').output.open({ enter = true })<cr>", { desc = "Test Output" })

-- harpoon
map("n", "<leader>h", "<cmd>Telescope harpoon marks<cr>", { desc = "Harpoon Marks" })

-- session
map("n", "<leader>ps", "<cmd>SessionSave<cr>", { desc = "Save Session" })
map("n", "<leader>pl", "<cmd>SessionLoad<cr>", { desc = "Load Session" })
map("n", "<leader>pd", "<cmd>SessionDelete<cr>", { desc = "Delete Session" })

map("n", "<leader>lgd", "<cmd>Glance definitions<cr>", { desc = "Glance Definitions" })
map("n", "<leader>lgr", "<cmd>Glance references<cr>", { desc = "Glance References" })
map("n", "<leader>lgt", "<cmd>Glance type_definitions<cr>", { desc = "Glance Type Definitions" })
map("n", "<leader>lgi", "<cmd>Glance implementations<cr>", { desc = "Glance Implementations" })
