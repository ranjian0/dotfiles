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
      { "<leader><tab>n", desc = "New Tab" },
      { "<leader><tab>c", desc = "Close Tab" },
      { "<leader><tab>]", desc = "Next Tab" },
      { "<leader><tab>[", desc = "Previous Tab" },
      { "<leader><tab>l", desc = "Last Tab" },
      { "<leader><tab>f", desc = "First Tab" },

      { "<leader>b", group = "Buffer", icon = { icon = "", color = "blue" } },
      { "<leader>bn", desc = "Next Buffer" },
      { "<leader>bp", desc = "Previous Buffer" },
      { "<leader>bd", desc = "Delete Buffer" },
      { "<leader>bs", desc = "Save Buffer" },

      { "<leader>e", desc = "File Explorer" },
      { "<leader>n", desc = "Notification History" },
      { "<leader><space>", desc = "Smart Find Files" },
      { "<leader>,", desc = "Buffers" },
      { "<leader>/", desc = "Grep" },
      { "<leader>:", desc = "Command History" },

      { "<leader>c", group = "Code", icon = { icon = "", color = "green" } },
      { "<leader>ca", desc = "Code Action" },
      { "<leader>cr", desc = "Rename" },
      { "<leader>cf", desc = "Format" },
      { "<leader>cS", desc = "Tabs to Spaces" },
      { "<leader>cT", desc = "Spaces to Tabs" },
      { "<leader>cW", desc = "Trim Whitespace" },

      { "<leader>f", group = "File & Find", icon = { icon = "", color = "blue" } },
      { "<leader>ff", desc = "Find Files (Root)" },
      { "<leader>fc", desc = "Find Config File" },
      { "<leader>fg", desc = "Find Files (Git)" },
      { "<leader>fe", desc = "File Tree" },
      { "<leader>fb", desc = "Buffers" },
      { "<leader>fr", desc = "Recent Files" },
      { "<leader>fp", desc = "Projects" },
      { "<leader>fs", group = "Search", icon = { icon = "", color = "blue" } },
      { "<leader>fsg", desc = "Live Grep" },
      { "<leader>fsr", desc = "Search & Replace" },
      { "<leader>fsw", desc = "Search Current File" },

      { "<leader>g", group = "Git", icon = { icon = "", color = "orange" } },
      { "<leader>gg", desc = "LazyGit" },
      { "<leader>gd", desc = "Git Diff (Hunks)" },
      { "<leader>gf", desc = "Git Log File" },
      { "<leader>gb", desc = "Git Branches" },
      { "<leader>gs", desc = "Git Status" },
      { "<leader>gS", desc = "Git Stash" },
      { "<leader>gl", desc = "Git Log" },
      { "<leader>gL", desc = "Git Log Line" },
      { "<leader>gi", desc = "GitHub Issues (open)" },
      { "<leader>gI", desc = "GitHub Issues (all)" },
      { "<leader>gp", desc = "GitHub PRs (open)" },
      { "<leader>gP", desc = "GitHub PRs (all)" },
      { "<leader>gc", desc = "Commits" },
      { "<leader>gh", group = "Hunks", icon = { icon = "", color = "yellow" } },
      { "<leader>ghu", desc = "Undo Stage" },
      { "<leader>ghn", desc = "Next Hunk" },
      { "<leader>ghN", desc = "Prev Hunk" },
      { "<leader>ghc", desc = "Preview Hunk" },
      { "<leader>ghr", desc = "Reset Hunk" },
      { "<leader>ghR", desc = "Reset Buffer" },
      { "<leader>ghl", desc = "Blame Line" },
      { "<leader>ghd", desc = "Diff This" },
      { "<leader>ghs", desc = "Select Hunk" },

      { "<leader>h", group = "Bookmarks", icon = { icon = "", color = "purple" } },
      { "<leader>ha", desc = "Add Bookmark" },
      { "<leader>hr", desc = "Remove Bookmark" },
      { "<leader>hh", desc = "Bookmarks" },
      { "<leader>ht", desc = "Recent Files" },

      { "<leader>k", group = "Keymaps/Help", icon = { icon = "", color = "cyan" } },
      { "<leader>kk", desc = "Show Keymaps" },
      { "<leader>kh", desc = "Help" },
      { "<leader>km", desc = "Mason" },
      { "<leader>kl", desc = "Lazy" },
      { "<leader>kc", desc = "Virtualenv" },

      { "<leader>l", group = "LSP", icon = { icon = "", color = "blue" } },
      { "<leader>ld", desc = "Go to Definition" },
      { "<leader>lg", desc = "Go to Declaration" },
      { "<leader>lr", desc = "Go to References" },
      { "<leader>li", desc = "Go to Implementation" },
      { "<leader>lt", desc = "Go to Type Definition" },
      { "<leader>ls", desc = "LSP Symbols" },
      { "<leader>lS", desc = "LSP Workspace Symbols" },
      { "<leader>lci", desc = "Calls Incoming" },
      { "<leader>lco", desc = "Calls Outgoing" },
      { "<leader>lh", desc = "Signature Help" },
      { "<leader>lk", desc = "Hover Doc" },
      { "<leader>lq", desc = "Diagnostics to Loclist" },

      { "<leader>o", group = "Opencode/AI", icon = { icon = "", color = "cyan" } },
      { "<leader>oi", group = "Input", icon = { icon = "", color = "cyan" } },
      { "<leader>oio", desc = "Open Input" },
      { "<leader>oin", desc = "New Session" },
      { "<leader>oo", group = "Output", icon = { icon = "", color = "cyan" } },
      { "<leader>ooo", desc = "Open Output" },
      { "<leader>os", group = "Session", icon = { icon = "", color = "cyan" } },
      { "<leader>oss", desc = "Select Session" },
      { "<leader>osr", desc = "Rename Session" },
      { "<leader>og", desc = "Toggle" },
      { "<leader>oq", desc = "Close" },
      { "<leader>o/", desc = "Quick Chat" },
      { "<leader>od", group = "Diff", icon = { icon = "", color = "cyan" } },
      { "<leader>odo", desc = "Open Diff" },
      { "<leader>od]", desc = "Next Diff" },
      { "<leader>od[", desc = "Prev Diff" },
      { "<leader>odc", desc = "Close Diff" },
      { "<leader>odx", desc = "Swap Position" },
      { "<leader>op", desc = "Configure Provider" },
      { "<leader>oz", desc = "Toggle Zoom" },

      { "<leader>q", group = "Quit/Session", icon = { icon = "", color = "red" } },
      { "<leader>qq", desc = "Quit All" },
      { "<leader>qs", desc = "Save Session" },
      { "<leader>ql", desc = "Load Session" },
      { "<leader>qd", desc = "Delete Session" },

      { "<leader>s", group = "Search", icon = { icon = "", color = "purple" } },
      { '<leader>s"', desc = "Registers" },
      { '<leader>s/', desc = "Search History" },
      { "<leader>sa", desc = "Autocmds" },
      { "<leader>sb", desc = "Buffer Lines" },
      { "<leader>sB", desc = "Grep Open Buffers" },
      { "<leader>sc", desc = "Command History" },
      { "<leader>sC", desc = "Commands" },
      { "<leader>sh", desc = "Help Pages" },
      { "<leader>sH", desc = "Highlights" },
      { "<leader>si", desc = "Icons" },
      { "<leader>sj", desc = "Jumps" },
      { "<leader>sk", desc = "Keymaps" },
      { "<leader>sl", desc = "Location List" },
      { "<leader>sm", desc = "Marks" },
      { "<leader>sM", desc = "Man Pages" },
      { "<leader>sp", desc = "Lazy Plugin Search" },
      { "<leader>sq", desc = "Quickfix List" },
      { "<leader>sR", desc = "Resume Picker" },
      { "<leader>sg", desc = "Grep" },
      { "<leader>sw", desc = "Grep Word/Selection" },

      { "<leader>t", group = "Tools", icon = { icon = "", color = "yellow" } },
      { "<leader>te", group = "Testing", icon = { icon = "", color = "yellow" } },
      { "<leader>ter", desc = "Run Test" },
      { "<leader>tef", desc = "Run File Tests" },
      { "<leader>ted", desc = "Debug Test" },
      { "<leader>tes", desc = "Test Summary" },
      { "<leader>teo", desc = "Test Output" },
      { "<leader>to", group = "Toggle", icon = { icon = "", color = "green" } },
      { "<leader>ton", desc = "Toggle Line Numbers" },
      { "<leader>tow", desc = "Toggle Line Wrap" },
      { "<leader>tos", desc = "Toggle Spell Check" },
      { "<leader>toz", desc = "Toggle Diagnostics" },
      { "<leader>ti", desc = "Toggle Indent Guides" },
      { "<leader>tc", desc = "Toggle Cursor Line" },
      { "<leader>ts", desc = "Toggle Status Column" },
      { "<leader>tr", desc = "Toggle Relative Numbers" },
      { "<leader>tt", desc = "Toggle Terminal", icon = { icon = "", color = "green" } },
      { "<leader>th", desc = "Terminal Horizontal" },
      { "<leader>tv", desc = "Terminal Vertical" },
      { "<leader>tf", desc = "Terminal Float" },
      { "<leader>tn", desc = "Terminal New" },
      { "<leader>tmt", desc = "Terminal Tab" },
      { "<leader>tmn", desc = "Terminal New" },
      { "<leader>tmf", desc = "Terminal Float" },
      { "<leader>tmh", desc = "Terminal Horizontal" },
      { "<leader>tmv", desc = "Terminal Vertical" },
      { "<leader>t1", desc = "Terminal 1" },
      { "<leader>t2", desc = "Terminal 2" },
      { "<leader>t3", desc = "Terminal 3" },
      { "<leader>t4", desc = "Terminal 4" },
      { "<leader>t5", desc = "Terminal 5" },

      { "<leader>u", group = "Undo/History", icon = { icon = "", color = "gray" } },
      { "<leader>uu", desc = "Undo History" },

      { "<leader>v", group = "Visual/Misc", icon = { icon = "", color = "cyan" } },
      { "<leader>vc", desc = "Colorscheme" },

      { "<leader>w", group = "Window", icon = { icon = "", color = "cyan" } },
      { "<leader>wh", desc = "Left Window" },
      { "<leader>wj", desc = "Lower Window" },
      { "<leader>wk", desc = "Upper Window" },
      { "<leader>wl", desc = "Right Window" },
      { "<leader>wH", desc = "Increase Height" },
      { "<leader>wJ", desc = "Decrease Height" },
      { "<leader>wK", desc = "Increase Width" },
      { "<leader>wL", desc = "Decrease Width" },

      { "<leader>x", group = "Quickfix/Loclist", icon = { icon = "", color = "red" } },
      { "<leader>xq", desc = "Open Quickfix" },
      { "<leader>xl", desc = "Open Loclist" },

      { "[", group = "Previous", icon = { icon = "", color = "gray" } },
      { "[q", desc = "Quickfix Item" },
      { "[Q", desc = "First Quickfix" },

      { "]", group = "Next", icon = { icon = "", color = "gray" } },
      { "]q", desc = "Quickfix Item" },
      { "]Q", desc = "Last Quickfix" },

      { "g", group = "Goto", icon = { icon = "", color = "blue" } },
      { "z", group = "Fold", icon = { icon = "", color = "gray" } },
      { "zM", desc = "Fold All" },
      { "zR", desc = "Unfold All" },
      { "z0", desc = "Fold Level 0 (None)" },
      { "z1", desc = "Fold Level 1" },
      { "z2", desc = "Fold Level 2" },
      { "z3", desc = "Fold Level 3" },
      { "gx", desc = "Open with System App", icon = { icon = "", color = "orange" } },

      { "<C-s>", desc = "Save File", icon = { icon = "", color = "green" }, mode = "i" },
      { "<C-g>", desc = "Exit Terminal Mode", icon = { icon = "", color = "red" }, mode = "t" },
      { "<C-h>", desc = "Go to Left Window", mode = "n" },
      { "<C-j>", desc = "Go to Lower Window", mode = "n" },
      { "<C-k>", desc = "Go to Upper Window", mode = "n" },
      { "<C-l>", desc = "Go to Right Window", mode = "n" },
      { "<C-Up>", desc = "Increase Window Height", mode = "n" },
      { "<C-Down>", desc = "Decrease Window Height", mode = "n" },
      { "<C-Left>", desc = "Decrease Window Width", mode = "n" },
      { "<C-Right>", desc = "Increase Window Width", mode = "n" },
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
