local utils = require("core.utils")

local M = {}

function M.config()
  utils.safe_setup("mini.ai", function()
    local mini_ai = require("mini.ai")
    mini_ai.setup({
      n_lines = 500,
      custom_textobjects = {
        o = mini_ai.gen_spec.treesitter({
          a = { "@block.outer", "@conditional.outer", "@loop.outer" },
          i = { "@block.inner", "@conditional.inner", "@loop.inner" },
        }, {}),
        f = mini_ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
        c = mini_ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
        t = { query = { "@tag.outer" }, query_group = "treesitter" },
        d = { query = { "@comment.outer" }, query_group = "treesitter" },
      },
      silent = true,
    })
  end)

  utils.safe_setup("mini.pairs", function()
    require("mini.pairs").setup({
      modes = { insert = true, command = true, terminal = true },
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
  end)

  utils.safe_setup("mini.surround", function()
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
  end)

  utils.safe_setup("Comment", function()
    require("Comment").setup({})
  end)

  utils.safe_setup("better_escape", function()
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
  end)
end

return M
