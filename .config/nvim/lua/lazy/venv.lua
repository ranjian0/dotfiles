local utils = require("core.utils")

local M = {}

function M.config()
  utils.safe_setup("venv-selector", function()
    require('venv-selector').setup({
      ft = "python",
    })
  end)
end

return M
