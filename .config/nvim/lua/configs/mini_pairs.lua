local M = {}

function M.config()
  require("mini.pairs").setup({
    modes = { insert = true, command = true, terminal = false },
    mappings = {
      ["("] = { action = "open", pair = "()", neigh_pattern = "[^\\].", register = { cr = false } },
      ["["] = { action = "open", pair = "[]", neigh_pattern = "[^\\].", register = { cr = false } },
      ["{"] = { action = "open", pair = "{}", neigh_pattern = "[^\\].", register = { cr = false } },
      [")"] = { action = "close", pair = "()", neigh_pattern = "[^\\].", register = { cr = false } },
      ["]"] = { action = "close", pair = "[]", neigh_pattern = "[^\\].", register = { cr = false } },
      ["}"] = { action = "close", pair = "{}", neigh_pattern = "[^\\].", register = { cr = false } },
      ['"'] = { action = "closeopen", pair = '""', neigh_pattern = "[^\\].", register = { cr = false } },
      ["'"] = { action = "closeopen", pair = "''", neigh_pattern = "[^\\%a][^%a%w]", register = { cr = false } },
      ["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^\\].", register = { cr = false } },
    },
  })
end

return M
