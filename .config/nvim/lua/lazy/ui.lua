local utils = require("core.utils")

local M = {}

function M.config()
  utils.safe_setup("lualine", function()
    require('lualine').setup({
      options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {},
        always_divide_middle = true,
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_z = { 'location' }
      },
      inactive_sections = {
        lualine_a = { 'filename' },
        lualine_b = {},
        lualine_c = {},
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {},
      extensions = {}
    })
  end)

  utils.safe_setup("bufferline", function()
    require('bufferline').setup({
      options = {
        always_show_bufferline = false,
        offsets = {
          { filetype = "neo-tree", text = "Neo-tree", text_align = "left", highlight = "Directory" },
        },
      }
    })
  end)

  utils.safe_setup("which-key", function()
    local wk = require("which-key")
    wk.setup({
      plugins = {
        marks = true,
        registers = true,
        spelling = {
          enabled = true,
          suggestions = 20,
        },
      },
      preset = "modern",
      delay = 0,
      win = {
        border = "rounded",
        padding = { 1, 2 },
        wo = {
          winblend = 10,
        },
      },
    })

    wk.add({
      { "<leader><tab>", group = "Tabs",                icon = { icon = "", color = "cyan" } },
      { "<leader>b",     group = "Buffer",              icon = { icon = "", color = "blue" } },
      { "<leader>c",     group = "Code",                icon = { icon = "", color = "green" } },
      { "<leader>f",     group = "File & Find",         icon = { icon = "", color = "blue" } },
      { "<leader>fs",    group = "Search",              icon = { icon = "", color = "blue" } },
      { "<leader>g",     group = "Git",                 icon = { icon = "", color = "orange" } },
      { "<leader>gh",    group = "Hunks",               icon = { icon = "", color = "yellow" } },
      { "<leader>h",     group = "Bookmarks",           icon = { icon = "", color = "purple" } },
      { "<leader>k",     group = "Keymaps/Help",        icon = { icon = "", color = "cyan" } },
      { "<leader>l",     group = "LSP",                 icon = { icon = "", color = "blue" } },
      { "<leader>o",     group = "Opencode/AI",         icon = { icon = "", color = "cyan" } },
      { "<leader>oi",    group = "Input",               icon = { icon = "", color = "cyan" } },
      { "<leader>oo",    group = "Output",              icon = { icon = "", color = "cyan" } },
      { "<leader>os",    group = "Session",             icon = { icon = "", color = "cyan" } },
      { "<leader>od",    group = "Diff",                icon = { icon = "", color = "cyan" } },
      { "<leader>q",     group = "Quit/Session",        icon = { icon = "", color = "red" } },
      { "<leader>s",     group = "Search",              icon = { icon = "", color = "purple" } },
      { "<leader>t",     group = "Tools",               icon = { icon = "", color = "yellow" } },
      { "<leader>te",    group = "Testing",             icon = { icon = "", color = "yellow" } },
      { "<leader>to",    group = "Toggle",              icon = { icon = "", color = "green" } },
      { "<leader>tt",    desc = "Toggle Terminal",      icon = { icon = "", color = "green" } },
      { "<leader>u",     group = "Undo/History",        icon = { icon = "", color = "gray" } },
      { "<leader>v",     group = "Visual/Misc",         icon = { icon = "", color = "cyan" } },
      { "<leader>w",     group = "Window",              icon = { icon = "", color = "cyan" } },
      { "<leader>x",     group = "Quickfix/Loclist",    icon = { icon = "", color = "red" } },
      { "[",             group = "Previous",            icon = { icon = "", color = "gray" } },
      { "]",             group = "Next",                icon = { icon = "", color = "gray" } },
      { "g",             group = "Goto",                icon = { icon = "", color = "blue" } },
      { "z",             group = "Fold",                icon = { icon = "", color = "gray" } },
      { "gx",            desc = "Open with System App", icon = { icon = "", color = "orange" } },
      { "<C-s>",         desc = "Save File",            icon = { icon = "", color = "green" }, mode = "i" },
      { "<Esc>",         desc = "Exit Terminal Mode",   icon = { icon = "", color = "red" },   mode = "t" },
      { "<C-\\>",        desc = "Toggle Terminal",      icon = { icon = "", color = "green" }, mode = { "n", "t" } },
    })
  end)

  utils.safe_setup("noice", function()
    require("noice").setup({
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        hover = {
          enabled = true,
          silent = false,
          view = nil,
          opts = {},
        },
        signature = {
          enabled = true,
          auto_open = {
            enabled = true,
            trigger = true,
            luasnip = true,
            throttle = 50,
          },
          view = nil,
          opts = {},
        },
        message = {
          enabled = true,
          view = "mini",
          view_error = "mini",
          view_warn = "mini",
          view_history = "messages",
          view_search = "virtualtext",
        },
        progress = {
          enabled = true,
          format = "lsp_progress",
          format_done = "lsp_progress_done",
          throttle = 1000 / 30,
          view = "mini",
        },
      },
      popupmenu = {
        enabled = true,
        backend = "nui",
        kind_icons = {},
      },
      cmdline = {
        enabled = true,
        view = "cmdline_popup",
        opts = {},
        format = {
          cmdline = { pattern = "^:", icon = ":", lang = "vim" },
          search_down = { kind = "search", pattern = "^/", icon = "/", lang = "regex" },
          search_up = { kind = "search", pattern = "^%?", icon = "?", lang = "regex" },
          filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
          lua = { pattern = "^:%s*lua%s+", icon = "", lang = "lua" },
          help = { pattern = "^:%s*he?l?p?%s+", icon = "?" },
        },
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            kind = "",
            find = "written",
          },
          opts = { skip = true },
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = false,
      },
      commands = {
        all = {
          view = "split",
          opts = { enter = true, format = "details" },
          filter = {},
        },
        history = {
          view = "split",
          opts = { enter = true, format = "details" },
          filter = { ["not"] = { min_height = 5 } },
        },
        last = {
          view = "popup",
          opts = { enter = true, format = "details" },
          filter = { ["not"] = { min_height = 5 } },
        },
      },
      format = {},
      views = {
        cmdline_popup = {
          border = {
            style = "rounded",
            padding = { 0, 1 },
          },
          filter_options = {},
          win_options = {
            winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
          },
        },
        mini = {
          timeout = 3000,
          border = {
            style = "rounded",
            padding = { 0, 1 },
          },
          position = {
            row = -1,
            col = 0,
          },
          win_options = {
            winblend = 0,
            winhighlight = {
              Normal = "NormalFloat",
              Border = "FloatBorder",
            },
          },
        },
      },
    })
  end)
end

return M
