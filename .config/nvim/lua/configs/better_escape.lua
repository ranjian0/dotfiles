local M = {}

function M.config()
  require("better_escape").setup({
    timeout = vim.o.timeoutlen,
    default_mappings = false,
    mappings = {
      i = {
        j = {
          k = "<Esc>",
          j = "<Esc>",
        },
      },
    },
  })
end

return M
