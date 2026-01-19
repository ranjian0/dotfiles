local utils = require("core.utils")

local M = {}

function M.config()
  utils.safe_setup("spectre", function()
    require("spectre").setup({
      open_cmd = "noswapfile vnew",
      is_block_ui_break = true,
      live_update = false,
      result_padding = "",
      line_sep_start = "┌-----------------------------------------",
      result_padding = "│ ",
      line_sep = "└────────────────────────────────────────",
      color_devicons = true,
      highlight = {
        headers = "SpectreHeader",
        ui = "SpectreBody",
        filename = "SpectreFile",
        file_path = "SpectreFilePath",
        search = "SpectreSearch",
        border = "SpectreBorder",
        replace = "SpectreReplace",
      },
      mapping = {
        ["toggle_line"] = {
          map = "dd",
          cmd = "<cmd>lua require('spectre').toggle_line()<CR>",
          desc = "toggle current item",
        },
        ["enter_file"] = {
          map = "<cr>",
          cmd = "<cmd>lua require('spectre').enter_file()<CR>",
          desc = "goto current file",
        },
        ["send_to_qf"] = {
          map = "<leader>q",
          cmd = "<cmd>lua require('spectre').send_to_qf()<CR>",
          desc = "send all item to quickfix",
        },
        ["replace_cmd"] = {
          map = "<leader>c",
          cmd = "<cmd>lua require('spectre').replace_cmd()<CR>",
          desc = "replace all",
        },
        ["show_option_menu"] = {
          map = "<leader>o",
          cmd = "<cmd>lua require('spectre').show_options()<CR>",
          desc = "show option",
        },
        ["run_current_replace"] = {
          map = "<leader>rc",
          cmd = "<cmd>lua require('spectre').run_current_replace()<CR>",
          desc = "replace current file",
        },
        ["run_replace"] = {
          map = "<leader>rp",
          cmd = "<cmd>lua require('spectre').run_replace()<CR>",
          desc = "replace all files",
        },
        ["change_view_mode"] = {
          map = "<leader>m",
          cmd = "<cmd>lua require('spectre').change_view()<CR>",
          desc = "change result view mode",
        },
        ["change_replace_sed"] = {
          map = "<leader>rs",
          cmd = "<cmd>lua require('spectre').change_engine_replace('sed')<CR>",
          desc = "use sed to replace",
        },
        ["change_replace_oxi"] = {
          map = "<leader>ro",
          cmd = "<cmd>lua require('spectre').change_engine_replace('oxi')<CR>",
          desc = "use oxi to replace",
        },
      },
      find_engine = {
        ["rg"] = {
          cmd = "rg",
          args = {
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
          },
          options = {
            ["ignore-case"] = {
              value = "--ignore-case",
              icon = "[I]",
              desc = "ignore case",
            },
            ["hidden"] = {
              value = "--hidden",
              desc = "hidden file",
              icon = "[H]",
            },
          },
        },
      },
      replace_engine = {
        ["sed"] = {
          cmd = "sed",
          args = nil,
        },
        ["oxi"] = {
          cmd = "oxi",
          args = nil,
        },
      },
      default = {
        find = {
          cmd = "rg",
          options = { "hidden" },
        },
        replace = {
          cmd = "sed",
        },
      },
      replace_vim_cmd = "cdo",
      is_open_target_win = true,
      is_insert_mode = false,
    })
  end)
end

return M
