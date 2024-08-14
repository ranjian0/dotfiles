require("lazy").setup({
    -- themes
    "sainnhe/sonokai",
    "tiagovla/tokyodark.nvim",
    "projekt0n/github-nvim-theme",
    "olimorris/onedarkpro.nvim",
    "miikanissi/modus-themes.nvim",
    "rmehri01/onenord.nvim",
    { "catppuccin/nvim", name = "catppuccin" },
    "liuchengxu/space-vim-dark",
    {"ahmedabdulrahman/aylin.vim", branch="0.5-nvim"},
    "rebelot/kanagawa.nvim",
    "NLKNguyen/papercolor-theme",
    "liuchengxu/space-vim-dark",
    "sainnhe/edge",
    "nyoom-engineering/oxocarbon.nvim",
    "AlexvZyl/nordic.nvim",
    "lewis6991/gitsigns.nvim",
    "kaicataldo/material.vim",
    "neanias/everforest-nvim",
    "rebelot/kanagawa.nvim",

    -- basics
    "kyazdani42/nvim-web-devicons",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "akinsho/bufferline.nvim",
    "moll/vim-bbye",
    "3rd/image.nvim",
    {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
          "nvim-lua/plenary.nvim",
          "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
          "MunifTanjim/nui.nvim",
          "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        }
    },

    "williamboman/mason.nvim",
    {"williamboman/mason-lspconfig.nvim", dependencies = { "mason.nvim" }},
    "neovim/nvim-lspconfig",
    "nvimdev/lspsaga.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    "L3MON4D3/LuaSnip",
    "nvim-treesitter/nvim-treesitter",
    "dnlhc/glance.nvim",
    "tamago324/nlsp-settings.nvim",
    "folke/trouble.nvim",
    "nvim-lualine/lualine.nvim",
    "akinsho/toggleterm.nvim",
    "BurntSushi/ripgrep",
    "nvim-telescope/telescope.nvim",
    {"kdheepak/lazygit.nvim", dependencies={"nvim-lua/plenary.nvim"}},

    -- python
    {"linux-cultist/venv-selector.nvim", branch="regexp"},
})
