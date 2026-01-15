local M = {}

function M.config()
  local highlight = {
    "IndentLine",
  }

  local hooks = require "ibl.hooks"

  hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "IndentLine", { fg = "#4b5263" })
  end)

  require("ibl").setup({
    indent = {
      highlight = highlight,
      char = "│",
    },
    scope = {
      enabled = true,
      show_start = true,
      show_end = true,
      injected_languages = false,
      highlight = highlight,
      priority = 500,
    },
    exclude = {
      filetypes = {
        "help",
        "alpha",
        "dashboard",
        "neo-tree",
        "Trouble",
        "lazy",
        "mason",
        "notify",
        "toggleterm",
        "lazyterm",
      },
    },
  })
end

return M
