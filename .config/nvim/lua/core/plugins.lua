return {
  { "nvim-lua/plenary.nvim", lazy = true },
  { "MunifTanjim/nui.nvim", lazy = true },
  { "nvim-tree/nvim-web-devicons", lazy = true },

  { "catppuccin/nvim", name = "catppuccin", lazy = false, priority = 1000 },
  { "rebelot/kanagawa.nvim", lazy = false, priority = 1000 },
  { "olimorris/onedarkpro.nvim", lazy = false, priority = 1000 },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function() require("lazy.ui").config() end,
  },

  {
    "williamboman/mason.nvim",
    event = "VeryLazy",
    config = function() require("lazy.lsp").config() end,
  },
  { "williamboman/mason-lspconfig.nvim", event = "VeryLazy" },
  { "neovim/nvim-lspconfig", event = "VeryLazy" },

  { "hrsh7th/cmp-nvim-lsp", event = "InsertEnter" },
  { "hrsh7th/cmp-buffer", event = "InsertEnter" },
  { "hrsh7th/cmp-path", event = "InsertEnter" },
  { "hrsh7th/cmp-cmdline", event = "CmdlineEnter" },
  { "hrsh7th/nvim-cmp", event = "InsertEnter" },
  { "L3MON4D3/LuaSnip", event = "InsertEnter" },
  { "nvim-treesitter/nvim-treesitter", event = "VeryLazy" },
  { "nvim-treesitter/nvim-treesitter-textobjects", event = "VeryLazy" },

  { "tamago324/nlsp-settings.nvim", event = "VeryLazy" },
  { "folke/trouble.nvim", event = "VeryLazy" },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function() require("lazy.ui").config() end,
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function() require("lazy.ui").config() end,
  },

  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    config = function() require("lazy.ui").config() end,
  },

  {
    "akinsho/toggleterm.nvim",
    event = "VeryLazy",
    config = function() require("lazy.term").config() end,
  },

  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    config = function() require("lazy.git").config() end,
  },

  { "BurntSushi/ripgrep", lazy = true },



  { "kdheepak/lazygit.nvim", event = "VeryLazy", dependencies = { "nvim-lua/plenary.nvim" } },

  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    config = function() require("lazy.editor").config() end,
  },

  { "rafamadriz/friendly-snippets", event = "InsertEnter" },
  { "saadparwaiz1/cmp_luasnip", event = "InsertEnter" },

  {
    "echasnovski/mini.pairs",
    event = "InsertEnter",
    config = function() require("lazy.editor").config() end,
  },

  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    config = function() require("lazy.editor").config() end,
  },

  {
    "echasnovski/mini.hipatterns",
    event = "VeryLazy",
    config = function() require("lazy.extras").config() end,
  },

  {
    "echasnovski/mini.surround",
    event = "VeryLazy",
    config = function() require("lazy.editor").config() end,
  },

  {
    "stevearc/conform.nvim",
    event = { "BufWritePre", "BufNewFile" },
    config = function() require("lazy.format").config() end,
  },

  {
    "mfussenegger/nvim-lint",
    event = { "BufWritePost", "BufEnter", "InsertLeave" },
    config = function() require("lazy.format").config() end,
  },

  {
    "nvim-pack/nvim-spectre",
    keys = { "<leader>fsr", "<leader>fsw", "<leader>fsp" },
    config = function() require("lazy.spectre").config() end,
  },

  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      picker = { enabled = true },
      files = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      words = { enabled = true },
      terminal = {
        enabled = false,
      },
      scroll = {
        enabled = true,
      },
      statuscolumn = { enabled = false },
    },
    keys = {
      -- Top Pickers & Explorer
      { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
      { "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
      { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
      { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
      { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },
      { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
      -- find
      { "<leader>fe", function() Snacks.picker.explorer() end, desc = "File Explorer" },
      { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
      { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
      { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
      { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
      { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
      { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
      -- git
      { "<leader>gc", function() Snacks.picker.git_log() end, desc = "Git Commits" },
      { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
      { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
      { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
      { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
      { "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
      { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
      { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
      -- gh
      { "<leader>gi", function() Snacks.picker.gh_issue() end, desc = "GitHub Issues (open)" },
      { "<leader>gI", function() Snacks.picker.gh_issue({ state = "all" }) end, desc = "GitHub Issues (all)" },
      { "<leader>gp", function() Snacks.picker.gh_pr() end, desc = "GitHub Pull Requests (open)" },
      { "<leader>gP", function() Snacks.picker.gh_pr({ state = "all" }) end, desc = "GitHub Pull Requests (all)" },
      -- Grep
      { "<leader>fsg", function() Snacks.picker.grep() end, desc = "Live Grep" },
      { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
      { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
      { "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep" },
      { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
      -- search
      { '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
      { '<leader>s/', function() Snacks.picker.search_history() end, desc = "Search History" },
      { "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
      { "<leader>sc", function() Snacks.picker.command_history() end, desc = "Command History" },
      { "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands" },

      { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
      { "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
      { "<leader>si", function() Snacks.picker.icons() end, desc = "Icons" },
      { "<leader>sj", function() Snacks.picker.jumps() end, desc = "Jumps" },
      { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
      { "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" },
      { "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
      { "<leader>sM", function() Snacks.picker.man() end, desc = "Man Pages" },
      { "<leader>sp", function() Snacks.picker.lazy() end, desc = "Search for Plugin Spec" },
      { "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
      { "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume" },
      -- bookmarks
      { "<leader>ha", function() Snacks.picker.bookmarks.add() end, desc = "Add Bookmark" },
      { "<leader>hr", function() Snacks.picker.bookmarks.remove() end, desc = "Remove Bookmark" },
      { "<leader>hh", function() Snacks.picker.bookmarks() end, desc = "Bookmarks" },
      { "<leader>ht", function() Snacks.picker.recent() end, desc = "Recent Files" },
      { "<M-1>", function() Snacks.picker.bookmarks.global():find() end, desc = "Bookmark 1" },
      { "<M-2>", function() Snacks.picker.bookmarks.global():find() end, desc = "Bookmark 2" },
      { "<M-3>", function() Snacks.picker.bookmarks.global():find() end, desc = "Bookmark 3" },
      { "<M-4>", function() Snacks.picker.bookmarks.global():find() end, desc = "Bookmark 4" },
      -- undo & colors
      { "<leader>uu", function() Snacks.picker.undo() end, desc = "Undo History" },
      { "<leader>vc", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
      -- Code
      { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action" },
      { "<leader>cr", vim.lsp.buf.rename, desc = "Rename" },
      { "<leader>cf", function() vim.lsp.buf.format { async = true } end, desc = "Format" },
      -- LSP
      { "<leader>ld>", function() Snacks.picker.lsp_definitions() end, desc = "Go to Definition" },
      { "<leader>lg", function() Snacks.picker.lsp_declarations() end, desc = "Go to Declaration" },
      { "<leader>lr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "Go to References" },
      { "<leader>li", function() Snacks.picker.lsp_implementations() end, desc = "Go to Implementation" },
      { "<leader>lt", function() Snacks.picker.lsp_type_definitions() end, desc = "Go to Type Definition" },
      { "<leader>ls", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
      { "<leader>lS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
      { "<leader>lci", function() Snacks.picker.lsp_incoming_calls() end, desc = "Calls Incoming" },
      { "<leader>lco", function() Snacks.picker.lsp_outgoing_calls() end, desc = "Calls Outgoing" },
      { "<leader>lh", vim.lsp.buf.signature_help, desc = "Signature Help" },
      { "<leader>lk", vim.lsp.buf.hover, desc = "Hover Doc" },
      { "<leader>ll", vim.diagnostic.setloclist, desc = "Diagnostics to Loclist" },
      { "<leader>ld", function() Snacks.picker.diagnostics() end, desc = "Workspace Diagnostics" },
      { "<leader>lD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
    },
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
    config = function() require("lazy.extras").config() end,
  },

  {
    "RRethy/vim-illuminate",
    event = "VeryLazy",
    config = function() require("lazy.extras").config() end,
  },

  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function() require("lazy.editor").config() end,
  },

  {
    "olimorris/persisted.nvim",
    event = "VeryLazy",
    config = function() require("lazy.extras").config() end,
  },



  {
    "nvim-neotest/nvim-nio",
    lazy = true,
  },

  {
    "nvim-neotest/neotest",
    event = "VeryLazy",
    dependencies = {
      "nvim-neotest/nvim-nio",
    },
    config = function() require("lazy.test").config() end,
  },

  {
    "nvim-neotest/neotest-python",
    event = "VeryLazy",
    ft = "python",
  },

  {
    "sindrets/diffview.nvim",
    event = "VeryLazy",
    config = function() require("lazy.git").config() end,
  },

  {
    "akinsho/git-conflict.nvim",
    event = "VeryLazy",
    config = function() require("lazy.git").config() end,
  },

  {
    "linux-cultist/venv-selector.nvim",
    event = "VeryLazy",
    ft = "python",
    config = function() require("lazy.venv").config() end,
  },

  {
    "sudo-tee/opencode.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          anti_conceal = { enabled = false },
          file_types = { 'markdown', 'opencode_output' },
        },
        ft = { 'markdown', 'Avante', 'copilot-chat', 'opencode_output' },
      },
      "nvim-telescope/telescope.nvim",
    },
    config = function() require("lazy.ai").config() end,
  },

  {
    "moll/vim-bbye",
    cmd = "Bdelete",
  },
}

