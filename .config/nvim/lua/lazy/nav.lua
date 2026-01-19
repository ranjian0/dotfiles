local utils = require("core.utils")

local M = {}

function M.config()
  utils.safe_setup("telescope", function()
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
  end)

  utils.safe_setup("project_nvim", function()
    require("project_nvim").setup({
      manual_mode = false,
      detection_methods = { "lsp", "pattern" },
      patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Cargo.toml", "go.mod", "pom.xml" },
      exclude_lsp = {},
      ignore_lsp = {},
      silent_chdir = true,
      scope_chdir = "global",
      datapath = vim.fn.stdpath("data"),
    })

    require("telescope").load_extension("projects")
  end)

  utils.safe_setup("venv-selector", function()
    require('venv-selector').setup({
      ft = "python",
    })
  end)
end

return M
