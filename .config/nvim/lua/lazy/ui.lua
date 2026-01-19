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
      { "<leader><tab>", group = "Tabs", icon = { icon = "", color = "cyan" } },
      {
        "<leader>b",
        group = "Buffer",
        icon = { icon = "", color = "blue" },
        expand = function()
          return require("which-key.extras").expand.buf()
        end,
      },
      { "<leader>c", group = "Code", icon = { icon = "", color = "green" } },
      { "<leader>f", group = "Find", icon = { icon = "", color = "blue" } },
      { "<leader>fe", desc = "File Explorer" },
      { "<leader>ff", desc = "Find Files" },
      { "<leader>fg", desc = "Live Grep" },
      { "<leader>fb", desc = "Buffers" },
      { "<leader>fu", desc = "Recent Files" },
      { "<leader>fw", desc = "Undo History" },
      { "<leader>fp", desc = "Projects" },
      { "<leader>ft", desc = "Themes" },
      { "<leader>fc", desc = "Commit History" },
      { "<leader>fk", desc = "Keymaps" },
      { "<leader>ffg", desc = "Find Files (git-files)" },
      { "<leader>g", group = "Git", icon = { icon = "", color = "orange" } },
      { "<leader>gg", desc = "LazyGit" },
      { "<leader>gD", desc = "Diffview" },
      { "<leader>gh", group = "Hunks", icon = { icon = "", color = "yellow" } },
      { "<leader>gu", desc = "Undo Stage" },
      { "<leader>gn", desc = "Next Hunk" },
      { "<leader>gN", desc = "Prev Hunk" },
      { "<leader>gc", desc = "Preview Hunk" },
      { "<leader>gr", desc = "Reset Hunk" },
      { "<leader>gR", desc = "Reset Buffer" },
      { "<leader>gl", desc = "Blame Line" },
      { "<leader>gd", desc = "Diff This" },
      { "<leader>gs", desc = "Select Hunk" },
      { "<leader>h", group = "Bookmarks", icon = { icon = "", color = "purple" } },
      { "<leader>ha", desc = "Add Bookmark" },
      { "<leader>hr", desc = "Remove Bookmark" },
      { "<leader>hh", desc = "Bookmarks" },
      { "<leader>ht", desc = "Recent Files" },
      { "<leader>o", group = "Opencode", icon = { icon = "", color = "cyan" } },
      { "<leader>og", desc = "Toggle" },
      { "<leader>oi", desc = "Open Input" },
      { "<leader>oI", desc = "New Session" },
      { "<leader>oo", desc = "Open Output" },
      { "<leader>ot", desc = "Toggle Focus" },
      { "<leader>oq", desc = "Close" },
      { "<leader>os", desc = "Select Session" },
      { "<leader>oR", desc = "Rename Session" },
      { "<leader>op", desc = "Configure Provider" },
      { "<leader>oz", desc = "Toggle Zoom" },
      { "<leader>od", desc = "Open Diff" },
      { "<leader>o]", desc = "Next Diff" },
      { "<leader>o[", desc = "Prev Diff" },
      { "<leader>oc", desc = "Close Diff" },
      { "<leader>ox", desc = "Swap Position" },
      { "<leader>o/", desc = "Quick Chat" },
      { "<leader>l", group = "LSP", icon = { icon = "", color = "blue" } },
      { "<leader>la", desc = "Code Action" },
      { "<leader>ld", desc = "Preview Definition" },
      { "<leader>lr", desc = "Rename" },
      { "<leader>lq", desc = "Diagnostics to Loclist" },
      { "<leader>lh", desc = "Signature Help" },
      { "<leader>lf", desc = "Format" },
      { "<leader>lk", desc = "Hover Doc" },
      { "<leader>lo", desc = "Outline" },
      { "<leader>ln", desc = "Next Diagnostic" },
      { "<leader>lN", desc = "Prev Diagnostic" },
      { "<leader>lg", group = "Glance", icon = { icon = "", color = "cyan" } },
      { "<leader>lgd", desc = "Definitions" },
      { "<leader>lgr", desc = "References" },
      { "<leader>lgt", desc = "Type Definitions" },
      { "<leader>lgi", desc = "Implementations" },
      { "<leader>q", group = "Quit/Session", icon = { icon = "", color = "red" } },
      { "<leader>qq", desc = "Quit All" },
      { "<leader>ps", desc = "Save Session" },
      { "<leader>pl", desc = "Load Session" },
      { "<leader>pd", desc = "Delete Session" },
      { "<leader>s", group = "Search/Replace", icon = { icon = "", color = "purple" } },
      { "<leader>sr", desc = "Search Replace" },
      { "<leader>sw", desc = "Search Current File" },
      { "<leader>sp", desc = "Search Selection" },
      { "<leader>t", group = "Testing", icon = { icon = "", color = "yellow" } },
      { "<leader>tr", desc = "Run Test" },
      { "<leader>tf", desc = "Run File Tests" },
      { "<leader>td", desc = "Debug Test" },
      { "<leader>ts", desc = "Test Summary" },
      { "<leader>to", desc = "Test Output" },
      { "<leader>x", group = "Diagnostics/Quickfix", icon = { icon = "", color = "red" } },
      { "<leader>xq", desc = "Open Quickfix" },
      { "<leader>xl", desc = "Open Loclist" },
      { "<leader>w", group = "Window", icon = { icon = "", color = "cyan" } },
      { "[", group = "Previous", icon = { icon = "", color = "gray" } },
      { "[q", desc = "Quickfix Item" },
      { "[Q", desc = "First Quickfix" },
      { "]", group = "Next", icon = { icon = "", color = "gray" } },
      { "]q", desc = "Quickfix Item" },
      { "]Q", desc = "Last Quickfix" },
      { "g", group = "Goto", icon = { icon = "", color = "blue" } },
      { "z", group = "Fold", icon = { icon = "", color = "gray" } },
      { "gx", desc = "Open with System App", icon = { icon = "", color = "orange" } },
      { "<C-s>", desc = "Save File", icon = { icon = "", color = "green" }, mode = "i" },
      { "<C-g>", desc = "Exit Terminal Mode", icon = { icon = "", color = "red" }, mode = "t" },
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
