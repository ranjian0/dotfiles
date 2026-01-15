local M = {}

function M.config()
  require("git-conflict").setup({
    default_mappings = true,
    disable_diagnostics = false,
    list_opener = "copen",
    highlights = {
      incoming = "DiffAdd",
      current = "DiffText",
      ancestor = "DiffChange",
    },
  })
end

return M
