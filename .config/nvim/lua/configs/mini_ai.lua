local M = {}

function M.config()
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
end

return M
