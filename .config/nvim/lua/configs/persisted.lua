local M = {}

function M.config()
  require("persisted").setup({
    save_dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"),
    command = "VimSessionLoad",
    lazy = false,
    autoload = false,
    autoremove = false,
    autosave = true,
    follow_cwd = true,
    git_use_branch = true,
    auto_save_no_events = {
      "VimLeavePre",
      "TabLeave",
      "BufWinLeave",
    },
  })
end

return M
