local M = {}

function M.config()
  require('telescope').setup({
    defaults = {
      mappings = {
        i = {
          ["<C-j>"] = "move_selection_next",
          ["<C-k>"] = "move_selection_previous",
        },
      },
    },
    pickers = {
      colorscheme = {
        enable_preview = true,
      },
      buffers = {
        sort_mru = true,
        sort_lastused = true,
      },
    },
  })
end

return M
