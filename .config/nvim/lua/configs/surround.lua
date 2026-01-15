local M = {}

function M.config()
  require("mini.surround").setup({
    mappings = {
      add = "sa",
      delete = "sd",
      find = "sf",
      find_left = "sF",
      highlight = "sh",
      replace = "sr",
      update_n_lines = "sn",
    },
    search_method = "cover_or_next",
  })
end

return M
