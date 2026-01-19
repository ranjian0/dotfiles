if vim.loader then
  vim.loader.enable()
end

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.shiftround = true
vim.opt.updatetime = 100
vim.opt.cursorline = true
vim.opt.autowrite = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.ignorecase = true
vim.opt.virtualedit = "block"
vim.opt.inccommand = "split"
vim.opt.autoindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.mouse = "a"
vim.opt.expandtab = true
vim.opt.wrap = false
vim.opt.formatoptions = ""
vim.opt.signcolumn = "yes"

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.clipboard = "unnamedplus"
vim.opt.scrolloff = 10

vim.g.loaded_matchparen = 1
vim.g.loaded_matchit = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_shada_plugin = 1
vim.g.loaded_spellfile_plugin = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_remote_plugins = 1

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local ok, lazy = pcall(require, "lazy")
if not ok then
  vim.notify("Failed to load lazy.nvim", vim.log.levels.ERROR)
  return
end

lazy.setup({
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
  install = {
    colorscheme = { "kanagawa" },
  },
  ui = {
    border = "rounded",
  },
})

local function safe_require(module)
  local ok, result = pcall(require, module)
  if ok then return result end
  vim.notify("Failed to load module: " .. module, vim.log.levels.WARN)
  return nil
end

safe_require("core.keymaps")
safe_require("core.autocmds")
safe_require("core.theme")
safe_require("core.health")
