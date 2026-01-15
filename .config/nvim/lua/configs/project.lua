local M = {}

function M.config()
  require("project_nvim").setup({
    manual_mode = false,
    detection_methods = { "lsp", "pattern" },
    patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Cargo.toml", "go.mod", "pom.xml" },
    exclude_lsp = {},
    ignore_lsp = {},
    silent_chdir = true,
    scope_chdir = "global",
    datapath = vim.fn.stdpath("data"),
  })

  require("telescope").load_extension("projects")
end

return M
