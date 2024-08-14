local M = {}

function M.config()
    require('venv-selector').setup {
      ft = "python",
    }
end

return M
