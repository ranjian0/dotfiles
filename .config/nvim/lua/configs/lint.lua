local M = {}

function M.config()
  local lint = require("lint")

  lint.linters_by_ft = {
    javascript = { "eslint" },
    javascriptreact = { "eslint" },
    typescript = { "eslint" },
    typescriptreact = { "eslint" },
    python = { "ruff" },
    markdown = { "markdownlint" },
    bash = { "shellcheck" },
    sh = { "shellcheck" },
  }

  local function is_modifiable_buffer()
    return vim.bo.modifiable
  end

  local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

  vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
    group = lint_augroup,
    callback = function()
      if not is_modifiable_buffer() then return end
      lint.try_lint()
    end,
  })
end

return M
