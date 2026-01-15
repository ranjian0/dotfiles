local M = {}

function M.config()
  local telescope = require("telescope")
  local actions = require("telescope.actions")

  telescope.setup({
    defaults = {
      prompt_prefix = " ",
      selection_caret = " ",
      path_display = { "truncate" },
      sorting_strategy = "ascending",
      layout_config = {
        horizontal = {
          prompt_position = "top",
          preview_width = 0.55,
        },
        vertical = {
          mirror = false,
        },
      },
      mappings = {
        i = {
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          ["<ESC>"] = actions.close,
        },
        n = {
          ["q"] = actions.close,
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

  telescope.load_extension("frecency")
  telescope.load_extension("undo")
end

return M
