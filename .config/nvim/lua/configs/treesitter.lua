local M = {}
function M.config()
  -- nvim-treesitter config
  require 'nvim-treesitter.configs'.setup {
    -- ensure_installed = "maintained", -- for installing all maintained parsers
    ensure_installed = {
      "c", "lua", "luadoc", "vim", "vimdoc", "query",     -- recommended mandatory
      "python", "nim", "bash", "cpp", "dockerfile", "go", "glsl", "html", "javascript", "json",
      "markdown", "markdown_inline", "nginx", "rst", "rust", "sql", "toml", "typescript", "wgsl", "yaml", "zig"
    },                       -- for installing specific parsers
    sync_install = false,    -- install asynchronously to avoid blocking startup
    ignore_install = {},     -- parsers to not install
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,       -- disable standard vim highlighting
    },
  }
end

return M
