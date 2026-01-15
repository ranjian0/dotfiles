local M = {}

function M.config()
  local hipatterns = require("mini.hipatterns")

  hipatterns.setup({
    highlighters = {
      hex_color = hipatterns.gen_highlighter.hex_color({ pattern = "#%x%x%x%x%x%x" }),
      shorthand = hipatterns.gen_highlighter.hex_color({ pattern = "#%x%x%x" }),
      todo = {
        pattern = "(TODO|FIXME|NOTE|HACK|XXX)",
        group = "MiniHipatternsTodo",
      },
    },
  })
end

return M
