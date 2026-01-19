local utils = require("core.utils")

local M = {}

function M.config()
  utils.safe_setup("neotest", function()
    require("neotest").setup({
      adapters = {
        require("neotest-python")({
          dap = { justMyCode = false },
          args = { "--log-level", "DEBUG" },
          runner = "pytest",
        }),
      },
      discovery = {
        enabled = true,
        randomize = false,
        simultaneous_factor = 1,
        filter_dir = function(name, relpath, root)
          return name ~= "node_modules" and name ~= ".venv"
        end,
      },
      running = {
        concurrent = true,
      },
      summary = {
        enabled = true,
        follow = true,
        expand_errors = true,
        open = "botright split | resize 15",
        mappings = {
          expand = { "<CR>", "<2-LeftMouse>" },
          expand_all = "e",
          output = "o",
          short = "O",
          jumpto = "i",
          run = "r",
          run_all = "R",
          debug = "d",
          close = { "q", "<Esc>" },
          help = "?",
        },
      },
      status = {
        enabled = true,
        virtual_text = false,
        signs = true,
      },
      diagnostic = {
        enabled = true,
      },
      icons = {
        passed = "",
        failed = "",
        running = "⏳",
        unknown = "?",
        skipped = "○",
      },
      output = {
        enabled = true,
        open_on_run = "short",
      },
      floating = {
        border = "rounded",
        max_height = 0.8,
        max_width = 0.9,
        options = {},
      },
      highlight = {
        name = "Neotest",
      },
    })
  end)
end

return M
