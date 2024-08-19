local M = {}

function M.config()
  require('noice').setup {}
  require('lspsaga').setup {
    lightbulb = {
      enable = false,
    }
  }
end

return M
