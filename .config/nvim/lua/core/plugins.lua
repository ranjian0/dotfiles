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
      indent = { enabled = true },
      toggle = { enabled = true },
      terminal = {
        enabled = true,
        opts = {
          -- Float size (80% width, 60% height)
          float = {
            width = 0.8,
            height = 0.6,
            border = "single",
            winblend = 1,
          },
          -- Multiple terminals with winbar
          winbar = {
            enabled = true,
          },
          -- Shell
          shell = vim.o.shell,
          -- Always use root as working directory
          cwd = function() return vim.fn.getcwd(-1, -1) end,
          -- Persistent terminals
          restore = true,
        },
      },
      scroll = {
        enabled = true,
      },
      statuscolumn = { enabled = true },
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

