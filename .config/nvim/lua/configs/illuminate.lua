local M = {}

function M.config()
  require("illuminate").configure({
    providers = {
      "lsp",
      "treesitter",
      "regex",
    },
    delay = 100,
    filetypes_denylist = {
      "dirvish",
      "fugitive",
      "alpha",
      "NvimTree",
      "neo-tree",
      "dashboard",
      "lazy",
      "mason",
      "notify",
      "toggleterm",
    },
    under_cursor = true,
    large_file_cutoff = 2000,
    large_file_overrides = {
      providers = { "lsp" },
    },
  })
end

return M
