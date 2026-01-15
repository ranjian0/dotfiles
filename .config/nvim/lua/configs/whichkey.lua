local M = {}

function M.config()
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

    -- Find group
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

    -- Git group
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

    -- Harpoon group
    { "<leader>h", group = "Harpoon", icon = { icon = "", color = "purple" } },
    { "<leader>ha", desc = "Add File" },
    { "<leader>hr", desc = "Remove File" },
    { "<leader>hh", desc = "Toggle Menu" },
    { "<leader>ht", desc = "Telescope" },

    -- LSP group
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

    -- Quit/Session group
    { "<leader>q", group = "Quit/Session", icon = { icon = "", color = "red" } },
    { "<leader>qq", desc = "Quit All" },
    { "<leader>ps", desc = "Save Session" },
    { "<leader>pl", desc = "Load Session" },
    { "<leader>pd", desc = "Delete Session" },

    -- Search/Replace group
    { "<leader>s", group = "Search/Replace", icon = { icon = "", color = "purple" } },
    { "<leader>sr", desc = "Search Replace" },
    { "<leader>sw", desc = "Search Current File" },
    { "<leader>sp", desc = "Search Selection" },

    -- Testing group
    { "<leader>t", group = "Testing", icon = { icon = "", color = "yellow" } },
    { "<leader>tr", desc = "Run Test" },
    { "<leader>tf", desc = "Run File Tests" },
    { "<leader>td", desc = "Debug Test" },
    { "<leader>ts", desc = "Test Summary" },
    { "<leader>to", desc = "Test Output" },

    -- Terminal group
    { "<leader>t", group = "Terminal", icon = { icon = "", color = "green" } },
    { "<leader>tt", desc = "Toggle Tab" },
    { "<leader>tn", desc = "Toggle New" },
    { "<leader>tf", desc = "Toggle Float" },
    { "<leader>th", desc = "Toggle Horizontal" },
    { "<leader>tv", desc = "Toggle Vertical" },

    -- Diagnostics/Quickfix group
    { "<leader>x", group = "Diagnostics/Quickfix", icon = { icon = "", color = "red" } },
    { "<leader>xq", desc = "Open Quickfix" },
    { "<leader>xl", desc = "Open Loclist" },

    -- Window group
    { "<leader>w", group = "Window", icon = { icon = "", color = "cyan" } },

    -- Previous/Next groups
    { "[", group = "Previous", icon = { icon = "", color = "gray" } },
    { "[q", desc = "Quickfix Item" },
    { "[Q", desc = "First Quickfix" },
    { "]", group = "Next", icon = { icon = "", color = "gray" } },
    { "]q", desc = "Quickfix Item" },
    { "]Q", desc = "Last Quickfix" },

    -- Other groups
    { "g", group = "Goto", icon = { icon = "", color = "blue" } },
    { "z", group = "Fold", icon = { icon = "", color = "gray" } },
    { "gx", desc = "Open with System App", icon = { icon = "", color = "orange" } },

    -- Insert mode
    { "<C-s>", desc = "Save File", icon = { icon = "", color = "green" }, mode = "i" },

    -- Terminal mode
    { "<C-g>", desc = "Exit Terminal Mode", icon = { icon = "", color = "red" }, mode = "t" },
  })
end

return M
