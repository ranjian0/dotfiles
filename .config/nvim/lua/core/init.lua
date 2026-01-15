-- Enable vim.loader for faster module loading
if vim.loader then
  vim.loader.enable()
end

-- Basics.
vim.opt.number         = true
vim.opt.relativenumber = true
vim.opt.termguicolors  = true
vim.opt.shiftround     = true
vim.opt.updatetime     = 100
vim.opt.cursorline     = true
vim.opt.autowrite      = true
vim.opt.splitbelow     = true
vim.opt.splitright     = true
vim.opt.ignorecase     = true
vim.opt.virtualedit    = "block"
vim.opt.inccommand     = "split"
vim.opt.autoindent    = true
vim.opt.tabstop       = 2
vim.opt.shiftwidth    = 2
vim.opt.softtabstop   = 2
vim.opt.mouse         = "a"
vim.opt.expandtab     = true
vim.opt.wrap          = false
vim.opt.formatoptions = ""
vim.opt.signcolumn    = "yes" -- Prevent sign column flickering.

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list          = true
vim.opt.listchars     = { tab = '» ', trail = '·', nbsp = '␣' }


-- Leader key has to be set up before setting up lazy.nvim.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- synchronize system clipboard with neovim clipboard
vim.opt.clipboard = "unnamedplus"
-- keeps the cursor at the center when scrolling
vim.opt.scrolloff = 10


-- Disable builtin features to save startup time.
vim.g.loaded_matchparen        = 1
vim.g.loaded_matchit           = 1
vim.g.loaded_logiPat           = 1
vim.g.loaded_rrhelper          = 1
vim.g.loaded_tarPlugin         = 1
vim.g.loaded_gzip              = 1
vim.g.loaded_zipPlugin         = 1
vim.g.loaded_2html_plugin      = 1
vim.g.loaded_shada_plugin      = 1
vim.g.loaded_spellfile_plugin  = 1
vim.g.loaded_netrw             = 1
vim.g.loaded_netrwPlugin       = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_remote_plugins    = 1

-- Setup lazy.nvim
local lazypath                 = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
  vim.opt.rtp:prepend(lazypath)

  require("lazy").setup({
    dev = {
      path = vim.fn.stdpath("data") .. "/projects",
      fallback = false,
    },
    performance = {
      rtp = {
        disabled_plugins = {
          "gzip",
          "tarPlugin",
          "tohtml",
          "tutor",
          "zipPlugin",
        },
      },
    },
    defaults = {
      lazy = false,
    },
    spec = {
      { import = "core.plugins" },
    },
  })

-- plugin specific configs
require("configs.treesitter").config()
require("configs.autocomplete").config()
require("configs.bufferline").config()
require("configs.statusline").config()
require("configs.filemanager").config()
require("configs.telescope").config()
require("configs.terminal").config()
require("configs.gitsigns").config()
require("configs.noice").config()
require("configs.whichkey").config()
require("configs.editor").config()
require("configs.lang.python").config()
require("configs.format").config()
require("configs.mini_pairs").config()
require("configs.lint").config()
require("configs.surround").config()
require("configs.spectre").config()
require("configs.harpoon").config()
require("configs.indent").config()
require("configs.illuminate").config()
require("configs.hipatterns").config()
require("configs.better_escape").config()
require("configs.diffview").config()
require("configs.conflict").config()
require("configs.persisted").config()
require("configs.project").config()
require("configs.test").config()
require("configs.colorizer").config()
require("configs.mini_ai").config()

require("core.keymaps")
require("core.autocmds")
require("core.theme")
