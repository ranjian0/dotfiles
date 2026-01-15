local M = {}

function M.config()
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
end

return M
