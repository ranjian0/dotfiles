local M = {}

function M.config()
  require('noice').setup {}
  require('lspsaga').setup {}
end

return M
