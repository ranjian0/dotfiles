local map = vim.keymap.set

map("n", "<leader>ll", "<cmd>Lazy<cr>", { desc = "Lazy" })
map("n", "<leader>km", "<cmd>Mason<cr>", { desc = "Mason" })
map("n", "<leader>kc", "<cmd>VenvSelect<cr>", { desc = "Select Virtualenv" })

map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

map("v", "<", "<gv")
map("v", ">", ">gv")

map("n", "<leader>bs", "<cmd>w<cr>", { desc = "Save Buffer" })

map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })

map("n", "<leader>cS", "<cmd>:%s/\\t/  /g<cr>", { desc = "Convert all tabs into spaces" })
map("n", "<leader>cT", "<cmd>:%s/  /\\t/g<cr>", { desc = "Convert all spaces into tabs" })
map("n", "<leader>cW", "<cmd>:%s/\\s\\+$//e<cr>", { desc = "Trim all trailing whitespace" })

map("n", "<leader>ff", function() Snacks.picker.files() end, { desc = "Find Files (Root Dir)" })
map("n", "<leader>fg", function() Snacks.picker.git_files() end, { desc = "Find Files (git-files)" })
map("n", "<leader>fb", function() Snacks.picker.buffers() end, { desc = "Buffers" })
map("n", "<leader>fr", function() Snacks.picker.recent() end, { desc = "Recent Files" })
map("n", "<leader>fp", function() Snacks.picker.projects() end, { desc = "Projects" })

map("n", "<leader>fsg", function() Snacks.picker.grep() end, { desc = "Live Grep" })
map("n", "<leader>fsr", "<cmd>Spectre<cr>", { desc = "Search and Replace" })
map("n", "<leader>fsw", "<cmd>Spectre open_file_cwd<cr>", { desc = "Search in Current File" })

map("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })
map("n", "<leader>gd", function() Snacks.picker.git_diff() end, { desc = "Git Diff (Hunks)" })
map("n", "<leader>gc", function() Snacks.picker.git_log() end, { desc = "Commit History" })

map("n", "<leader>ghu", "<cmd>Gitsigns undo_stage_hunk<cr>", { desc = "Undo Stage Hunk" })
map("n", "<leader>ghn", "<cmd>Gitsigns next_hunk<cr>", { desc = "Next Hunk" })
map("n", "<leader>ghN", "<cmd>Gitsigns prev_hunk<cr>", { desc = "Previous Hunk" })
map("n", "<leader>ghc", "<cmd>Gitsigns preview_hunk<cr>", { desc = "Preview Hunk" })
map("n", "<leader>ghr", "<cmd>Gitsigns reset_hunk<cr>", { desc = "Reset Hunk" })
map("n", "<leader>ghR", "<cmd>Gitsigns reset_buffer<cr>", { desc = "Reset Buffer" })
map("n", "<leader>ghl", "<cmd>Gitsigns blame_line<cr>", { desc = "Blame Line" })
map("n", "<leader>ghd", "<cmd>Gitsigns diffthis<cr>", { desc = "Diff This" })
map("n", "<leader>ghs", "<cmd>Gitsigns select_hunk<cr>", { desc = "Select Hunk" })

map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
map("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename" })
map("n", "<leader>cf", function() vim.lsp.buf.format { async = true } end, { desc = "Format" })
map("n", "<leader>lh", vim.lsp.buf.signature_help, { desc = "Signature Help" })
map("n", "<leader>lk", vim.lsp.buf.hover, { desc = "Hover Doc" })
map("n", "<leader>ll", vim.diagnostic.setloclist, { desc = "Diagnostics to Loclist" })

map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })

map("n", "<leader>qs", "<cmd>SessionSave<cr>", { desc = "Save Session" })
map("n", "<leader>ql", "<cmd>SessionLoad<cr>", { desc = "Load Session" })
map("n", "<leader>qd", "<cmd>SessionDelete<cr>", { desc = "Delete Session" })

map("n", "<leader>ttr", "<cmd>lua require('neotest').run.run()<cr>", { desc = "Run Test" })
map("n", "<leader>ttf", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", { desc = "Run File Tests" })
map("n", "<leader>ttd", "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", { desc = "Debug Test" })
map("n", "<leader>tts", "<cmd>lua require('neotest').summary.toggle()<cr>", { desc = "Test Summary" })
map("n", "<leader>tto", "<cmd>lua require('neotest').output.open({ enter = true })<cr>", { desc = "Test Output" })

local terminal = require("toggleterm.terminal")
map("n", "<leader>tmt", "<cmd>ToggleTerm direction=tab<cr>", { desc = "Terminal Tab" })
map("n", "<leader>tmn", function() terminal.Terminal:new():toggle() end, { desc = "Terminal New" })
map("n", "<leader>tmf", "<cmd>ToggleTerm direction=float<cr>", { desc = "Terminal Float" })
map("n", "<leader>tmh", "<cmd>ToggleTerm direction=horizontal<cr>", { desc = "Terminal Horizontal" })
map("n", "<leader>tmv", "<cmd>ToggleTerm direction=vertical<cr>", { desc = "Terminal Vertical" })

map("t", "<C-g>", "<C-\\><C-n>", { desc = "Exit Terminal Mode" })

map("n", "<leader>uu", function() Snacks.picker.undo() end, { desc = "Undo History" })

map("n", "<leader>kk", function() Snacks.picker.keymaps() end, { desc = "Key Maps" })

map("n", "<leader>vc", function() Snacks.picker.colorschemes() end, { desc = "Colorscheme with Preview" })

map("n", "<leader>wh", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<leader>wj", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<leader>wk", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<leader>wl", "<C-w>l", { desc = "Go to Right Window", remap = true })
map("n", "<leader>wH", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<leader>wJ", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<leader>wK", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })
map("n", "<leader>wL", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })

map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Open quickfix" })
map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Open loclist" })

map("n", "[q", "<cmd>cprev<cr>", { desc = "Previous quickfix" })
map("n", "]q", "<cmd>cnext<cr>", { desc = "Next quickfix" })
map("n", "[Q", "<cmd>cfirst<cr>", { desc = "First quickfix" })
map("n", "]Q", "<cmd>clast<cr>", { desc = "Last quickfix" })

map("n", "<leader>bn", "<cmd>bn<cr>", { desc = "Next Buffer" })
map("n", "<leader>bp", "<cmd>bp<cr>", { desc = "Previous Buffer" })
map("n", "<leader>bd", "<cmd>Bdelete<cr>", { desc = "Delete Buffer" })
