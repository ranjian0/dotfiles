local M = {}

function M.config()
    require('bufferline').setup {
        options = {
            always_show_bufferline = false,
            offsets = {
                { filetype = "neo-tree", text = "Neo-tree", text_align = "left", highlight = "Directory" },
            },
        }
    }
end

return M
